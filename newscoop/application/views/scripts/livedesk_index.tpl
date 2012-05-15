{{extends file="layout.tpl"}}

{{block content_classes}}content-box clearfix{{/block}}

{{block content}}
<section>
    <script type="text/template" id="item-template">
    <strong><%= item.getPublished() %></strong>
    <p><%= item.get('Content')  %><br /><em>by <%= item.get('Creator').Name %></em></p>
    </script>

    {{ liveblog id=1 }}
    <h2><span style="color: #999">Liveblog</span> <span>{{ $liveblog->title }}</span></h2> 
    <p>{{ $liveblog->description }}</p>
    <div id="liveblog-posts"></div>
    {{ /liveblog }}
</section>
{{/block}}
