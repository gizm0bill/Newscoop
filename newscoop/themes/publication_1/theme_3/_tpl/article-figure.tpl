{{ if !($gimme->article->Disable_Article_Image) }}

{{ if $gimme->article->publish_date gt "2012-05-07 13:00:00" || $gimme->article->creation_date gt "2012-05-07 13:00:00"  }}{{* solution for slideshows that comes with redesign *}}

{{ foreach $gimme->article->slideshows as $slideshow name=slideshowlist }}
<div class="image-slideshow tabs">
                    
                    	<h4>{{ $slideshow->headline }}</h4>
                        
                        <div id="image-1" class="img-content">
                        	<img src="{{ url static_file="pictures/slideshow-img-1.jpg" }}" alt="" />
                            <p>Still of Meryl Streep and Anthony Head in The Iron Lady (Bild: Dani Winter)</p>
                        </div>
                        <div id="image-2" class="img-content">
                        	<img src="{{ url static_file="pictures/slideshow-img-2.jpg" }}" alt="" />
                            <p>Another image caption</p>
                        </div>
                        <div id="image-3" class="img-content">
                        	<img src="{{ url static_file="pictures/slideshow-img-1.jpg" }}" alt="" />
                            <p>Still of Meryl Streep and Anthony Head in The Iron Lady (Bild: Dani Winter)</p>
                        </div>
                        <div id="image-4" class="img-content">
                        	<img src="{{ url static_file="pictures/slideshow-img-2.jpg" }}" alt="" />
                            <p>Still of Meryl Streep and Anthony Head in The Iron Lady (Bild: Dani Winter)</p>
                        </div>
                        <div id="image-5" class="img-content">
                        	<img src="{{ url static_file="pictures/slideshow-img-1.jpg" }}" alt="" />
                            <p>Still of Meryl Streep and Anthony Head in The Iron Lady (Bild: Dani Winter)</p>
                        </div>
                        <div id="image-6" class="img-content">
                        	<img src="{{ url static_file="pictures/slideshow-img-2.jpg" }}" alt="" />
                            <p>Still of Meryl Streep and Anthony Head in The Iron Lady (Bild: Dani Winter)</p>
                        </div>
                        <div id="image-7" class="img-content">
                        	<img src="{{ url static_file="pictures/slideshow-img-1.jpg" }}" alt="" />
                            <p>Still of Meryl Streep and Anthony Head in The Iron Lady (Bild: Dani Winter)</p>
                        </div>
                        <div id="image-8" class="img-content">
                        	<img src="{{ url static_file="pictures/slideshow-img-2.jpg" }}" alt="" />
                            <p>Still of Meryl Streep and Anthony Head in The Iron Lady (Bild: Dani Winter)</p>
                        </div>
                        
                        <ul class="slideshow-nav carousel jcarousel-skin-img-slider">
                        	<li><a href="#image-1"><img src="{{ url static_file="pictures/slideshow-thumb-1.jpg" }}" alt="" /></a></li>
                        	<li><a href="#image-2"><img src="{{ url static_file="pictures/slideshow-thumb-2.jpg" }}" alt="" /></a></li>
                        	<li><a href="#image-3"><img src="{{ url static_file="pictures/slideshow-thumb-3.jpg" }}" alt="" /></a></li>
                        	<li><a href="#image-4"><img src="{{ url static_file="pictures/slideshow-thumb-4.jpg" }}" alt="" /></a></li>
                        	<li><a href="#image-5"><img src="{{ url static_file="pictures/slideshow-thumb-1.jpg" }}" alt="" /></a></li>
                        	<li><a href="#image-6"><img src="{{ url static_file="pictures/slideshow-thumb-2.jpg" }}" alt="" /></a></li>
                        	<li><a href="#image-7"><img src="{{ url static_file="pictures/slideshow-thumb-3.jpg" }}" alt="" /></a></li>
                        	<li><a href="#image-8"><img src="{{ url static_file="pictures/slideshow-thumb-4.jpg" }}" alt="" /></a></li>
                        </ul>  
                    
                    </div>

{{ foreachelse }}{{* if no slideshow is attached to articles published after launch or redesigned site, show only image *}}

	<figure>
		{{ include file="_tpl/renditions/img_647x431.tpl" }}
    </figure>
    
{{ /foreach }}
                    
{{ elseif $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00"  }}

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
<div class="loader" style="height:431px">
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
<div class="loading" style="height:431px"></div></div>     
    {{ /if }}    
    {{ /foreach }}

{{ foreachelse }}

	<figure>
		{{ include file="_tpl/renditions/img_555x370.tpl" }}
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
<iframe title="YouTube video player" width="555" height="370" src="http://www.youtube.com/embed/{{ $youtubecode }}?wmode=opaque" frameborder="0" allowfullscreen></iframe>
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
{{ include file="_tpl/renditions/img_555x370.tpl" }}
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
                                        {{ if $bigslideshow == 1 }}<a href="{{ url options="image" }}" title="{{ $gimme->article->image->description }}" class="big_slideshow_list" rel="bigslideshow">{{ /if }}<img src="{{ url options="image width 555 height 370 crop center" }}" width="555" height="370" rel="resizable" alt="{{ $gimme->article->image->description }}" title="{{ $gimme->article->image->description }}">{{ if $bigslideshow == 1 }}<div class="zoomie"></div></a>{{ /if }}
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
<div class="loading" style="height:431px"></div></div>
{{ /if }}

{{ /if }}

{{ /if }}