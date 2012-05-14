<!-- _tpl/_tpl/footer.tpl --> 
<div class="content-box footer-holder">

    <h5>Seitenübersicht</h5>
    {{ local }}
    <ul>
        <li>
            <h4>TagesWoche</h4>
            <ul>
            {{ set_publication identifier="1" }}
            {{ unset_topic }}
            {{ list_articles ignore_issue="true" ignore_section="true" constraints="issue is 1 section is 10 type is static_page" }}
                <li{{ if $gimme->article->number == $gimme->default_article->number }} class="active"{{ /if }}><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
            {{ /list_articles }}
                {{ set_publication identifier="1" }}
                {{ set_issue number="1" }}
                {{ set_section number="20" }}
                <li{{ if $gimme->section == $gimme->default_section }} class="active"{{ /if }}><a href="{{ url options="section" }}">Abos</a></li>
            </ul>
        </li>
        <li>
            <h4>Dialog</h4>
            <ul>            
                {{ if $gimme->user->logged_in }}
                <li><a href="{{ $view->url(['controller' => 'dashboard', 'action' => 'index'], 'default') }}">MeinProfil</a></li>
                {{ /if }}
                <li><a href="{{ $view->url(['controller' => 'user', 'action' => 'index'], 'default') }}">Nutzersuche</a></li>
                <li{{ if $gimme->default_publication->identifier == "5" }} class="active"{{ /if }}><a href="http://{{ set_publication identifier="5" }}{{ $gimme->publication->site }}{{ set_current_issue }}{{ uri options="issue" }}">Blogs</a></li>
                <li{{ if ($gimme->default_section->number == "80") && ($gimme->default_publication->identifier == "1") }} class="active"{{ /if }}><a href="{{ list_articles length="1" ignore_publication="true" ignore_issue="true" ignore_section="true" constraints="type is pinnwand" }}{{ url options="article" }}{{ /list_articles }}">Storyboard</a></li>

{{ list_articles length="1" ignore_publication="true" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="section is 81 type is deb_moderator" }}
{{ assign var="debissue" value=$gimme->issue->number }}{{* we have to find in which issue is last debate published - might happen it doesn't exist in current issue *}}
{{ /list_articles }}
								{{ set_publication identifier="1" }}
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
{{list_articles length="2" constraints="type is deb_statement"}}
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
{{list_articles length="1" constraints="type is deb_moderator"}}
  {{ if $gimme->article->opening|strip_tags|trim !== "" AND $gimme->article->teaser|strip_tags|trim !== "" }}{{* phase 1 = teaser and opening written *}}
    {{ assign var="wdmoderatorphase" value="1" }}
  {{ /if }}
  {{ if $gimme->article->announcement|strip_tags|trim !== "" }}{{* phase 4 = moderator announcement written *}}
    {{ assign var="wdmoderatorphase" value="4" }} 
  {{ /if }}
{{/list_articles}}

{{list_articles length="1" constraints="type is deb_moderator"}}
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
                <li{{ if $gimme->default_section->number == "81" }} class="active"{{ /if }}><a href="{{ set_publication identifier="1" }}{{ set_issue number=$debissue }}{{ set_section number="81" }}{{ url options="section" }}?stage={{ $wdphase }}">Wochendebatte</a></li> 
            </ul>
        </li>
        <li>
            <h4>Themen</h4>
            <ul>
                <li{{ unset_section }}{{ unset_issue }}{{ if $gimme->template->name == "section_my_topics.tpl" }} class="active"{{ /if }}><a href="{{ url options="template section_my_topics.tpl" }}">Meine Themen</a></li>            
                {{ set_publication identifier="1" }}
                {{ set_current_issue }}
                {{ list_sections constraints="number smaller 51" }}
                <li{{ if ($gimme->section == $gimme->default_section) && ($gimme->default_publication->identifier == "1") }} class="active"{{ /if }}><a href="{{ url options="section" }}">{{ $gimme->section->name }}</a></li>
                {{ /list_sections }}
                <li{{ if ($gimme->publication->identifier == "1") && ($gimme->issue->number == "1") && ($gimme->section->number == "5") }} class="active"{{ /if }}><a href="{{ local }}{{ set_publication identifier="1" }}{{ set_issue number="1" }}{{ set_section number="5" }}{{ url options="section" }}" class="more">{{ $gimme->section->name }}</a></li>
                <a href="{{ set_publication identifier="1" }}{{ set_current_issue }}{{ set_section number="82" }}{{ url options="section" }}{{ /local }}" class="more">Newsticker</a>
            </ul>
        </li>
        <li>
            <h4>Agenda</h4>
            <ul>
                <li{{ if ($gimme->default_section->number == "71") && ($gimme->default_publication->identifier == "1") }} class="active"{{ /if }}><a href="{{ set_section number="71" }}http://{{ $gimme->publication->site }}{{ uri options="section" }}">{{ $gimme->section->name }}</a></li>
                <li{{ if ($gimme->default_section->number == "72") && ($gimme->default_publication->identifier == "1") }} class="active"{{ /if }}><a href="{{ set_section number="72" }}http://{{ $gimme->publication->site }}{{ uri options="section" }}">{{ $gimme->section->name }}</a></li>
            </ul>

        </li>
    </ul>
    {{ /local }}      
    <p>Der TagesWoche folgen auf  
<a href="http://www.facebook.com/tageswoche" class="fb" target="_blank">Facebook</a>  
<a href="http://twitter.com/tageswoche" class="twitter" target="_blank">Twitter</a>  
<a href="http://www.youtube.com/user/tageswoche" class="youtube" target="_blank">You<b>Tube</b></a>
<a href="http://www.soundcloud.com/tageswoche" class="soundcloud" target="_blank">Soundcloud</a> 

    </p>
</div>
<!-- / _tpl/footer.tpl -->
