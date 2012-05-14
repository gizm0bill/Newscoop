{{ include file="_tpl/_html-head.tpl" }}

<body>

  <div id="wrapper">
      
{{ list_articles length="1" constraints="type is deb_moderator" }}
{{ omnibox }}
{{ /list_articles }}
        
        <div class="content-box top-content-fix clearfix debatte">
    
            <div class="top-werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460346"></div>
<!-- END ADITIONTAG -->            
            </div><!-- /.top-werbung -->
    
{{ include file="_tpl/navigation_top.tpl" }}

            <div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

            </div>

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
           
{{* when including the stage of the debate, make sure that we are 
already at that stage in the proceedings *}}
{{ if $wdphase >= $wdstage }}
  {{ include file="_tpl/debate_section-phase`$wdstage`.tpl" }}
{{ else }}
  {{ include file="_tpl/debate_section-phase0.tpl" }}
{{ /if }}           
   
<div class="debatte-text thumb-articles clearfix">   
<section>

{{ list_articles length="1" constraints="type is deb_moderator" }}
{{ if $gimme->issue == $gimme->default_issue }}
{{ if !($gimme->article->next_debate_date == "") && !($gimme->article->next_debate_teaser == "") }}
                <article>
                    <header>
                        <p>N&auml;chste Debatte am {{ $gimme->article->next_debate_date|camp_date_format:"%e.%m.%Y" }}</p>
                    </header>
                    <div class="gray-box">
                        <h2>{{ $gimme->next_debate_title }}</h2>
                        <p>{{ $gimme->article->next_debate_teaser }}</p>
                   </div>
               </article>
{{ /if }}               
{{ /if }}               
{{ /list_articles }}  
 
{{ include file="_tpl/debate_section_slider.tpl" }}

         </section>
         <aside>

                <article>
                    <header>
                        <p>Werbung</p>
                    </header>
                    <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460348"></div>
<!-- END ADITIONTAG -->
                    </span>
                </article>

            <div class="aside-last">
                <article>
                    <header>
                        <p>So funktionieren die Wochendebatten</p>
                    </header>
                    <div class="gray-box">
                        <p>
Jede Woche lädt die TagesWoche zum Thema der Woche zwei Debattanten ein. Eine Wochendebatte dauert jeweils vom Freitag bis am darauffolgenden Donnerstag und geht über drei Runden. Zum Auftakt, der auch in der Zeitung erscheint, legen beide Debattanten ihren Standpunkt dar. In der Replik gehen sie jeweils auf die Argumente des Gegenübers sowie Kommentare aus dem Publikum ein. Im Schlussplädoyer haben sie nochmals die Gelegenheit, das Publikum von ihrem Standpunkt zu überzeugen. Das Publikum kann während der gesamten Debatte mitdiskutieren, Fragen stellen und abstimmen, auf welche Seite es sich schlagen möchte. 
</p>
                    </div>
                </article>
            </div>
         </aside>
</div><!-- /.debatte-text thumb-articles -->         
      </div>
            
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
