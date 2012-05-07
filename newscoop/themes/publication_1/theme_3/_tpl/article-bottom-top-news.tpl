        <div class="content-box full-width clearfix">
        
            <h3 class="title">Aktuell</h3>
         <div class="mobile-list-view header-fix clearfix">  
        	<div class="three-columns clearfix">
{{ assign var="curart" value=$gimme->article->number }}       
{{ assign var="counter" value=0 }}  	
{{ list_playlist_articles length="4" id="6" }} 
{{ if !($gimme->article->number == $curart) }}
{{ assign var="counter" value=$counter+1 }}       	
{{ if $counter lte 3 }}
                <article>
                    <figure>
                        <a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_300x200.tpl" }}</a>
                    </figure>
                    <header>
                        {{ if $gimme->article->comment_count gt 0 }}<a class="comments" href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }}</a>{{ /if }}
                        <p>{{ if $gimme->article->type_name == "blog" }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ elseif $gimme->article->type_name == "news" }}{{* $gimme->article->dateline *}}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->article->Newslinetext }}{{ /if }}{{ /if }}&nbsp;</p>
                    </header>
                    <h2><a href="{{ url options="article" }}">{{ if $gimme->article->type_name == "newswire" }}
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
{{ /if }}</a></h2>
                    <p>{{ strip }}<!-- {{ $gimme->article->type_name }} --> 
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
{{ /strip }}
{{ if $gimme->article->comment_count gt 0 }}<a href="{{ url options="article" }}#comments" class="comments mobile-hide">{{ $gimme->article->comment_count }} Kommentar{{ if $gimme->article->comment_count gt 1 }}e{{ /if }}</a>{{ /if }}</p>
                </article>
{{ /if }}  
{{ /if }}               
{{ /list_playlist_articles }}
            </div>
        	 </div>
        </div>