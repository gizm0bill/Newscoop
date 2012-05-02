{{ list_playlist_articles length="5" id="6"}}

{{ if $gimme->current_list->index == 2 }}
<div class="mobile-list-view header-fix clearfix">
			<div class="two-columns clearfix">
{{ /if }}
{{ if $gimme->current_list->index == 4 }}
 <div class="mobile-list-view clearfix">
{{ /if }}			
            	<article>
						{{ if $gimme->current_list->index == 4 || $gimme->current_list->index == 5 }}	
                    <header>
                        <p>{{ if $gimme->article->type_name == "blog" }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ elseif $gimme->article->type_name == "news" }}{{ if !($gimme->article->dateline == "")}}<a href="{{ url options="article" }}">{{ $gimme->article->dateline }}</a>{{ else }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ /if }}{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}<a href="{{ url options="article" }}">{{ $gimme->article->dateline }}</a>{{ else }}<a href="{{ url options="article" }}">{{ $gimme->article->Newslinetext }}</a>{{ /if }}{{ /if }}&nbsp;</p>
                    </header>
                  {{ /if }}             	           	
            		{{ if $gimme->current_list->index == 1 }}<figure><a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_640x280.tpl" }}</a></figure>{{ /if }}
						{{ if $gimme->current_list->index == 2 || $gimme->current_list->index == 3 }}<figure><a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_300x200.tpl" }}</a></figure>{{ /if }}
						{{ if $gimme->current_list->index == 4 || $gimme->current_list->index == 5 }}<figure class="left"><a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_170x115.tpl" }}</a></figure>{{ /if }}

						{{ if $gimme->current_list->index < 4 }}	
                    <header>
                        <p>{{ if $gimme->article->type_name == "blog" }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ elseif $gimme->article->type_name == "news" }}{{ if !($gimme->article->dateline == "")}}<a href="{{ url options="article" }}">{{ $gimme->article->dateline }}</a>{{ else }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ /if }}{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}<a href="{{ url options="article" }}">{{ $gimme->article->dateline }}</a>{{ else }}<a href="{{ url options="article" }}">{{ $gimme->article->Newslinetext }}</a>{{ /if }}{{ /if }}&nbsp;</p>
                    </header>
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
</a></h2>
{{ else }}
<h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h2>
{{ /if }}

<p{{ if $gimme->current_list->index != 1 }} class="mobile-hide"{{ /if }}>{{ strip }}<!-- {{ $gimme->article->type_name }} --> 
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
{{ if $gimme->article->comment_count gt 0 }}<a href="{{ url options="article" }}#comments" class="comments">{{ $gimme->article->comment_count }} Kommentar{{ if $gimme->article->comment_count gt 1 }}e{{ /if }}</a>{{ /if }}
</p>
                </article>
{{ if $gimme->current_list->index == 3 }}                
         </div><!-- /.two-columns -->
</div> <!-- /.mobile-list-view header-fix clearfix -->         
{{ /if }}
{{ if $gimme->current_list->index == 5 }}
 </div> <!-- /.mobile-list-view clearfix -->
{{ /if }}
{{ /list_playlist_articles }}