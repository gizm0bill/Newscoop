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
    {{ list_articles length="4" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is newswire type is news section is `$gimme->section->number` section not 90 behave_as_news is off" }}
    {{ item gimme=$gimme }}
    {{ /list_articles }}
    <footer>
        {{ $sectionNo=$gimme->section->number }}
        <a href="{{ local }}{{ set_section number="82" }}{{ uri options="section" }}?section_no={{ $sectionNo }}{{ /local }}" class="right">Alle Nachrichten</a>
    </footer>

    {{ else }}
    {{ if intval(date('H')) <= 7 OR date('Y-m-d') == '2012-04-06' OR date('Y-m-d') == '2012-04-09' }}{{* show news for latest 10h from 0am to 7am // or easter days *}}
    {{ $datetimeLimit=date_create("-10 hours") }}
    {{ else }}{{* show news for latest 6 hours from 7am to 12pm *}}
    {{ $datetimeLimit=date_create("-6 hours") }}
    {{ /if }}
    {{ $datetimeLimitConstraint=$datetimeLimit->format("Y-m-d H:i") }}
    {{ list_articles length="4" ignore_issue="true" ignore_section="true" order="bypriority desc" constraints="type is newswire type is news section not 90 publish_datetime greater_equal $datetimeLimitConstraint behave_as_news is off" }}
    {{ item gimme=$gimme }}
    {{ /list_articles }}
    <footer>
        <a href="{{ local }}{{ set_section number="82" }}{{ uri options="section" }}{{ /local }}" class="right">Alle Nachrichten</a>
    </footer>
    {{ /if }}

</article>
<!-- / _tpl/newsticker_front.tpl -->
