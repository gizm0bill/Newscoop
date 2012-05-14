{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00"}}

<!-- _tpl/img/img_470x313.tpl -->{{ strip }}
{{ image rendition="artikel" width="470" height="313" }}
<img src="{{ $image->src }}" width="{{ $image->width }}" height="{{ $image->height }}" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" />
{{ /image }}
{{ /strip }}<!-- _tpl/img/img_470x313.tpl -->

{{ else }}

<!-- _tpl/img/img_470x313.tpl -->{{ strip }}
{{ if $gimme->article->has_image(8) }}
  <img src="{{ uri options="image 8" }}" width="470" height="313" rel="resizable" alt="{{ $gimme->article->image8->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(7) }}
  <img src="{{ uri options="image 7 width 470 height 313 crop center" }}" width="470" height="313" rel="resizable" alt="{{ $gimme->article->image7->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(1) }}
  <img src="{{ uri options="image 1 width 470 height 313 crop center" }}" width="470" height="313" rel="resizable" alt="{{ $gimme->article->image1->description }}" style="max-width: 100%">
{{ /if }}
{{ /strip }}<!-- _tpl/img/img_470x313.tpl -->

{{ /if }}