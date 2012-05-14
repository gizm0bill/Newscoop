<!-- _tpl/list-article-teaser-front.tpl -->


<article>

<header>
<p>{{ if $gimme->article->type_name == "blog" }}{{ $gimme->section->name }}{{ elseif $gimme->article->type_name == "news" }}{{ $gimme->article->dateline }}{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->article->Newslinetext }}{{ /if }}{{ /if }}&nbsp;</p>
{{ if $gimme->article->comments_enabled }}
<small><a href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a></small>
{{ /if }}
{{ include file="_tpl/article_info_box.tpl" }}
</header>
{{ if $gimme->current_articles_list->index lt 4 }}
<figure>
<a href="{{ url options="article" }}">
{{ if $gimme->current_list->index == 1 }}{{ include file="_tpl/img/img_640x280.tpl" }}
{{ elseif $gimme->current_list->index lt 4 }}{{ include file="_tpl/img/img_300x200.tpl" }}{{ /if }}
</a>
</figure>
{{ /if }}
{{* for positions 2 and 3, show short_name - if exists, of course *}}
{{ if ($gimme->current_list->index gt 1) && ($gimme->current_list->index lt 4) }}
<h2>{{ if $gimme->article->type_name == "blog" }}
<a href="{{ url options="article" }}">
{{ else }}
<a href="{{ url options="article" }}">
{{ /if }}
{{ if $gimme->article->type_name == "newswire" }}
    {{ if !($gimme->article->short_name == "") }}
        {{ $gimme->article->short_name }}
    {{ elseif !($gimme->article->NewsLineText == "") }}
        {{ $gimme->article->NewsLineText }}
    {{ else }}
        {{ $gimme->article->HeadLine }}
    {{ /if }}
{{ else }}
    {{ if !($gimme->article->short_name == "") }}
        {{ $gimme->article->short_name }}
    {{ else }}
        {{ $gimme->article->name|replace:'  ':'<br />' }}
    {{ /if }}
{{ /if }}
</a>
{{ include file="_tpl/article_title_tooltip_box.tpl" }}
</h2>
{{ else }}
<h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a>
{{ include file="_tpl/article_title_tooltip_box.tpl" }}
</h2>
{{ /if }}
{{ include file="_tpl/admin_frontpageedit.tpl" }}

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

{{ list_related_articles }}
{{ if $gimme->current_list->at_beginning }}<ul class="details">{{ /if }}
  <li><time>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%y" }}: </time><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>  
{{ if $gimme->current_list->at_end }}</ul>{{ /if }}
{{ /list_related_articles }}
</article>

<!-- _tpl/list-article-teaser-front.tpl -->
