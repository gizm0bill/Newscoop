{{ if $gimme->article->type_name == "news" || $gimme->article->type_name == "newswire" }}
{{ render file="_article/article-news.tpl" }}
{{ /if }}
{{ if $gimme->article->type_name == "static_page" }}
{{ render file="_article/article-static.tpl" }}
{{ /if }}
{{ if $gimme->article->type_name == "dossier" }}
{{ render file="_article/article-dossier.tpl" }}
{{ /if }}
{{ if $gimme->article->type_name == "blog" }}
{{ render file="_article/article-blog.tpl" }}
{{ /if }}
{{ if $gimme->section->number == 71 }}
    {{ render file="_article/article_event.tpl" }}
{{ /if}}
{{ if $gimme->section->number == 72 }}
    {{ render file="_article/article_screening.tpl" }}
{{ /if}}
{{ if $gimme->section->number == 81 }}
    {{ render file="section.tpl" }}
{{ /if}}
