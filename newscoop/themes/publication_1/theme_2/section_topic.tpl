{{ include file="_tpl/_html-head.tpl" }}
<body>

        <div id="wrapper">

{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix {{ $gimme->section->shortname }}">{{* here are some classes, like 'fokus' depending on the section *}}
                    
{{ include file="_tpl/navigation_top.tpl" }}

<div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

</div>                          

            <section>
            <div class="article-padding">
                <article>
                    <header>
                        <p>{{ $gimme->topic->name }}</p>
                    </header>
                </article>
    <div class="one-columns news-tickers clearfix">
    {{ list_articles length="15" ignore_publication="true" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is news topic is `$gimme->topic->id`" }}
    {{ if $gimme->current_list->at_beginning }}
<ul class="topic-list-view">
    {{ /if }}
    
    <li>
        <article>
            {{ if $gimme->article->has_image(1) }}
            <figure>
                <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
            </figure>
            {{ /if }}

            {{ $diff=date_diff(date_create('now'), date_create($gimme->article->publish_date)) }}
            <small class="date relative">{{ $gimme->section->name }} vor
            {{ if $diff->d }} {{ $diff->d }} {{ if $diff->d > 1 }}Tagen{{ else }}Tag{{ /if }}{{ /if }}
            {{ if $diff->h && (!$diff->d || empty($short)) }} {{ $diff->h }} Std.{{ /if }}
            {{ if !$diff->d && $diff->i && (empty($short) || !$diff->h) }} {{ $diff->i }} Min.{{ /if }}
            {{ if !$diff->d && !$diff->h && !$diff->i && $diff->s }} {{ $diff->s }} Sek.{{ /if }}
            </small>

            <h3><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h3>
            <p>{{ str_replace(array("<p>", "</p>"), "", $gimme->article->lede) }} <a href="{{ url options="article" }}">Weiterlesen</a></p>
        </article>
    </li>
    
    {{ if $gimme->current_list->at_end }}
    </ul>
    
    {{* PAGINATION KOSHER/HALAL WAY *}}
    {{ $pages=ceil($gimme->current_list->count/15) }}
    {{ $curpage=intval($gimme->url->get_parameter($gimme->current_list_id())) }}
    {{ if $pages gt 1 }}
    <p class="pagination reverse-border">
    {{ for $i=0 to $pages - 1 }}
        {{ $curlistid=$i*15 }}
        {{ $gimme->url->set_parameter($gimme->current_list_id(),$curlistid) }}
        {{ if $curlistid != $curpage }}
        <a href="{{ uri }}">{{ $i+1 }}</a>
        {{ else }}
        <span style="font-weight: bold; text-decoration: none">{{ $i+1 }}</span>
        {{ $remi=$i+1 }}
        {{ /if }}
    {{ /for }}
    <span class="nav right">
    {{ if $gimme->current_list->has_previous_elements }}<a href="{{ uri options="previous_items" }}" class="prev">Previous</a>{{ /if }}
    {{ if $gimme->current_list->has_next_elements }}<a href="{{ uri options="next_items" }}" class="next">Next</a>{{ /if }}
    </span>
    </p>
    {{ $gimme->url->set_parameter($gimme->current_list_id(),$curpage) }}
    {{ /if }}
    {{ /if }}
    {{ /list_articles }}
    </div>

</div>
            </section>

        </div>
        
{{* COMMUNITY AVATARS *}}
{{ include file="_tpl/avatars_front.tpl" }}

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
