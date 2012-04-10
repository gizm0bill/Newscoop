<!-- _tpl/navigation.tpl -->  
<nav>
    <ul>
{{ local }}
{{ set_publication identifier="1" }}
{{ set_current_issue }}

{{ list_sections constraints="number smaller 51" }} 
        <li><a{{ if ($gimme->section->number == $gimme->default_section->number) && ($gimme->template->name != "search.tpl") }} class="active"{{ /if }} href="http://{{ $gimme->publication->site }}{{ uri options="section" }}">{{ $gimme->section->name }}</a>
{{* list first article from appropriate playlist *}}
{{ list_playlist_articles length="1" name=$gimme->section->name|strip }}
            <ul class="sub left-items">
                <li>
                    {{ include file="_tpl/img/img_120x53.tpl" }}
                    <h3>{{ if $gimme->article->type_name == "newswire" }}{{ if $gimme->article->short_name != "" }}{{ $gimme->article->short_name }}{{ else }}{{ $gimme->article->HeadLine }}{{ /if }}{{ else }}{{ if $gimme->article->short_name != "" }}{{ $gimme->article->short_name }}{{ else }}{{ $gimme->article->name }}{{ /if }}{{ /if }}</h3>
                </li>
            </ul>
{{ /list_playlist_articles }}

        </li>                   
{{ /list_sections }}

        {{ set_issue number="1" }}
        {{ set_section number="5" }}
        <li><a{{ if ($gimme->issue->number == 1) && ($gimme->section == $gimme->default_section) && ($gimme->template->name != "search.tpl")  }} class="active"{{ /if }} href="http://{{ $gimme->publication->site }}{{ uri options="section" }}">{{ $gimme->section->name }}</a>
{{ list_articles length="1" ignore_issue="true" ignore_section="true" constraints="issue is 1 section is 5 type is dossier" order="bysection desc" }}        
            <ul class="sub left-items">
                <li>
                    {{ include file="_tpl/img/img_120x53.tpl" }}
                    <h3>{{ if $gimme->article->short_name }}{{ $gimme->article->short_name }}{{ else }}{{ $gimme->article->name }}{{ /if }}</h3>
                </li>
            </ul>   
{{ /list_articles }}            
</li>
        {{ set_current_issue }}
        <li><a{{ if ($gimme->default_section->number == 71) || ($gimme->default_section->number == 72) }}{{ if $gimme->template->name != "search.tpl" }} class="active"{{ /if }}{{ /if }} href="#">Agenda</a>
                <ul class="sub right-items">
                <li class="submenu">
                        <ul>
                        <li><a href="{{ set_section number="71" }}http://{{ $gimme->publication->site }}{{ uri options="section" }}">{{ $gimme->section->name }}</a></li>
                        <li><a href="{{ set_section number="72" }}http://{{ $gimme->publication->site }}{{ uri options="section" }}">{{ $gimme->section->name }}</a></li>
                    </ul>
                </li>
            </ul>
        </li>
        <li><a href="{{ set_publication identifier="1" }}{{ set_section number="80" }}http://{{ $gimme->publication->site }}{{ uri options="section" }}"{{ if ($gimme->section == $gimme->default_section) && ($gimme->template->name != "search.tpl")  }} class="active"{{ /if }}>Dialog</a>

                <ul class="sub right-items">
                <li class="submenu">
                        <ul>     
                        <li>{{ set_publication identifier="5" }}<a href="http://{{ $gimme->publication->site }}{{ set_current_issue }}{{ uri options="issue" }}">Blogs</a></li>                  

                        {{ set_publication identifier="1" }}
{{ list_articles length="1" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="section is 81 type is deb_moderator" }}
{{ assign var="debissue" value=$gimme->issue->number }}{{* we have to find in which issue is last debate published - might happen it doesn't exist in current issue *}}
{{ /list_articles }}
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
{{list_articles length="2" constraints="type is deb_statement" }}
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

{{list_articles length="1" constraints="type is deb_moderator" }}
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
                        <li><a href="{{ set_section number="81" }}http://{{ $gimme->publication->site }}{{ uri options="section" }}?stage={{ $wdphase }}">Wochendebatte</a></li>
                        {{ list_articles ignore_issue="true" ignore_section="true" length="1" constraints="type is pinnwand" }}<li><a href="{{ url options="article" }}">Storyboard</a></li>{{ /list_articles }}
                        {{* <li><a href="#">Whistleblowing</a></li> *}}
                        <li><a href="{{ $view->url(['controller' => 'user', 'action' => 'index'], 'default') }}">Community</a></li>
                    </ul>
                </li>
            </ul>
        </li>
{{ /local }}
    </ul>
</nav>
<!-- / _tpl/navigation.tpl -->
