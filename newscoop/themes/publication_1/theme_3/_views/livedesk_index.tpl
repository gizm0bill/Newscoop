{{extends file="layout.tpl"}}

{{block content_classes}}content-box clearfix{{/block}}

{{block content}}
<section>
    <h2 id="livedesk-title"><span style="color: #999">Livedesk</span> <span>{{ $blog->Title }}</span></h2> 
    <p id="livedesk-description">{{ $blog->Description }}</p>
    <div id="livedesk" class="livedesk"></div>

    <script type="text/template" id="item-template">
    <strong><%= item.getPublished() %></strong>
    <p><%= item.get('Content')  %><br /><em>by <%= item.get('Creator').Name %></em></p>
    </script>

    <script src="{{ url static_file="_js/libs/underbackbone.js" }}"></script>     
    <script src="{{ $view->baseUrl('js/apps/livedesk.js') }}"></script>
    <script>
    $(function() {
        var livedesk = new LivedeskView({el: $('#livedesk')});
        livedesk.reset({{ $posts }});
    });
    </script>
</section>
{{/block}}
