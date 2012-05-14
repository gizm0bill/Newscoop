{{ strip }}
{{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00" }}
  {{ image rendition="rubrikenseite" }}
    <div class="imgcontainer imgcontainerlist">
      <img src="{{ $image->src }}" rel="resizable" style="max-width: 100%" />
    </div>
  {{ /image }}
{{ else }}
  {{ list_article_images length="1" order="ByNumber asc" }}
    <div class="imgcontainer imgcontainerlist">
      <img src="{{ uri options="image width 300 height 200 crop center" }}" rel="resizable" style="max-width: 100%">
    </div>
  {{ /list_article_images }}
{{ /if }}
  
  
{{ if $gimme->article->type_name == "bloginfo" }}
  {{ $gimme->article->name|jsencode }}
  <h2>{{ $gimme->article->motto|truncate:60|jsencode }}</h2>
{{ else }}
  <h2>
  {{ if strlen($gimme->article->short_name) }}
    {{$gimme->article->short_name|truncate:80|jsencode }}
  {{ else }}
    {{ $gimme->article->name|truncate:80|jsencode }}
  {{ /if }}
  </h2>
{{ /if }}
{{ /strip }}