{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00"}}

<!-- _tpl/img/img_108x80.tpl -->{{ strip }}
{{ image rendition="rubrikenseite" width="108" height="80" }}
<img src="{{ $image->src }}" width="{{ $image->width }}" height="{{ $image->height }}" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" />
{{ /image }}
{{ /strip }}<!-- _tpl/img/img_108x80.tpl -->

{{ else }}

<!-- _tpl/img/img_108x80.tpl -->{{ strip }}
{{ if $gimme->article->has_image(10) }}
  <img src="{{ uri options="image 10" }}" width="108" height="80" rel="resizable" alt="{{ $gimme->article->image10->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(9) }}
  <img src="{{ uri options="image 9 width 108 height 80 crop center" }}" width="108" height="80" rel="resizable" alt="{{ $gimme->article->image9->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(7) }}
  <img src="{{ uri options="image 7 width 108 height 80 crop center" }}" width="108" height="80" rel="resizable" alt="{{ $gimme->article->image7->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(1) }}
  <img src="{{ uri options="image 1 width 108 height 80 crop center" }}" width="108" height="80" rel="resizable" alt="{{ $gimme->article->image1->description }}" style="max-width: 100%">
{{ /if }}
{{ /strip }}<!-- _tpl/img/img_108x80.tpl -->

{{ /if }}