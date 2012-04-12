{{ if !($gimme->article->Disable_Article_Image) }}

{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00"  }}

{{ foreach $gimme->article->slideshows as $slideshow name=slideshowlist }}
<script type="text/javascript">
$(document).ready(function() {
    $("a.big_slideshow_list").fancybox({
        type: 'image'
    });
});
</script>

    {{ foreach $slideshow->items as $item name=insideslideshow }}
    {{ if $smarty.foreach.insideslideshow.first }}

<ul id="article-single-carousel" class="jcarousel-skin-article-single">    
    {{ /if }}
    <li><figure>
        {{ if $item->is_image }}
        <a href="{{ $item->image->original }}" title="{{ $item->caption }}" class="big_slideshow_list" rel="bigslideshow"><img src="{{ $item->image->src }}" width="{{ $item->image->width }}" height="{{ $item->image->height }}" alt="{{ $item->caption }}" /><div class="zoomie"></div></a>
        {{ else }}
        {{ video_player video=$item->video }}
        {{ /if }}
        <p>{{ $item->caption }}&nbsp;{{ include file="_tpl/image-photographer.tpl" image=$item->image }}</p>
    </figure></li>
    {{ if $smarty.foreach.insideslideshow.last }}
</ul>
   
    {{ /if }}    
    {{ /foreach }}

{{ foreachelse }}
	<figure>
{{ image rendition="artikel" }}
<img src="{{ $image->src }}" width="{{ $image->width }}" height="{{ $image->height }}" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" />
        <p>{{ $image->caption }}&nbsp;{{ include file="_tpl/image-photographer.tpl" image=$image }}</p>
{{ /image }}
    </figure>
{{ /foreach }}

{{ else }}

{{* check if article has big slideshow *}}
{{if $gimme->article->big_slideshow }}
{{ assign var="bigslideshow" value=1 }}
<script type="text/javascript">
$(document).ready(function() {
    $("a.big_slideshow_list").fancybox({
        type: 'image'
    });
});
</script>
{{ /if }}

{{* Check if article has video attached *}}
{{ assign var="hasvideo" value=0 }}
{{ if (!($gimme->article->youtube_shortcode == "") || !($gimme->article->vimeo_url == "")) }}
{{ assign var="hasvideo" value=1 }}
{{ elseif (!($gimme->article->youtube_shortcode == "") && !($gimme->article->vimeo_url == "")) }}
{{ assign var="hasvideo" value=2 }}
{{ /if }}

{{* Check if article has images attached, and if there are more than one image (but don't count images greater_equal 100 *}}
{{ assign var="hasimg" value=0 }}
{{ list_article_images }}
{{ if $gimme->image->article_index lt 12 }}
    {{ assign var="hasimg" value=1 }}
{{ elseif $gimme->image->article_index lt 100 }}
    {{ assign var="hasimg" value=2 }}
{{ /if }}
{{ /list_article_images }}

{{ assign var="slideshow" value=$hasvideo+$hasimg }}

{{ if $slideshow gt 1 }}{{* initialize slideshow *}}
<div class="loader" style="height:431px">
            <ul id="article-single-carousel" class="jcarousel-skin-article-single">
{{ /if }}
                        
{{ if !($gimme->article->vimeo_url == "") }}  
{{ if $slideshow gt 1 }}
                            <li>
{{ /if }}
                                <figure>
{{ assign var="vimeocode" value=$gimme->article->vimeo_url|replace:"http://vimeo.com/":"" }}
<iframe src="http://player.vimeo.com/video/{{ $vimeocode }}?title=0&amp;byline=0&amp;portrait=0&amp;color=e20020" width="555" height="370" frameborder="0" webkitAllowFullScreen allowFullScreen></iframe>
                                </figure>
{{ if $slideshow gt 1 }}
                            </li>
{{ /if }}
{{ /if }} 

{{ if !($gimme->article->youtube_shortcode == "") }}
{{ if $slideshow gt 1 }}
                            <li>
{{ /if }}
                                <figure>
{{ assign var="youtubecode" value=$gimme->article->youtube_shortcode|replace:"http://youtu.be/":"" }}
<iframe title="YouTube video player" width="647" height="431" src="http://www.youtube.com/embed/{{ $youtubecode }}?wmode=opaque" frameborder="0" allowfullscreen></iframe>
                                </figure>
{{ if $slideshow gt 1 }}
                            </li>
{{ /if }}                                                        
{{ /if }} 

{{ if $hasimg gt 0 }}
{{ if $slideshow gt 1 }}
                            <li>
{{ /if }}
                                <figure>
{{ include file="_tpl/renditions/img_647x431.tpl" }}
                                      <p>
{{ if $gimme->article->image->description != "" }}
{{ $gimme->article->image->description }} 
{{ else }}&nbsp;
{{ /if }}
{{ include file="_tpl/image-photographer.tpl" image=$gimme->article->image }}
</p>
                                </figure>
{{ if $slideshow gt 1 }}
                            </li>
{{ /if }}               
{{ /if }} 

{{ list_article_images }}
{{ if ($gimme->image->article_index  gt 11) & ($gimme->image->article_index lt 100)}}                            
                            <li>
                                <figure>
                                        {{ if $bigslideshow == 1 }}<a href="{{ url options="image" }}" title="{{ $gimme->article->image->description }}" class="big_slideshow_list" rel="bigslideshow">{{ /if }}<img src="{{ url options="image width 647 height 431 crop center" }}" width="647" height="431" rel="resizable" alt="{{ $gimme->article->image->description }}" title="{{ $gimme->article->image->description }}">{{ if $bigslideshow == 1 }}<div class="zoomie"></div></a>{{ /if }}
                                        <p>
{{ if $gimme->article->image->description != "" }}
{{ $gimme->article->image->description }} 
{{ else }}&nbsp;
{{ /if }}
{{ include file="_tpl/image-photographer.tpl" image=$gimme->article->image }}</p>
                                </figure>
                            </li>
{{ /if }}                            
{{ /list_article_images }}                            

{{ if $slideshow gt 1 }}
</ul>
{{ /if }}

{{ /if }}

{{ /if }}