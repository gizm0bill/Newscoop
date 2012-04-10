{{ if $gimme->article->type_name == "news" }}
{{ render file="_article/article_typenews.tpl" }}
{{ elseif $gimme->article->type_name == "newswire" }}
{{ if $gimme->article->behave_as_news }}{{* if newswire article is edited and marked to behave as news article *}}
{{ render file="_article/article_typenews.tpl" }}
{{ else }}
{{ render file="_article/article_typenewswire.tpl" }}
{{ /if }}
{{ elseif $gimme->article->type_name == "eventnews" }}
{{ include file="_article/article_typenews.tpl" }}
{{ elseif $gimme->article->type_name == "pinnwand" }}
{{ include file="section_pinboard.tpl" }}
{{ elseif $gimme->article->type_name == "event" }}
{{ include file="_article/article_typeevent.tpl" }}
{{ elseif $gimme->article->type_name == "screening" }}
{{ include file="_article/article_typemovie.tpl" }}
{{ elseif $gimme->article->type_name == "blog" }}
{{ include file="_article/article_typeblog.tpl" }}
{{ elseif $gimme->article->type_name == "bloginfo" }}
{{ include file="blog_section.tpl" }}
{{ elseif $gimme->article->type_name == "static_page" }}
{{ include file="_article/article_typestaticpage.tpl" }}
{{ elseif $gimme->article->type_name == "dossier" }}
{{ include file="_article/article_dossier.tpl" }}
{{ elseif $gimme->article->type_name == "deb_moderator" }}
{{ include file="_section/section_debatte.tpl" }}
{{ /if }}
{{ if $gimme->article->type_name == "PrintDesk" }}
{{ include file="_article/article_typenews.tpl" }}
{{ /if }}
{{ if $gimme->article->type_name == "rss_placeholder" }}
{{ include file="rss-blog.tpl" }}
{{ /if }}
