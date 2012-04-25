{{ include file="_tpl/_html-head.tpl" }}

<body>

{{**************************************************
{{ $wdphase }} first, we decide what phase the Wochendebatte is in. the links and pages will
be loaded accordingly. 
this needs to be error prove so it displays only IF all relevant fields are filled.
therefore moderator, pro and contra are checked separately. and then all is compared according to a matrix.
*}}
{{ strip }}
{{* before we do the above, get the urlparameters to get what to display *}}
{{ if $smarty.get.stage }}{{* stage 0 to 4 reflects the stage of debate to display *}}
  {{ assign var="wdstage" value=$smarty.get.stage }}
{{ else }}
  {{ assign var="wdstage" value="0" }}
{{ /if }}
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
{{* Check now what stage we are in *}}
{{*
constraints="type is deb_statement"
phase 1 = currentdate > date_opening 00:01
phase 2 = currentdate > date_rebuttal 00:01
phase 3 = currentdate > date_final 00:01
phase 4 = currentdate > date_closing 12:00
*}}
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

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box debatte-page clearfix">
        
        	<header class="mobile-header">
                <p><a href="#">Zur Übersicht</a></p>
            </header>

{{ list_articles length="1" constraints="type is deb_moderator" }}        
        	<h2><span class="green-button green-title">Die Wochendebatte</span>
            {{ $gimme->article->subject }}</h2>

        {{ $closingdate=date_create($gimme->article->date_closing) }}
        {{ $deadline=$closingdate->setTime(12, 0) }}
        {{ $diff=date_diff($deadline, date_create('now')) }}            
            <ul class="debatte-top-nav">            
            	{{ if $deadline->getTimestamp() > time() }}                    
                    	<li{{ if $wdstage== "0" }} class="active"{{ /if }}><a href="{{ url options="section" }}?stage=0"><b>Übersicht</b></a></li>
                    	<li{{ if $wdphase == "1" }} class="active"{{ /if }}><a href="{{ url options="section" }}?stage=1"><b>Standpunkte</b>
                        {{ $gimme->article->date_opening|camp_date_format:"%W %d.%m." }}</a></li>
                    	<li{{ if $wdphase == "2"}} class="active"{{ /if }}><a href="{{ url options="section" }}?stage=2"><b>Entgegnung</b>
                        {{ $gimme->article->date_rebuttal|camp_date_format:"%W %d.%m." }}</a></li>
                     <li{{ if $wdphase == "3"}} class="active"{{ /if }}><a href="{{ url options="section" }}?stage=3"><b>Schlussworte</b>
                        {{ $gimme->article->date_final|camp_date_format:"%W %d.%m." }}</a></li>
        					<li{{ else }} class="active"{{ /if }}><a href="{{ url options="section" }}?stage=4"><b>Fazit</b>                        
                        {{ $gimme->article->date_closing|camp_date_format:"%W %d.%m." }}</a></li>
            </ul>
{{ /list_articles }}
            
            <section>

{{* when including the stage of the debate, make sure that we are 
already at that stage in the proceedings *}}
{{ if $wdphase >= $wdstage }}
  {{ include file="_tpl/debate_section-phase`$wdstage`.tpl" }}
{{ else }}
  {{ include file="_tpl/debate_section-phase`$wdphase`.tpl" }}{{* used to be tpl/debate_section-phase0.tpl *}}
{{ /if }}
 
