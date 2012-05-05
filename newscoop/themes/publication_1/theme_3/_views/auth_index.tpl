{{extends file="layout.tpl"}}

{{block content}}
<section>
    <h2>Bitte loggen Sie sich ein</h2> 
    <p>Um diese Funktion nutzen zu können, müssen Sie bei der TagesWoche angemeldet sein. Falls sich das Login-Fenster nicht automatisch geöffnet hat, <a id="open-omnibox-text" href="#">klicken Sie bitte hier.</a>.</p>
</section>
<script>
$(function() {
    $('#open-omnibox-text').click(function(e) {
        omnibox.show();
        return false;
    });

    omnibox.afterLogin = function() {
        window.location = {{ json_encode($view->url(['controller' => 'dashboard', 'action' => 'index'], 'default')) }};
    };

    setTimeout("omnibox.show()", 1);
});
</script>
{{/block}}
