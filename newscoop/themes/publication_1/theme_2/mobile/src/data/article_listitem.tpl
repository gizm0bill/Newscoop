{{ strip }}
{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00" }}
  {{ if isset($index) && $index == 1 }}
    {{ image rendition="rubrikenseite" }}
      <div class="imgcontainer imgcontainerfirst">
        <img src="{{ $image->src }}" rel="resizable" style="max-width: 100%" />
      </div>
    {{ /image }}
  {{ else }}
    {{ image rendition="naviteaser" }}
      <div class="imgcontainer imgcontainerlist">
        <img src="{{ $image->src }}" rel="resizable" style="max-width: 100%" />
      </div>
    {{ /image }}
  {{ /if }}
{{ else }}
  {{ if isset($index) && $index == 1 }}
    {{ if $gimme->article->has_image(9) }}
      <div class="imgcontainer imgcontainerfirst">
        <img src="{{ uri options="image 9" }}" width="300" height="200" rel="resizable" style="max-width: 100%">
      </div>
    {{ elseif $gimme->article->has_image(7) }}
      <div class="imgcontainer imgcontainerfirst">
        <img src="{{ uri options="image 7 width 300 height 200 crop center" }}" rel="resizable" style="max-width: 100%">
      </div>
    {{ elseif $gimme->article->has_image(1) }}
      <div class="imgcontainer imgcontainerfirst">
        <img src="{{ uri options="image 1 width 300 height 200 crop center" }}" rel="resizable" style="max-width: 100%">
      </div>
    {{ /if }}
  {{ else }}
    {{ if $gimme->article->has_image(6) }}
      <div class="imgcontainer imgcontainerlist">
        <img src="{{ uri options="image 6" }}" width="120" height="53" rel="resizable" style="max-width: 100%">
      </div>
    {{ elseif $gimme->article->has_image(4) }}
      <div class="imgcontainer imgcontainerlist">
        <img src="{{ uri options="image 4 width 120 height 53 crop center" }}" rel="resizable" style="max-width: 100%">
      </div>
    {{ elseif $gimme->article->has_image(3) }}
      <div class="imgcontainer imgcontainerlist">
        <img src="{{ uri options="image 3 width 120 height 53 crop center" }}" rel="resizable" style="max-width: 100%">
      </div>
    {{ elseif $gimme->article->has_image(1) }}
      <div class="imgcontainer imgcontainerlist">
        <img src="{{ uri options="image 1 width 120 height 53 crop center" }}" rel="resizable" style="max-width: 100%">
      </div>
    {{ /if }}
  {{ /if }}
{{ /if }}

{{ if $gimme->article->type_name == "newswire" }}
  {{ $gimme->section->name|jsencode }}
{{ else }}
  {{ $gimme->article->dateline|jsencode }}
{{ /if }}

<h2>{{ $gimme->article->name|jsencode }}</h2>
{{ /strip }}