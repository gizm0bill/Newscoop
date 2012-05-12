<?php
require_once  dirname(__FILE__) . DIR_SEP. 'TemplateCacheHandler.php';

class TemplateCacheHandler_DB extends TemplateCacheHandler
{
    private static $m_name = 'DB',
                   $m_description = "It allows to store template cache in a database.";
    private $_ado_db;

    public function TemplateCacheHandler_DB()
    {
        global $g_ado_db;
        $this->_ado_db = $g_ado_db;
    }

    /**
     * Returns true if the engine was supported in PHP, false otherwise.
     * @return boolean
     */
    public function isSupported()
    {
        return true;
    }

    /**
     * Clears template cache storage.
     */
    public function clean($tpl_file = null)
    {
        $cache_content = $smrty_obj = null;
        self::handler('clean', $smarty_obj, $cache_content, $tpl_file);
    }

    /**
     * Updates template cache storage by given campsite vector.
     */
    public function update($campsiteVector)
    {
        $queryStr = 'DELETE FROM Cache WHERE ' . self::vectorToWhereString($campsiteVector);
        $this->_ado_db->Execute($queryStr);

        if (!empty($campsiteVector['language']) && !empty($campsiteVector['publication'])) {
            $whereStr = "language = {$campsiteVector['language']} AND ";
            $whereStr .= "publication = {$campsiteVector['publication']} AND ";
            $whereStr .= $campsiteVector['issue'] ? "issue >= {$campsiteVector['issue']} AND "
            :'issue IS NULL AND ';

            // clear language, publication, issue, section, null vector
            if (isset($campsiteVector['section'])) {
                $queryStr = 'DELETE FROM Cache WHERE ' . $whereStr . "section = {$campsiteVector['section']} AND ";
                $queryStr .= "article IS NULL";
                $this->_ado_db->Execute($queryStr);
            }

            // clear language, publication, issue, null, null vector
            $queryStr = 'DELETE FROM Cache WHERE ' . $whereStr . "section IS NULL AND article IS NULL";
            $this->_ado_db->Execute($queryStr);

            // clear language, publication, null, null, null vector
            if (isset($campsiteVector['issue'])) {
                $queryStr = 'DELETE FROM Cache WHERE language = '. "{$campsiteVector['language']} AND "
                . "publication = {$campsiteVector['publication']} AND issue IS NULL AND section IS NULL AND article IS NULL";
                $this->_ado_db->Execute($queryStr);
            }
        }
        return;
    }


    /**
     * Returns a short description of the cache engine.
     * @return string
     */
    public function description()
    {
        return self::$m_description;
    }

    static function handler($action, &$smarty_obj, &$cache_content, $tpl_file = null, $cache_id = null,
        $compile_id = null, $exp_time = 0)
    {
        global $g_ado_db;
        static $cacheExists;
        $exp_time += time();

        $return = false;
        if ($action != 'clean') {
            $campsiteVector = $smarty_obj->campsiteVector;
            if (!isset($campsiteVector['params'])) {
                $campsiteVector['params'] = null;
            }
        }

        switch ($action) {
            case 'read':
                if (!empty($campsiteVector['language']) && !empty($campsiteVector['publication'])) {
                    $whereStr = self::vectorToWhereString($campsiteVector);
                    $whereStr .= " AND template = '$tpl_file'";

                    $queryStr = 'SELECT expired, content FROM Cache WHERE ' . $whereStr;
                    $result = $g_ado_db->GetRow($queryStr);
                    if ($result) {
                        if ($result['expired'] > time()) {
                            $cacheExists[$tpl_file] = true;
                            $cache_content = $result['content'];
                            $return = $result['expired'];
                        } else {
                            // clear expired cache
                            $queryStr = 'DELETE FROM Cache WHERE expired <= '. time();
                            $g_ado_db->Execute($queryStr);
                            $return = false;
                        }
                    }
                }
                break;

            case 'write':
                // in case template changing should delete old cached templates
                if (isset($cacheExists[$tpl_file])) {
                    $queryStr = 'DELETE FROM Cache WHERE template = ' . "'$tpl_file'";
                    $g_ado_db->Execute($queryStr);
                }
                if ($exp_time > time() && !empty($campsiteVector['language']) && !empty($campsiteVector['publication'])) {

                    // insert new cached template
                    $queryStr = 'INSERT IGNORE INTO Cache ';
                    $queryStr .= '(' . implode(',', array_keys($campsiteVector));
                    $queryStr .=  ',template,expired,content) VALUES (';
                    foreach ($campsiteVector as $key => $value) {
                        $queryStr .= !isset($value) ? 'NULL,' : $value . ',';
                    }
                    $queryStr .= "'$tpl_file',$exp_time,'" . addslashes($cache_content) . "')";
                    $g_ado_db->Execute($queryStr);
                    $return = $g_ado_db->Affected_Rows() > 0;
                }
                break;

            case 'clean':
                $queryStr = 'DELETE FROM Cache';
                if ($tpl_file) {
                    $queryStr .= " WHERE template = '$tpl_file'";
                }
                $g_ado_db->Execute($queryStr);
                $return = true;
                break;

            default:
        }
        return $return;
    }

    static function vectorToWhereString($vector)
    {
        $output = null;
        foreach ((array)$vector as $key => $value) {
            if (isset($value)) {
                $sqlValue = $key == 'params' ? "'" . addslashes($value) . "'" : $value;
                $output .= $key . ' = ' . $sqlValue;
            } else {
                $output .= $key . ' IS NULL';
            }
            $output .= ' AND ';
        }
        $output = substr($output, 0, strlen($output) - 4);
        return $output;
    }
}
