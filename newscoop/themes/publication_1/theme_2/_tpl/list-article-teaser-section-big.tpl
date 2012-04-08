<!-- _tpl/list-article-teaser-section-big.tpl -->

<article class="{{ $gimme->article->type_name }}">
        <header style="width: 100%">
<p>{{ if $gimme->article->type_name == "blog" }}{{ $gimme->section->name }}{{ elseif $gimme->article->type_name == "news" }}{{ $gimme->article->dateline }}{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->article->Newslinetext }}{{ /if }}{{ /if }}&nbsp;</p>
{{ if $gimme->article->comments_enabled }}
<small><a href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a></small>
{{ /if }}
{{ include file="_tpl/article_info_box.tpl" }}
</header>

<figure>
<a href="{{ url options="article" }}">{{ include file="_tpl/img/img_300x200.tpl" }}</a>
</figure>
<h2 class="{{ $gimme->article->type_name }}"><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a>{{ include file="_tpl/article_title_tooltip_box.tpl" }}</h2>

<p class="{{ $gimme->article->type_name }}">{{ strip }}<!-- {{ $gimme->article->type_name }} --> 
{{ include file="_tpl/admin_frontpageedit.tpl" }}
  {{ if $gimme->article->type_name == "news" }}
    {{ $gimme->article->teaser|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  <a href="{{ url options="article" }}">Weiterlesen</a>
  {{ elseif $gimme->article->type_name == "newswire" }}
    {{ $gimme->article->DataLead|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  <a href="{{ url options="article" }}">Weiterlesen</a> 
  {{ elseif $gimme->article->type_name == "blog" }}
    {{ $gimme->article->lede|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  <a href="{{ url options="article" }}">Weiterlesen</a> 
  {{ /if }}  
{{ /strip }}</p>
</article>

<!-- _tpl/list-article-teaser-section-big.tpl -->
