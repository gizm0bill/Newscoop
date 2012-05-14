<!-- _tpl/dossier_front.tpl -->                 
<article>
    <header>
        <p>Aktueller Themenschwerpunkt</p>
    </header>
    
{{* list_articles length="1" ignore_issue="true" ignore_section="true" order="bysection desc" constraints="section is 60 type is dossier" *}}
{{ list_articles length="1" order="bysection desc" constraints="issue is 1 section is 5 type is dossier" }}
    <figure>
        <a href="{{ url options="article" }}"><big>Dossier: <b>{{ $gimme->article->name }}</b><br />
        {{ $gimme->article->subtitle }}</big></a>{{ include file="_tpl/admin_frontpageedit.tpl" }}
        <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_640x280.tpl" }}</a>
    </figure>
        <p>{{ $gimme->article->lede }}</p>   

    {{ list_related_articles }}
    {{ if $gimme->current_list->at_beginning }}
    <div class="loader" style="height:202px">
    <ul class="article-carousel jcarousel-skin-article">
    {{ /if }}
        <li>{{ include file="_tpl/admin_frontpageedit.tpl" }}
            {{ if $gimme->article->has_image(1) }}
            <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_300x133.tpl" }}</a>
            {{ /if }}
            <h3><a href="{{ url options="article" }}">{{ if $gimme->article->short_name }}{{ $gimme->article->short_name }}{{ else }}{{ $gimme->article->name }}{{ /if }}</a></h3>
        </li>
    {{ if $gimme->current_list->at_end }}
    </ul>
    <div class="loading" style="height:202px"></div></div>
    {{ /if }}
    {{ /list_related_articles }}
{{ /list_articles }}
    
</article>
<!-- / _tpl/dossier_front.tpl -->
