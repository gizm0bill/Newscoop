{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00"}}

{{ strip }}
{{ image rendition="dossierteaser" }}
<img src="{{ $image->src }}" width="{{ $image->width }}" height="{{ $image->height }}" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" />
{{ /image }}
{{ /strip }}

{{ else }}

{{ strip }}
{{ if $gimme->article->has_image(4) }}
  <img src="{{ uri options="image 4" }}" width="300" height="133" rel="resizable" alt="{{ $gimme->article->image4->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(3) }}
  <img src="{{ uri options="image 3 width 300 height 133 crop center" }}" width="300" height="133" rel="resizable" alt="{{ $gimme->article->image3->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(1) }}
  <img src="{{ uri options="image 1 width 300 height 133 crop center" }}" width="300" height="133" rel="resizable" alt="{{ $gimme->article->image1->description }}" style="max-width: 100%">
{{ /if }}
{{ /strip }}

{{ /if }}