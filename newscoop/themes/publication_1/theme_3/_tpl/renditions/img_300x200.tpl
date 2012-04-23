{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00" }}

{{ strip }}
{{ image rendition="rubrikenseite" }}
<img src="{{ $image->src }}" width="{{ $image->width }}" height="{{ $image->height }}" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" />
{{ /image }}
{{ /strip }}

{{ else }}

<!-- _tpl/img/img_300x200.tpl -->{{ strip }}
{{ if $gimme->article->has_image(9) }}
  <img src="{{ uri options="image 9" }}" width="300" height="200" rel="resizable" alt="{{ $gimme->article->image9->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(7) }}
  <img src="{{ uri options="image 7 width 300 height 200 crop center" }}" width="300" height="200" rel="resizable" alt="{{ $gimme->article->image7->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(3) }}
  <img src="{{ uri options="image 3 width 300 height 200 crop center" }}" width="300" height="200" rel="resizable" alt="{{ $gimme->article->image3->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(1) }}
  <img src="{{ uri options="image 1 width 300 height 200 crop center" }}" width="300" height="200" rel="resizable" alt="{{ $gimme->article->image1->description }}" style="max-width: 100%">
{{ /if }}
{{ /strip }}<!-- _tpl/img/img_300x200.tpl -->

{{ /if }}
