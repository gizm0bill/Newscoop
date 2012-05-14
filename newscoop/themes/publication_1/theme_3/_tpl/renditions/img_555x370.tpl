{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00"}}

{{ strip }}
{{ image rendition="artikel" }}
<img src="{{ $image->src }}" width="555" height="370" rel="resizable" style="max-width: 100%; height: auto" alt="{{ $image->photographer }}: {{ $image->caption }}" />
{{ /image }}
{{ /strip }}

{{ else }}

<!-- _555x370 -->{{ strip }}
{{ if $gimme->article->has_image(7) }}
  <img src="{{ uri options="image 7" }}" width="555" height="370" rel="resizable" alt="{{ $gimme->article->image7->description }}" style="max-width: 100%;">
{{ elseif $gimme->article->has_image(1) }}
  {{ if $gimme->article->big_slideshow }}<a href="{{ uri options="image 1" }}" title="{{ $gimme->article->image1->description }}" class="big_slideshow_list" rel="bigslideshow">{{ /if }}
  <img src="{{ uri options="image 1 width 555 height 370 crop center" }}" width="555" height="370" rel="resizable" alt="{{ $gimme->article->image1->description }}" title="{{ $gimme->article->image1->description }}" style="max-width: 100%;">
  {{ if $gimme->article->big_slideshow }}<div class="zoomie"></div></a>{{ /if }}
{{ /if }}
{{ /strip }}<!-- 555x370 -->

{{ /if }}