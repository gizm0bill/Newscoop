<!--
{{ list_articles length="4" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is newswire" }}
{{ $gimme->article->name }}
{{ /list_articles }}
-->
{{*
<!-- _tpl/newsticker_front.tpl -->  
{{ function item }}
<section>{{ include file="_tpl/admin_frontpageedit.tpl" }}
    <h3><a href="{{ uri options="article" }}">{{ $gimme->article->NewsLineText }}{{ if !$gimme->article->NewsLineText }}{{ $gimme->article->name }}{{ /if }}</a> {{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }}</h3>
    <p>{{ if $gimme->article->NewsLineText }}{{ $gimme->article->name }}{{ /if }} <a href="{{ uri options="article" }}">Weiterlesen</a></p>
</section>
{{ /function }}

<article>
    <header>
        <p>Aktuelle Nachrichten {{ if $gimme->section->defined }}{{ $gimme->section->name }}{{ /if }}</p>
    </header>

    {{ if $gimme->section->number }}
    {{ list_articles length="4" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is newswire section is `$gimme->section->number`" }}
    {{ item gimme=$gimme }}
    {{ /list_articles }}
    <footer>
        {{ $sectionNo=$gimme->section->number }}
        <a href="{{ local }}{{ set_section number="82" }}{{ uri options="section" }}?section_no={{ $sectionNo }}{{ /local }}" class="more">Letzte 24 Stunden</a>
    </footer>

    {{ else }}
    {{ $datetimeLimit=date_create("-6 hours") }}
    {{ $datetimeLimitConstraint=$datetimeLimit->format("Y-m-d H:i") }}
    {{ list_articles length="4" ignore_issue="true" ignore_section="true" order="bypriority desc" constraints="type is newswire publish_datetime greater_equal $datetimeLimitConstraint" }}
    {{ item gimme=$gimme }}
    {{ /list_articles }}
    <footer>
        <a href="{{ local }}{{ set_section number="82" }}{{ uri options="section" }}{{ /local }}" class="more">Letzte 24 Stunden</a>
    </footer>
    {{ /if }}

</article>
<!-- / _tpl/newsticker_front.tpl -->
*}}
