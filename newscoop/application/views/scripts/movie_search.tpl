{{ assign var="make_link" 0 }}
{{ assign var="req_movie_key" "" }}
{{ assign var="req_movie_suisa" "" }}
{{ if !empty($smarty.get.key) }}
    {{ assign var="make_link" 1 }}
    {{ assign var="req_movie_key" $smarty.get.key|replace:" ":"\\ "|replace:'"':"" }}
{{ /if }}
{{ if !empty($smarty.get.suisa) }}
    {{ assign var="make_link" 1 }}
    {{ assign var="req_movie_suisa" $smarty.get.suisa|replace:" ":"\\ "|replace:'"':"" }}
{{ /if }}
{{ if $make_link }}
    {{ assign var="req_movie_found" 0 }}
    {{ if $req_movie_suisa != "" }}
        {{ assign var="req_link_con" "movie_suisa is $req_movie_suisa" }}
    {{ /if }}
    {{ if $req_movie_key != "" }}
        {{ assign var="req_link_con" "movie_key is $req_movie_key" }}
    {{ /if }}
    {{* create list on that movie, take one and create link, alike from a real screening list *}}
    {{ list_articles columns="1" length="1" ignore_issue="true" ignore_section="true" constraints="$req_link_con type is screening" }}
<meta http-equiv="refresh" content="0; url={{ url options="article" }}">
        {{ assign var="req_movie_found" 1 }}
    {{ /list_articles }}
    {{ if $req_movie_found eq 0 }}
        {{ include file="404.tpl" }}
    {{ /if }}
{{ else }}
    {{ include file="404.tpl" }}
{{ /if }}