{{ list_articles length="1" constraints="type is deb_moderator" }}               
{{ include file="_tpl/article-comments.tpl" }}
{{ /list_articles }}
            
            </section>
            
            <aside>
            
            	
                <div class="debatte-stat-box">
                
                	<h3>Die Abstimmung</h3>
                    
                    <ul class="buttons">
                    	<li class="left"><a href="#" class="grey-button">Ja</a></li>
                    	<li class="right"><a href="#" class="grey-button">Nein</a></li>
                    </ul>
                    
                    <p>Sie können Ihre Meinung bis zum Ende der Debatte noch ändern, wenn Sie die Gegenseite doch mehr überzeugt.</p>
                    
                    <ul class="debatte-stat-list">
                    	<li>
                        	<b>Ja</b>
                            <b>Nein</b>
                        </li>
                        <li>
                        	<dl>
                            	<dt style="height:60px;"><span>60%</span></dt>
                                <dd style="height:40px;"><span>40%</span></dd>
                            </dl>
                            <p>Fr.</p>
                        </li>
                        <li>
                        	<dl>
                            	<dt style="height:35px;"><span>35%</span></dt>
                                <dd style="height:65px;"><span>65%</span></dd>
                            </dl>
                            <p>Sa.</p>
                        </li>
                        <li>
                        	<dl>
                            	<dt style="height:70px;"><span>70%</span></dt>
                                <dd style="height:30px;"><span>30%</span></dd>
                            </dl>
                            <p>So.</p>
                        </li>
                        <li>
                        	<dl>
                            	<dt style="height:45px;"><span>45%</span></dt>
                                <dd style="height:55px;"><span>55%</span></dd>
                            </dl>
                            <p>Mo.</p>
                        </li>
                        <li>
                        	<dl>
                            	<dt></dt>
                                <dd></dd>
                            </dl>
                            <p>Di.</p>
                        </li>
                        <li>
                        	<dl>
                            	<dt></dt>
                                <dd></dd>
                            </dl>
                            <p>Mi.</p>
                        </li>
                    </ul>
                    
                    <p><b>Zwischenstand</b></p>
                    <ul class="votes">
                    	<li style="width:64%" class="ja"><p>Ja 64%</p></li>
                    	<li style="width:36%" class="nein"><p>Nein 36%</p></li>
                    </ul>
                
                </div>
                
                <small class="info">Noch 2 Tage, 7 Stunden, 47 Minuten</small>
                
            	<article>
                	<header>
                    	<p>Thema der Debatte</p>
                    </header>
                    <p>Jede Woche lädt die TagesWoche zum Thema der Woche zwei Debattanten ein. Eine Wochendebatte dauert jeweils vom Freitag bis am darauffolgenden Donnerstag und geht über drei Runden. Zum Auftakt, der auch in der Zeitung erscheint, legen beide Debattanten ihren Standpunkt dar. In der Replik gehen sie jeweils auf die Argumente des Gegenübers sowie Kommentare aus dem Publikum ein. Im Schlussplädoyer haben sie nochmals die Gelegenheit, das Publikum von ihrem Standpunkt zu überzeugen. Das Publikum kann während der gesamten Debatte mitdiskutieren, Fragen stellen und abstimmen, auf welche Seite es sich schlagen möchte.</p>
                </article>
                
                <article>
                	<header>
                    	<p>So funktionieren Wochendebatten</p>
                    </header>
                    <p>Jede Woche lädt die TagesWoche zum Thema der Woche zwei Debattanten ein. Eine Wochendebatte dauert jeweils vom Freitag bis am darauffolgenden Donnerstag und geht über drei Runden. Zum Auftakt, der auch in der Zeitung erscheint, legen beide Debattanten ihren Standpunkt dar. In der Replik gehen sie jeweils auf die Argumente des Gegenübers sowie Kommentare aus dem Publikum ein. Im Schlussplädoyer haben sie nochmals die Gelegenheit, das Publikum von ihrem Standpunkt zu überzeugen. Das Publikum kann während der gesamten Debatte mitdiskutieren, Fragen stellen und abstimmen, auf welche Seite es sich schlagen möchte.</p>
                </article>
                
                <article>
                	<header>
                    	<p>Abgeschlossene Debatten</p>
                    </header>
                    <img src="pictures/side-sample-img.png" alt="" />
                    <h3>Muslimischer Religions-unterricht an Basler Schulen?</h3>
                    
                    <img src="pictures/side-sample-img.png" alt="" />
                    <h3>Wochendebatten – sinnvoll oder nicht?</h3>
                </article>
            
            </aside>
        
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}