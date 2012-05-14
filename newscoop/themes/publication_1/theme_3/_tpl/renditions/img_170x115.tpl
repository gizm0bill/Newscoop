{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00"}}

{{ strip }}
{{ capture name="_img" assign="_img" }}
{{ image rendition="rubrikenseite" width="170" height="115" }}
<img src="{{ $image->src }}" width="{{ $image->width }}" height="{{ $image->height }}" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" />
{{ /image }}
{{ /capture }}
{{ if trim($_img) }}<figure class="left">{{ /if }}<a href="{{ url options="article" }}">{{ $_img }}</a>{{ if $where="sec-standard" }}</figure>{{ /if }}
{{ /strip }}

{{ else }}

{{ strip }}
{{ if $gimme->article->has_image(10) }}
  <img src="{{ uri options="image 10" }}" width="170" height="115" rel="resizable" alt="{{ $gimme->article->image10->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(9) }}
  <img src="{{ uri options="image 9 width 170 height 115 crop center" }}" width="170" height="115" rel="resizable" alt="{{ $gimme->article->image9->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(7) }}
  <img src="{{ uri options="image 7 width 170 height 115 crop center" }}" width="170" height="115" rel="resizable" alt="{{ $gimme->article->image7->description }}" style="max-width: 100%">
{{ elseif $gimme->article->has_image(1) }}
  <img src="{{ uri options="image 1 width 170 height 115 crop center" }}" width="170" height="115" rel="resizable" alt="{{ $gimme->article->image1->description }}" style="max-width: 100%">
{{ /if }}
{{ /strip }}

{{ /if }}