<!-- _tpl/section_listarticles.tpl -->
{{**************************************************

*}}

{{ list_articles }}
{{* spitzmarke *}}
{{ $gimme->article->dateline }}
{{* kommentare *}}
{{ if $gimme->article->comments_enabled && $gimme->article->content_accessible }}
  <a href="{{ uri options="article" }}#comments">
    {{ $gimme->article->comment_count }} Kommentare
  </a>
{{ /if }}
<img src="{{ uri options="image 1" }}" alt="{{ $gimme->article->image->description }}">
{{ $gimme->article->image->description }}
<h2><a href="{{ uri options="article" }}" rel="bookmark" title="{{ $gimme->article->name }}">{{ $gimme->article->name }}</a></h2>
{{* include file="_tpl/date_lastupdated.tpl" *}}
<p>Created: {{ $gimme->article->creation_date }} | Published: {{ $gimme->article->publish_date }} | Last update:  {{ $gimme->article->last_update }}
<p>{{* include file="_tpl/article-icons.tpl" *}}{{ $gimme->article->teaser }}</p> 
{{ include file="_tpl/link-readmore.tpl" }}
{{ /list_articles }}
<!-- / _tpl/section_listarticles.tpl -->