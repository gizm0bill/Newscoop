<!-- _tpl/blog_sidebar_latestposts.tpl -->
<article>
    <header>
        <p>Aktuell in den Blogs</p>
    </header>

    <ul id="latestposts-list">
        <li><ul class="item-list side-icons-list latestposts-list">
        {{ assign var="cursec" value=$gimme->section->number }}
        {{ list_articles length="7" ignore_section="true" order="byDate desc" constraints="type is blog" }}

        <li class="blogpost">{{ assign var="created" value=$gimme->article->publish_date }}{{ include file="_tpl/relative_date.tpl" date=$created short=1 }} <a href="{{ url options="article" }}">{{ $gimme->article->name }}</a> in <a href="{{ url options="section" }}">{{ $gimme->section->name }}</a></li>

        {{ /list_articles }}
        </ul></li>
    </ul>

</article>
<!-- _tpl/blog_sidebar_latestposts.tpl -->
