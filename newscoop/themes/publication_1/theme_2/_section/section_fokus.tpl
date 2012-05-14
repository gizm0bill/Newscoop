{{ include file="_tpl/_html-head.tpl" }}
<body>

  <div id="wrapper">
      
{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix fokus">
            <div class="top-werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460078"></div>
<!-- END ADITIONTAG -->            
            </div><!-- /.top-werbung -->
    
{{ include file="_tpl/navigation_top.tpl" }}

            <div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

            </div>
            
            <section>

{{ list_articles length="1" ignore_issue="true" ignore_section="true" constraints="type is dossier active is on" order="bysection desc" }}

                <article>
                    <header>
                        <p>Aktueller Themenschwerpunkt</p>

{{ include file="_tpl/article_info_box.tpl" }}

                    </header>
                    <figure>
                        <a href="{{ uri options="article" }}"><big>Dossier: <b>{{ $gimme->article->name|strip }}</b> {{ $gimme->article->subtitle }}</big></a>
                        {{ include file="_tpl/img/img_640x280.tpl" }}
                    </figure>
                    <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->lede|strip_tags }} <a href="{{ uri options="article" }}">Dossier ansehen</a></p>
                </article>
{{ /list_articles }}       
 
                <div class="article-list-view">
               
{{ list_articles ignore_issue="true" ignore_section="true" constraints="type is dossier active is on" order="bysection desc" }}                
{{ if $gimme->current_list->index gt 1 }}                
                    <article>
                        <header>
                            <p>Dossier</p>
{{ include file="_tpl/article_info_box.tpl" }}
                        </header>
                        <figure>
                            <a href="{{ uri options="article" }}">{{ include file="_tpl/img/img_300x200.tpl" }}</a>
                        </figure>
                        <h2><a href="{{ uri options="article" }}">{{ $gimme->article->name }}</a></h2>
                        <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->lede }} <a href="{{ uri options="article" }}">Zum Dossier</a></p>
                  </article>
{{ /if }}       
{{ /list_articles }}         
                </div>
                
                <div style="margin-bottom: 15px; display: block">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460071"></div>
<!-- END ADITIONTAG -->                
                </div>
                                
{{ include file="_tpl/dossier_section_slider.tpl" }}
            
            </section>
            
            <aside>
                
{{* include file="_tpl/newsticker_front.tpl" *}}
                
{{* PARTNER BUTTONS *}}
{{ include file="_tpl/sidebar_partner_buttons.tpl" }}
   
{{* TEASER BOXES *}}
{{ include file="_tpl/sidebar_teaser_boxes.tpl" }}   
                
{{ include file="_tpl/community_activitystream.tpl" }}
                
                <article>
                    <header>
                        <p>Werbung</p>
                    </header>
                    <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460085"></div>
<!-- END ADITIONTAG -->
                    </span>
                </article>
           
{{* BLOG TEASERS *}}
{{ include file="_tpl/sidebar_blog_teaser.tpl" blogpl="Blog teasers - Dossiers" }}
     
{{* PRINT FRONT PAGE *}}
        {{ include file="_tpl/cover_page.tpl" }}
            
            </aside>

        </div>

                <article>
                  <header>
                      <p><a id="kalenderarchiv"><b>Kalenderarchiv: Was die Region Basel bewegt</b></a></p>
                    </header>
{{ wobs_calendar firstDay=1 showDayNames=false earliestMonth='2011/10' latestMonth='current' }}
                </article>
                
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
