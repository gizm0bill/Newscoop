{{ if !($gimme->article->Disable_Article_Image) }}

{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00"  }}

{{ assign var="i" value=0 }}
{{ foreach $gimme->article->slideshows as $slideshow name=slideshowlist }}
{{ foreach $slideshow->items as $item name=insideslideshow }}
{{ if $smarty.foreach.insideslideshow.first }}
<div class="image-slideshow tabs">
{{ /if }}   
{{ assign var="i" value=$i+1 }}          
{{ if $item->is_image }}  
         
                        <div id="image-{{ $i }}" class="img-content">
								<figure>
                        <a href="{{ $item->image->original }}" title="{{ $item->caption }}" class="fancybox-thumb" rel="fancybox-thumb">
                        <span></span>
                        	<img src="{{ $item->image->src }}" width="{{ $item->image->width }}" height="{{ $item->image->height }}" alt="{{ $item->caption }}" />
                        </a>
                        </figure> 
                        <p>{{ $item->caption }}</p>
                        </div>
                        
{{ else }}
								<div id="image-{{ $i }}" class="img-content">
								<figure>
								{{ video_player video=$item->video }}
								</figure>
								</div>
{{ /if }}
{{ /foreach }} 

{{ assign var="i" value=0 }}
{{ foreach $slideshow->items as $item name=insideslideshow }}
{{ if $smarty.foreach.insideslideshow.first }}                       
                        <ul class="slideshow-nav carousel jcarousel-skin-img-slider">
{{ /if }}
{{ assign var="i" value=$i+1 }}
{{ if $item->is_image }}                         
                        	<li><a href="#image-{{ $i }}"><img src="{{ $item->image->src }}" width="95" height="63" alt="{{ $item->caption }}" /></a></li>
{{ else }}         
									<li><a href="#image-{{ $i }}">poster</a></li>
{{ /if }}									               	
{{ if $smarty.foreach.insideslideshow.last }}
                        </ul>                      
                    </div>
{{ /if }}
{{ /foreach }}                    

{{ foreachelse }}{{* if no slideshow is attached to articles published after launch or redesigned site, show only image *}}

{{ if $gimme->article->publish_date gt "2012-05-07 13:00:00" || $gimme->article->creation_date gt "2012-05-07 13:00:00"  }}
	<figure>
		{{ include file="_tpl/renditions/img_647x431.tpl" }}
		<p>{{ $gimme->article->image->description }} {{ if !($gimme->article->image->photographer == "") }}(Bild: {{ $gimme->article->image->photographer }}){{ /if }}</p>
    </figure>
{{ elseif $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00"  }}	
	 <figure>
		{{ include file="_tpl/renditions/img_555x370.tpl" }}
		<p>{{ $gimme->article->image->description }} {{ if !($gimme->article->image->photographer == "") }}(Bild: {{ $gimme->article->image->photographer }}){{ /if }}</p>
    </figure>
{{ /if }}  
  
{{ /foreach }}
                    

{{ else }}{{* if publish date is before introduction of slideshows *}}

{{* check if article has big slideshow *}}
{{if $gimme->article->big_slideshow }}
{{ assign var="bigslideshow" value=1 }}
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
{{ assign var="i" value=0 }}
<div class="image-slideshow tabs">{{ strip }}
{{ /if }}
                        
{{ if !($gimme->article->vimeo_url == "") }}  
{{ if $slideshow gt 1 }}
{{ assign var="i" value=$i+1 }}
                            <div id="image-{{ $i }}" class="img-content">
{{ /if }}
{{ assign var="vimeocode" value=$gimme->article->vimeo_url|replace:"http://vimeo.com/":"" }}
<iframe src="http://player.vimeo.com/video/{{ $vimeocode }}?title=0&amp;byline=0&amp;portrait=0&amp;color=e20020" width="555" height="370" frameborder="0" webkitAllowFullScreen allowFullScreen></iframe>
{{ if $slideshow gt 1 }}
                            </div>
{{ /if }}
{{ /if }} 

{{ if !($gimme->article->youtube_shortcode == "") }}
{{ if $slideshow gt 1 }}
{{ assign var="i" value=$i+1 }}
                            <div id="image-{{ $i }}" class="img-content">
{{ /if }}
{{ assign var="youtubecode" value=$gimme->article->youtube_shortcode|replace:"http://youtu.be/":"" }}
<iframe title="YouTube video player" width="555" height="370" src="http://www.youtube.com/embed/{{ $youtubecode }}?rel=0 frameborder="0" allowfullscreen></iframe>
{{ if $slideshow gt 1 }}
                            </div>                            
{{ /if }}                                                        
{{ /if }} 

{{ if $hasimg gt 0 }}
{{ if $slideshow gt 1 }}
{{ assign var="i" value=$i+1 }}
                            <div id="image-{{ $i }}" class="img-content">
{{ /if }}
<figure>                                
{{ include file="_tpl/renditions/img_555x370.tpl" }}
</figure>
                                      <p>
{{ if $gimme->article->image->description != "" }}
{{ $gimme->article->image->description }} 
{{ else }}&nbsp;
{{ /if }}
{{ include file="_tpl/image-photographer.tpl" image=$gimme->article->image }}
</p>

{{ if $slideshow gt 1 }}
                            </div>
{{ /if }}               
{{ /if }} 

{{ list_article_images }}
{{ if ($gimme->image->article_index  gt 11) & ($gimme->image->article_index lt 100)}}                            
{{ assign var="i" value=$i+1 }}
                            <div id="image-{{ $i }}" class="img-content">
                            <figure>
                                        {{ if $bigslideshow == 1 }}<a href="{{ url options="image" }}" title="{{ $gimme->article->image->description }}" class="fancybox-thumb" rel="fancybox-thumb"><span></span>{{ /if }}<img src="{{ url options="image width 555 height 370 crop center" }}" width="555" height="370" rel="resizable" alt="{{ $gimme->article->image->description }}" title="{{ $gimme->article->image->description }}">{{ if $bigslideshow == 1 }}</a>{{ /if }}
                            </figure>
                                        <p>
{{ if $gimme->article->image->description != "" }}
{{ $gimme->article->image->description }} 
{{ else }}&nbsp;
{{ /if }}
{{ include file="_tpl/image-photographer.tpl" image=$gimme->article->image }}</p>
                                </div>
{{ /if }}                            
{{ /list_article_images }}                            






{{ if $slideshow gt 1 }}{{* initialize slideshow *}}
{{ assign var="i" value=0 }}
<ul class="slideshow-nav carousel jcarousel-skin-img-slider">
{{ /if }}
                        
{{ if !($gimme->article->vimeo_url == "") }}  
{{ if $slideshow gt 1 }}
{{ assign var="i" value=$i+1 }}
                            <li><a href="#image-{{ $i }}">
                                poster
                            </li>
{{ /if }}
{{ /if }} 

{{ if !($gimme->article->youtube_shortcode == "") }}
{{ if $slideshow gt 1 }}
{{ assign var="i" value=$i+1 }}
                            <li><a href="#image-{{ $i }}">
                                poster
                            </li>
{{ /if }}                                                        
{{ /if }} 

{{ if $hasimg gt 0 }}
{{ if $slideshow gt 1 }}
{{ assign var="i" value=$i+1 }}
                            <li><a href="#image-{{ $i }}"><img src="{{ url options="image 1 width 95 height 63 crop center" }}" width="95" height="63" alt="{{ $item->caption }}" /></a></li>
{{ /if }}               
{{ /if }} 

{{ list_article_images }}
{{ if ($gimme->image->article_index  gt 11) & ($gimme->image->article_index lt 100)}}                            
{{ assign var="i" value=$i+1 }}
                            <li><a href="#image-{{ $i }}"><img src="{{ url options="image width 95 height 63 crop center" }}" width="95" height="63" alt="{{ $item->caption }}" /></a></li>
{{ /if }}                            
{{ /list_article_images }}                            

{{ if $slideshow gt 1 }}
</ul>
</div>{{ /strip }}
{{ /if }}






{{ /if }}

{{ /if }}