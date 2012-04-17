{{ if $gimme->article->type_name == "news" || $gimme->article->type_name == "newswire" }}
{{ render file="_article/article-news.tpl" }}
{{ /if }}
{{ if $gimme->article->type_name == "dossier" }}
{{ render file="_article/article-dossier.tpl" }}
{{ /if }}