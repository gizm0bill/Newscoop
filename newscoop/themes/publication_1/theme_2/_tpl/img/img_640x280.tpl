{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00"}}

<!-- _tpl/img/img_640x280.tpl -->{{ strip }}
{{ image rendition="topfront" }}
<img src="{{ $image->src }}" width="{{ $image->width }}" height="{{ $image->height }}" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" />
{{ /image }}
{{ /strip }}<!-- _tpl/img/img_640x280.tpl -->

{{ else }}

<!-- _tpl/img/img_640x280.tpl -->{{ strip }}
{{ if $gimme->article->has_image(3) }}
  <img src="{{ uri options="image 3" }}" width="680" height="280" rel="resizable" alt="{{ $gimme->article->image3->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(1) }}
  <img src="{{ uri options="image 1 width 640 height 280 crop center" }}" width="680" height="280" rel="resizable" alt="{{ $gimme->article->image1->description }}" style="max-width: 100%">
{{ /if }}
{{ /strip }}<!-- _tpl/img/img_640x280.tpl -->

{{ /if }}