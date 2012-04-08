<!-- _tpl/debate_section.tpl -->

{{**************************************************
{{ $wdphase }}
first, we decide what phase the Wochendebatte is in. the links and pages will be loaded accordingly. 
this needs to be error prove so it displays only IF all relevant fields are filled.
therefore moderator, pro and contra are checked separately. 
and then all is compared according to a matrix.
*}}
{{ assign var="defaultissue" value=$gimme->issue->number }}

{{list_articles length="1" constraints="type is deb_moderator issue is $defaultissue" }}
{{ /list_articles }}
{{ if $gimme->prev_list_empty }}
{{list_articles length="1" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is deb_moderator section is 81" }}
{{ assign var="defaultissue" value=$gimme->issue->number }}
{{ /list_articles }}
{{ /if }}

{{ strip }}
{{ assign var="wdphase" value="0" }}{{* overall phase *}}
{{ assign var="wdprophase" value="0" }}{{* PRO phase *}}
{{ assign var="wdcontraphase" value="0" }}{{* CONTRA phase *}}
{{ assign var="wdmoderatorphase" value="0" }}{{* MODERATOR  phase *}}
{{list_articles length="2" constraints="type is deb_statement issue is $defaultissue"}}
  {{ if $gimme->article->opening|strip_tags|trim !== "" }}{{* phase 1 = opening written *}}
      {{ if $gimme->article->contra }}{{ assign var="wdcontraphase" value="1" }}
      {{ else }}{{ assign var="wdprophase" value="1" }}
      {{ /if }} 
  {{ /if }}
  {{ if $gimme->article->rebuttal|strip_tags|trim !== "" }}{{* phase 2 = rebuttal written *}}
      {{* check also if previous field is not empty *}}
      {{ if $gimme->article->contra AND $wdcontraphase == 1 }}{{ assign var="wdcontraphase" value="2" }}
      {{ else }}{{ if $wdprophase == 1 }}{{ assign var="wdprophase" value="2" }}{{ /if }}
      {{ /if }} 
  {{ /if }}
  {{ if $gimme->article->closing|strip_tags|trim !== "" }}{{* phase 3 = closing written *}}
      {{* check also if previous field is not empty *}}
      {{ if $gimme->article->contra AND $wdcontraphase == 2 }}{{ assign var="wdcontraphase" value="3" }}
      {{ else }}{{ if $wdprophase == 2 }}{{ assign var="wdprophase" value="3" }}{{ /if }}
      {{ /if }} 
  {{ /if }}
{{/list_articles}}

  {{ if $gimme->article->opening|strip_tags|trim !== "" AND $gimme->article->teaser|strip_tags|trim !== "" }}{{* phase 1 = teaser and opening written *}}
    {{ assign var="wdmoderatorphase" value="1" }}
  {{ /if }}
  {{ if $gimme->article->announcement|strip_tags|trim !== "" }}{{* phase 4 = moderator announcement written *}}
    {{ assign var="wdmoderatorphase" value="4" }} 
  {{ /if }}

{{ $curdate=date('Y-m-d') }}
{{ $enddate=date_create($gimme->article->date_closing) }}
{{ $nowdate=date_create('now') }}
{{ if $wdprophase > 0 AND $wdcontraphase > 0 AND $wdmoderatorphase > 0 AND $curdate >= $gimme->article->date_opening }}{{ assign var="wdphase" value="1" }}{{ /if }}
{{ if $wdprophase > 1 AND $wdcontraphase > 1 AND $wdmoderatorphase > 0 AND $curdate >= $gimme->article->date_rebuttal }}{{ assign var="wdphase" value="2" }}{{ /if }}
{{ if $wdprophase > 2 AND $wdcontraphase > 2 AND $wdmoderatorphase > 0 AND $curdate >= $gimme->article->date_final }}{{ assign var="wdphase" value="3" }}{{ /if }}
{{ if $wdprophase > 2 AND $wdcontraphase > 2 AND $wdmoderatorphase > 3 AND $nowdate->getTimestamp() > $enddate->getTimestamp() }}{{ assign var="wdphase" value="4" }}{{ /if }}
{{ /strip }}
<!-- PHASE + {{ $wdprophase }} | - {{ $wdcontraphase }} | mod {{ $wdmoderatorphase }} | overall {{ $wdphase }} -->
<!-- current {{ $curdate }} | {{ $gimme->article->date_opening }} | {{ $gimme->article->date_rebuttal }}  | {{ $gimme->article->date_final }}  | {{ $enddate->getTimestamp() }} -->

{{ if $wdphase > 0 }}{{* general introduction of Wochendebatte *}}

<article>
  <header>
    <p>
        {{ $closingdate=date_create($gimme->article->date_closing) }}
        {{ $deadline=$closingdate->setTime(12, 0) }}
        {{ $diff=date_diff($deadline, date_create('now')) }}
        {{ if $deadline->getTimestamp() > time() }}
            Aktueller Stand: 
           {{ if $wdphase == "1"}}Auftakt{{ /if }}
           {{ if $wdphase == "2"}}Replik{{ /if }}
           {{ if $wdphase == "3"}}Schlusspl&auml;doyer{{ /if }}
           {{ if $wdphase == "4"}}Fazit{{ /if }}
            | Noch {{ $diff->days }} Tage, {{ $diff->h }} Stunden, {{ $diff->i }} Minuten
        {{ else }}
            Aktueller Stand: Fazit{{* (Diskussion geschlossen am {{ $deadline->format('j.n.Y') }} um 12:00 Uhr)*}}
        {{ /if }}

        {{ if $gimme->article->comments_enabled && $gimme->article->content_accessible }}
        <small><a href="{{ uri options="article" }}#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a></small>
        {{ /if }}
        {{ include file="_tpl/article_info_box.tpl" }}   
    </p>
  </header>
    <h2>
      <a href="{{ uri options="section" }}?stage={{ $wdphase }}"><mark>Die Wochendebatte</mark>
      {{ $gimme->article->subject }}
      <em>Diskutieren Sie mit und stimmen Sie ab!</em>{{* include file="_tpl/article_title_tooltip_box.tpl" *}}
      </a>{{ include file="_tpl/article_title_tooltip_box.tpl" }}
    </h2>{{ include file="_tpl/admin_frontpageedit.tpl" }}
    <p>{{ $gimme->article->teaser|strip_tags }} Moderation {{ list_article_authors }}{{ $gimme->author->name }}{{ /list_article_authors }}</p>
</article>

<div class="two-columns thumb-articles clearfix">

{{* Pro and Contra introduction *}}
{{ list_articles constraints="type is deb_statement section is 81 issue is $defaultissue" }}               
<article>
  {{ list_article_authors }}
  <figure>
    <a href="{{ uri options="section" }}?stage={{ $wdphase }}"><img src="{{ $gimme->author->picture->imageurl }}" alt="Portrait {{ $gimme->author->name }}" width="60" /></a>
    <p>{{ $gimme->author->name }}</p>
  </figure>
  {{ /list_article_authors }}
  <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}
    <strong>{{ if $gimme->article->contra }}NEIN{{ else }}JA{{ /if }}</strong> 
    {{ strip }}&laquo;
    {{ if $wdphase == 1 }}{{ $gimme->article->opening|strip_tags|escape:'html'|trim|truncate:220:" [...]" }}{{ /if }}
    {{ if $wdphase == 2 }}{{ $gimme->article->rebuttal|strip_tags|escape:'html'|trim|truncate:220:" [...]" }}{{ /if }}
    {{ if $wdphase == 3 }}{{ $gimme->article->closing|strip_tags|escape:'html'|trim|truncate:220:" [...]" }}{{ /if }}
    {{ if $wdphase == 4 }}{{ $gimme->article->closing|strip_tags|escape:'html'|trim|truncate:220:" [...]" }}{{ /if }}
    &raquo;{{ /strip }}
  </p>
</article>
{{ /list_articles }}

    <span class="footer-div">
        <h4><a href="{{ uri options="section" }}?stage={{ $wdphase }}">Jetzt mitreden!</a> 
            <small>
        {{list_articles length="1" ignore_section="true" constraints="section is 81 type is deb_moderator"}}    
        {{ $closingdate=date_create($gimme->article->date_closing) }}
        {{ $deadline=$closingdate->setTime(12, 0) }}
        {{ $diff=date_diff($deadline, date_create('now')) }}
        {{ if $deadline->getTimestamp() > time() }}
        Noch {{ $diff->days }} Tage, {{ $diff->h }} Stunden, {{ $diff->i }} Minuten
        {{ else }}
            Aktueller Stand: Fazit{{* (Diskussion geschlossen am {{ $deadline->format('j.n.Y') }} um 12:00 Uhr)*}}
        {{ /if }}
        {{ /list_articles }}
    </small></h4>
    </span>
  </div>
   
{{ /if }}
<!-- / _tpl/debate_section.tpl -->
