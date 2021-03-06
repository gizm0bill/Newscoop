<?php
/**
 * @package Campsite
 */

/**
 * Includes
 */
require_once($GLOBALS['g_campsiteDir'].'/classes/DatabaseObject.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/Log.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/Author.php');

/**
 * @package Campsite
 */
class AuthorAssignedType extends DatabaseObject
{
    const TABLE = 'AuthorAssignedTypes';

    public $m_dbTableName = self::TABLE;
    public $m_keyColumnNames = array('fk_author_id', 'fk_type_id');
    public $m_columnNames = array('fk_author_id', 'fk_type_id');

    /**
     * Constructor
     *
     * @param int $p_authorId
     * @param int $p_authorTypeId
     */
    public function __construct($p_authorId = null, $p_authorTypeId = null)
    {
        if (is_numeric($p_authorId)) {
            $this->m_data['fk_author_id'] = $p_authorId;
        }
        if (is_numeric($p_authorTypeId)) {
            $this->m_data['fk_type_id'] = $p_authorTypeId;
        }
    }

    /**
     * @return int
     */
    public function getAuthorId()
    {
        return (int) $this->m_data['fk_author_id'];
    }

    /**
     * @return int
     */
    public function getAuthorTypeId()
    {
        return (int) $this->m_data['fk_type_id'];
    }

    /**
     * @param int $p_authorId
     * @param int $p_authorTypeId
     * @return void
     */
    public static function AddAuthorTypeToAuthor($p_authorId, $p_authorTypeId)
    {
        global $g_ado_db;

        $queryStr = 'INSERT IGNORE INTO ' . self::TABLE . ' (fk_author_id, fk_type_id)
            VALUES (' . (int) $p_authorId . ', ' . (int) $p_authorTypeId . ')';
        $g_ado_db->Execute($queryStr);
        if (function_exists("camp_load_translation_strings")) {
            camp_load_translation_strings("api");
        }
        $logText = getGS('Author type $1 linked to author $2', $p_authorTypeId, $p_authorId);
        Log::Message($logText, null, 175);
    }

    /**
     * @param int $p_authorId
     */
    public static function GetAuthorTypesByAuthor($p_authorId)
    {
        global $g_ado_db;

        $queryStr = 'SELECT * FROM ' . self::TABLE . '
            WHERE fk_author_id = ' . $p_authorId;
        $query = $g_ado_db->Execute($queryStr);
        $authorTypes = array();
        while ($row = $query->FetchRow()) {
            $tmpAuthorType = new AuthorType();
            $tmpAuthorType->fetch($row);
            $authorTypes[] = $tmpAuthorType;
        }

        return $authorTypes;
    }

    /**
     * This is called when an author type is deleted.
     * It will disassociate the author type from all authors.
     *
     * @param int $p_authorTypeId
     * @return void
     */
    public static function OnAuthorTypeDelete($p_authorTypeId)
    {
        global $g_ado_db;

        $queryStr = 'DELETE FROM ' . self::TABLE . '
            WHERE fk_type_id = ' . (int) $p_authorTypeId;
        $g_ado_db->Execute($queryStr);
    }

    /**
     * Remove author type pointers for the given author.
     *
     * @param int $p_authorId
     * @return void
     */
    public static function OnAuthorDelete($p_authorId)
    {
        global $g_ado_db;

        $queryStr = 'DELETE FROM ' . self::TABLE . '
            WHERE fk_author_id = ' . $p_authorId;
        $g_ado_db->Execute($queryStr);
    }

    /**
     * @param int $p_authorId
     * @return void
     */
    public static function ResetAuthorAssignedTypes($p_authorId = null)
    {
        if (!is_null($p_authorId)) {
            self::OnAuthorDelete($p_authorId);
        } else {
            $queryStr = 'DELETE FROM ' . self::TABLE;
            $g_ado_db->Execute($queryStr);
        }
    }
}