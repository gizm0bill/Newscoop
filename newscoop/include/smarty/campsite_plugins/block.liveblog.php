<?php
/**
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 * Liveblog block
 *
 * @param array $params
 * @param string $content
 * @param Smarty_Internal_Template $template
 * @param bool $repeat
 * @return string
 */
function smarty_block_liveblog(array $params, $content, Smarty_Internal_Template $template, &$repeat)
{
    if (empty($params['id']) || !is_numeric($params['id'])) {
        return;
    }

    $blog = Zend_Registry::get('container')->getService('livedesk.blog')->find($params['id']);
    if ($blog === null) {
        $repeat = false;
        return;
    }

    if ($repeat) {
        $template->assign('liveblog', $blog);
    } else {
        $script = <<<EOT
<script src="%s"></script>
<script src="%s"></script>
<script src="%s"></script>
<script>
$(function() {
    var livedesk = new LivedeskView({el: $('%s').first()});
    livedesk.collection.url = %s;
    livedesk.reset(%s);
});
</script>
EOT;
        $view = $template->getTemplateVars('view');
        return $content . sprintf($script,
            $view->baseUrl('/js/underscore.js'),
            $view->baseUrl('/js/backbone.js'),
            $view->baseUrl('/js/apps/livedesk.js'),
            !empty($params['el']) ? $params['el'] : '#liveblog-posts',
            json_encode($view->url(array('controller' => 'livedesk', 'action' => 'get-posts-after', 'id' => (int) $params['id']), 'default')),
            json_encode($blog->posts)
        );
    }
}
