{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00"}}

<!-- _tpl/img/img_980x306.tpl -->{{ strip }}
{{ image rendition="dossierbild" }}
<img src="{{ $image->src }}" width="{{ $image->width }}" height="{{ $image->height }}" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" />
{{ /image }}
{{ /strip }}<!-- _tpl/img/img_980x306.tpl -->

{{ else }}

<!-- _tpl/img/img_980x306.tpl -->{{ strip }}
{{ if $gimme->article->has_image(2) }}
  <img src="{{ uri options="image 2" }}" width="980" height="306" rel="resizable" alt="{{ $gimme->article->image2->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(1) }}
  <img src="{{ uri options="image 1 width 980 height 306 crop center" }}" width="980" height="306" rel="resizable" alt="{{ $gimme->article->image1->description }}" style="max-width: 100%">
{{ /if }}
{{ /strip }}<!-- _tpl/img/img_980x306.tpl -->

{{ /if }}