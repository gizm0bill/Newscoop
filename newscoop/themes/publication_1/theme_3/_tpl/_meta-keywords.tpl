<meta name="keywords" content="{{ strip }}
{{ if $gimme->article->defined }}

{{ if $gimme->article->keywords|strip_tags|trim !== "" }}
    {{ $gimme->article->keywords|strip_tags|escape:'html'|trim }}
{{ else }}
    {{ list_article_topics }}
        {{ $gimme->topic->name }}
        {{ if !($gimme->current_list->at_end) }}, {{ /if }}
    {{ /list_article_topics }}
{{ /if }}

{{ else }}
    
    {{ if $gimme->template->name == "front.tpl" }}
		{{ $siteinfo.keywords }}
    {{ elseif $gimme->template->name == "_tpl/section-standard.tpl" }}
    
{{ if $gimme->section->number == 10 }}

{{ /if }}
{{ if $gimme->section->number == 20 }}
 
{{ /if }}
{{ if $gimme->section->number == 30 }}

{{ /if }}
{{ if $gimme->section->number == 40 }}

{{ /if }}
{{ if $gimme->section->number == 50 }}

{{ /if }}
{{ if $gimme->section->number == 60 }}
 
{{ /if }}
{{ if $gimme->section->number == 71 }}

{{ /if }}
{{ if $gimme->section->number == 72 }}

{{ /if }}

	{{ elseif $gimme->template->name == "_tpl/section-dialog.tpl" }}

	{{ elseif $gimme->template->name == "_tpl/section-blog.tpl" }}
	{{ list_articles length="1" constraints="type is bloginfo" }}
		{{ $gimme->article->keywords|strip_tags|escape:'html'|trim }}
	{{ /list_articles }}
	{{ elseif $gimme->template->name == "_tpl/section-debatte.tpl" }}
	{{ list_articles length="1" constraints="type is deb_moderator" }}
		{{ $gimme->article->keywords|strip_tags|escape:'html'|trim }}
	{{ /list_articles }}
   {{ /if }}	
{{ /if }}
{{ /strip }}" />