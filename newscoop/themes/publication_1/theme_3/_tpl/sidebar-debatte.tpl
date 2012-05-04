{{ local }}
{{ list_articles length="1" ignore_issue="true" ignore_section="true" constraints="section is 81 type is deb_moderator" }}
{{ assign var="debissue" value=$gimme->issue->number }}{{* we have to find in which issue is last debate published - might happen it doesn't exist in current issue *}}
{{ assign var="closedate" value=$gimme->article->date_closing }}
{{ /list_articles }}

{{ $todayminusthree=date_create("-72 hours") }}
{{ $dateConstraint=$todayminusthree->format("Y-m-d") }}

{{ if !($closedate lt $dateConstraint) }}{{* if last debatte is not closed more than three days ago, show frontpage teaser *}}

{{ set_issue number=$debissue }}
{{ set_section number="81" }}
{{**************************************************
{{ $wdphase }}
first, we decide what phase the Wochendebatte is in. the links and pages will be loaded accordingly. 
this needs to be error prove so it displays only IF all relevant fields are filled.
therefore moderator, pro and contra are checked separately. 
and then all is compared according to a matrix.
*}}

{{ strip }}
{{ assign var="wdphase" value="0" }}{{* overall phase *}}
{{ assign var="wdprophase" value="0" }}{{* PRO phase *}}
{{ assign var="wdcontraphase" value="0" }}{{* CONTRA phase *}}
{{ assign var="wdmoderatorphase" value="0" }}{{* MODERATOR  phase *}}
{{ list_articles length="2" constraints="type is deb_statement" }}
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
{{list_articles length="1" constraints="type is deb_moderator" }}
  {{ if $gimme->article->opening|strip_tags|trim !== "" AND $gimme->article->teaser|strip_tags|trim !== "" }}{{* phase 1 = teaser and opening written *}}
    {{ assign var="wdmoderatorphase" value="1" }}
  {{ /if }}
  {{ if $gimme->article->announcement|strip_tags|trim !== "" }}{{* phase 4 = moderator announcement written *}}
    {{ assign var="wdmoderatorphase" value="4" }} 
  {{ /if }}
{{/list_articles}}

{{ list_articles length="1" constraints="type is deb_moderator" }}
{{ $curdate=date('Y-m-d') }}
{{ $enddate=date_create($gimme->article->date_closing) }}
{{ $nowdate=date_create('now') }}
{{ if $wdprophase > 0 AND $wdcontraphase > 0 AND $wdmoderatorphase > 0 AND $curdate >= $gimme->article->date_opening }}{{ assign var="wdphase" value="1" }}{{ /if }}
{{ if $wdprophase > 1 AND $wdcontraphase > 1 AND $wdmoderatorphase > 0 AND $curdate >= $gimme->article->date_rebuttal }}{{ assign var="wdphase" value="2" }}{{ /if }}
{{ if $wdprophase > 2 AND $wdcontraphase > 2 AND $wdmoderatorphase > 0 AND $curdate >= $gimme->article->date_final }}{{ assign var="wdphase" value="3" }}{{ /if }}
{{ if $wdprophase > 2 AND $wdcontraphase > 2 AND $wdmoderatorphase > 3 AND $nowdate->getTimestamp() > $enddate->getTimestamp() }}{{ assign var="wdphase" value="4" }}{{ /if }}
{{/list_articles}}
{{ /strip }}
<!-- PHASE + {{ $wdprophase }} | - {{ $wdcontraphase }} | mod {{ $wdmoderatorphase }} | overall {{ $wdphase }} -->
<!-- current {{ $curdate }} | {{ $gimme->article->date_opening }} | {{ $gimme->article->date_rebuttal }}  | {{ $gimme->article->date_final }}  | {{ $enddate->getTimestamp() }} -->

                <div class="debate-box omni-corner-box">

{{ list_articles length="1" constraints="type is deb_moderator" }}  

        {{ assign var="closingdate" value=date_create($gimme->article->date_closing) }}
        {{ assign var="deadline" value=$closingdate->setTime(12, 0) }}
        {{ assign var="diff" value=date_diff($deadline, date_create('now')) }}
                      
                	<h3>Die Wochendebatte: {{ $gimme->article->subject }}</h3>
                    <ul class="nav">
                    	<li><a href="{{ url options="section" }}?stage=0"><b>Übersicht</b></li>
                    	<li{{ if $wdphase == "1" }} class="active"{{ /if }}><a href="{{ url options="section" }}?stage=1"><b>Standpunkte</b>
                        {{ $gimme->article->date_opening|camp_date_format:"%W %d.%m." }}</a></li>
                    	<li{{ if $wdphase == "2" }} class="active"{{ /if }}><a href="{{ url options="section" }}?stage=2"><b>Entgegnung</b>
                        {{ $gimme->article->date_rebuttal|camp_date_format:"%W %d.%m." }}</a></li>
                     <li{{ if $wdphase == "3" }} class="active"{{ /if }}><a href="{{ url options="section" }}?stage=3"><b>Schlussworte</b>
                        {{ $gimme->article->date_final|camp_date_format:"%W %d.%m." }}</a></li>
                     <li{{ if $wdphase == "4" }} class="active"{{ /if }}><a href="{{ url options="section" }}?stage=4"><b>Fazit</b>
                        {{ $gimme->article->date_closing|camp_date_format:"%W %d.%m." }}</a></li>
                    </ul>

      {{ list_debates length="1" item="article" }}
          {{ if $gimme->debate->is_votable }}
          <h5>Zwischenstand</h5>
          {{ else }}
          <h5>Endresultat</h5>
          {{ /if }}
          <ul class="votes">
          {{ list_debate_answers order="bynumber asc" }}
              <li style="width:{{ $gimme->debateanswer->percentage|string_format:"%d" }}%;" class="{{ $gimme->debateanswer->answer|lower }}"><p>{{ $gimme->debateanswer->answer }} {{ math equation="round(x)" x=$gimme->debateanswer->percentage format="%d" }}%</p></li>
          {{ /list_debate_answers }}
          </ul>
      {{ /list_debates }}
{{ /list_articles }}                    
                    
{{* Pro and Contra introduction *}}
{{ list_articles constraints="type is deb_statement" }}   
{{ if $gimme->current_list->at_beginning }}             
                    <ul class="debate-content">
{{ /if }}                    
                    	   <li>
  {{ list_article_authors }}
    								<a href="{{ url options="section" }}?stage={{ $wdphase }}"><img src="{{ $gimme->author->picture->imageurl }}" alt="Portrait {{ $gimme->author->name }}" width="60" /></a>
  {{ /list_article_authors }}                    	
                            <p><b>{{ if $gimme->article->contra }}Nein{{ else }}Ja{{ /if }}</b> {{ strip }}&laquo;
    {{ if $wdphase == 1 }}{{ $gimme->article->opening|strip_tags|escape:'html'|trim|truncate:220:" [...]" }}{{ /if }}
    {{ if $wdphase == 2 }}{{ $gimme->article->rebuttal|strip_tags|escape:'html'|trim|truncate:220:" [...]" }}{{ /if }}
    {{ if $wdphase == 3 }}{{ $gimme->article->closing|strip_tags|escape:'html'|trim|truncate:220:" [...]" }}{{ /if }}
    {{ if $wdphase == 4 }}{{ $gimme->article->closing|strip_tags|escape:'html'|trim|truncate:220:" [...]" }}{{ /if }}
    &raquo;{{ /strip }} <em>{{ list_article_authors }}{{ $gimme->author->name }}{{ if !($gimme->current_list->at_end) }}, {{ /if }}{{ /list_article_authors }}</em></p>
                        </li>

{{ if $gimme->current_list->at_end }}                        
                    </ul>
{{ /if }}  
{{ /list_articles }}   
                    <ul class="debate-bottom">
                    	<li>
                            <a href="{{ url options="section" }}?stage={{ $wdphase }}" class="button">Jetzt einmischen!</a>
                        </li>
        {{ list_articles length="1" constraints="type is deb_moderator" }}    
        {{ $closingdate=date_create($gimme->article->date_closing) }}
        {{ $deadline=$closingdate->setTime(12, 0) }}
        {{ $diff=date_diff($deadline, date_create('now')) }}
        {{ if $deadline->getTimestamp() > time() }}
        						<li><p>Noch {{ $diff->days }} Tage, {{ $diff->h }} Stunden, {{ $diff->i }} Minuten</p></li>
        {{ else }}
        						<li><p>Aktueller Stand: Fazit{{* (Diskussion geschlossen am {{ $deadline->format('j.n.Y') }} um 12:00 Uhr)*}}</p></li>
        {{ /if }}
        {{ /list_articles }}
                    </ul>
                
                </div>
{{ /if }}{{* if last debatte is not closed more than three days ago, show frontpage teaser *}}
{{ /local }}
