<!-- _tpl/newsticker_front.tpl -->  
<article>
        <header>
            <p>Aktuelle Nachrichten {{ if $gimme->section->defined }}{{ $gimme->section->name }}{{ /if }}</p>
        </header>

{{ $section="" }}
{{ if $gimme->section->number }}
    {{ $section=sprintf("section is %d", $gimme->section->number) }}
{{ /if }}
{{ list_articles length="4" ignore_issue="true" ignore_section="true" order="bypriority asc" constraints="type is newswire $section" }}
    <section>{{ include file="_tpl/admin_frontpageedit.tpl" }}
        <h3><a href="{{ uri options="article" }}">{{ $gimme->article->NewsLineText }}{{ if !$gimme->article->NewsLineText }}{{ $gimme->article->name }}{{ /if }}</a> {{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }} </h3>
        <p>{{ if $gimme->article->NewsLineText }}{{ $gimme->article->name }}{{ /if }}
          <a href="{{ uri options="article" }}">Weiterlesen</a>
        </p>
    </section>
{{ /list_articles }}

        <footer>
        {{ if !empty($section) }}
        {{ $sectionNo=$gimme->section->number }}
        <a href="{{ local }}{{ set_section number="82" }}{{ uri options="section" }}?section_no={{ $sectionNo }}{{ /local }}" class="more">Letzte 24 Stunden</a>
        {{ else }}
        <a href="{{ local }}{{ set_section number="82" }}{{ uri options="section" }}{{ /local }}" class="more">Letzte 24 Stunden</a>
        {{ /if }}
    </footer>
</article>
<!-- / _tpl/newsticker_front.tpl -->
