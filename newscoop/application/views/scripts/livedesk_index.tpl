{{extends file="layout.tpl"}}

{{block content_classes}}content-box clearfix{{/block}}

{{block content}}
<section>
    <script type="text/template" id="item-template">
    <div class="result-content">
        <p class="result-text"><%= item.get('Content')  %></p>
        <p class="attributes"><i class="source-icon"></i> by <%= item.get('Creator').Name %>
            <time><%= item.getPublished() %></time>
            <a href="#" class="share"><i class="icon-share-alt"></i> Share</a>
        </p>
    </div>
    </script>

    {{ liveblog id=1 }}
    <h2><span style="color: #999">Liveblog</span> <span>{{ $liveblog->title }}</span></h2> 
    <p>{{ $liveblog->description }}</p>
    <div id="liveblog-posts"></div>
    {{ /liveblog }}
</section>
{{/block}}
