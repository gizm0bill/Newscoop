{{ include file="_tpl/_html-head.tpl" }}

<body>

  <div id="wrapper">
      
{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix dialog">
    
            <div class="top-werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460077"></div>
<!-- END ADITIONTAG -->            
            </div><!-- /.top-werbung -->
    
{{ include file="_tpl/navigation_top.tpl" }}

            <div id="main-nav" class="clearfix">
            
{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

            </div>
        
            <section>
              
{{* WOCHENDEBATTE teaser for front page *}}
{{ include file="_tpl/debate_front.tpl" }}
                
{{ include file="_tpl/list-blog-teaser-front.tpl" }}
       
{{ include file="_tpl/community_activitystream.tpl" is_community=1 }}       
                
{{* FOTOBLOG *}}
{{ include file="_tpl/fotoblog_front.tpl" }}
                
                <ul class="two-columns clearfix">
                  <li class="left">
{{ list_articles length="1" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="section is 85 type is good_comment" }}                    
{{ if $gimme->current_list->at_beginning }}                  
                        <article>
                            <header>
                                <p>Auf den Punkt gebracht</p>
                            </header>
{{ /if }}                            
                            <div class="quotes-box">
                                <ul>
                                    <li>
                                        <blockquote>{{ $gimme->article->comment_community|strip_tags }}</blockquote>
                                        <small>{{ $gimme->article->comment_on_comment|strip_tags }}</small>
                                    </li>
                                </ul>
                            </div>
{{ if $gimme->current_list->at_end }}                             
                        </article>
{{ /if }}
{{ /list_articles }}                        
                    </li>
                    <li class="right">
{{ list_articles length="1" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="section is 80 type is pinnwand" }}                    
{{ if $gimme->current_list->at_beginning }}
                        <article>
                            <header>
                                <p>Storyboard</p>
                            </header>                       
                            <h2>Die Redaktion braucht Ihre Hilfe</h2>
{{ /if }}                                 
                            <div class="sticker-box yellow">
                              <h3><a href="{{ uri options="article" }}">{{ $gimme->article->name }}</a> <small>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small></h3>
                              <p>{{ $gimme->article->teaser|strip_tags|truncate:120 }}</p>
                            </div>
                            <p><a href="{{ uri options="article" }}">Weitere Aufrufe, zur Übersicht</a></p>
{{ if $gimme->current_list->at_end }}                            
                        </article>
{{ /if }}    
{{ /list_articles }}                    
                    </li>
                </ul>

                <div style="margin: 10px 0; display: block">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460070"></div>
<!-- END ADITIONTAG -->                
                </div>
                
            </section>

            <aside>                
            
{{* COMMUNITY QUOTES *}}
{{ include file="_tpl/communityquotes_front.tpl" }}

{{* TWITTER WIDGET *}}
{{ include file="_tpl/twitter_sidebar_dialog.tpl" }}
                
{{* PARTNER BUTTONS *}}
{{ include file="_tpl/sidebar_partner_buttons.tpl" }}

{{* TEASER BOXES *}}
{{ include file="_tpl/sidebar_teaser_boxes.tpl" }}

                <article>
                    <header>
                        <p>Die TagesWoche auf Facebook</p>
                    </header>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) {return;}
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<div class="fb-like-box" data-href="http://www.facebook.com/tageswoche" data-width="300" data-show-faces="true" data-stream="false" data-header="false"></div>
                </article>
                
                <article>
                  <header>
                      <p>Werbung</p>
                    </header>
                    <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460084"></div>
<!-- END ADITIONTAG -->
                    </span>
                </article>
                
{{* PRINT FRONT PAGE *}}
{{ include file="_tpl/cover_page.tpl" }}
            
            </aside>
{{*            
            <ul class="three-column-content faq-list clearfix">
              <li>
                  <article>
                      <header>
                          <p>FAQ</p>
                        </header>
                        <h2><em>?</em> Omnibox</h2>
                        <p>Die Gutachter der Schweizer Firma SMA bestätigen die Leistungsfähigkeit des geplanten unterirdischen Durchgangsbahnhofs in Stuttgart. Die Bahn hat damit im Streit um Stuttgart 21 eine entscheidende Hürde genommen. Damit im Streit um Stuttgart 21 eine entscheidende Hürde genommen. </p>
                    </article>
                </li>
              <li>
                  <article>
                      <header>
                          <p>FAQ</p>
                        </header>
                        <h2><em>?</em> Kommentare</h2>
                        <p>Die Gutachter der Schweizer Firma SMA bestätigen die Leistungsfähigkeit des geplanten unterirdischen Durchgangsbahnhofs in Stuttgart. Die Bahn hat damit im Streit um Stuttgart 21 eine entscheidende Hürde genommen. Damit im Streit um Stuttgart 21 eine entscheidende Hürde genommen. </p>
                    </article>
                </li>
              <li>
                  <article>
                      <header>
                          <p>FAQ</p>
                        </header>
                        <h2><em>?</em> Whistleblowing</h2>
                        <p>Die Gutachter der Schweizer Firma SMA bestätigen die Leistungsfähigkeit des geplanten unterirdischen Durchgangsbahnhofs in Stuttgart. Die Bahn hat damit im Streit um Stuttgart 21 eine entscheidende Hürde genommen. Damit im Streit um Stuttgart 21 eine entscheidende Hürde genommen. </p>
                    </article>
                </li>
              <li>
                  <article>
                      <header>
                          <p>FAQ</p>
                        </header>
                        <h2><em>?</em> Nutzerprofile</h2>
                        <p>Die Gutachter der Schweizer Firma SMA bestätigen die Leistungsfähigkeit des geplanten unterirdischen Durchgangsbahnhofs in Stuttgart. Die Bahn hat damit im Streit um Stuttgart 21 eine entscheidende Hürde genommen. Damit im Streit um Stuttgart 21 eine entscheidende Hürde genommen. </p>
                    </article>
                </li>
              <li>
                  <article>
                      <header>
                          <p>FAQ</p>
                        </header>
                        <h2><em>?</em> Bloggen:<br />
                        Invitation only</h2>
                        <p>Die Gutachter der Schweizer Firma SMA bestätigen die Leistungsfähigkeit des geplanten unterirdischen Durchgangsbahnhofs in Stuttgart. Die Bahn hat damit im Streit um Stuttgart 21 eine entscheidende Hürde. </p>
                    </article>
                </li>
              <li>
                  <article>
                      <header>
                          <p>FAQ</p>
                        </header>
                        <h2><em>?</em> Leserreporter</h2>
                        <p>Die Gutachter der Schweizer Firma SMA bestätigen die Leistungsfähigkeit des geplanten unterirdischen Durchgangsbahnhofs in Stuttgart. Die Bahn hat damit im Streit um Stuttgart 21 eine entscheidende Hürde genommen. Damit im Streit um Stuttgart 21 eine entscheidende Hürde genommen. </p>
                    </article>
                </li>
            </ul>
*}}
            
        </div>

{{* COMMUNITY AVATARS *}}
{{ include file="_tpl/avatars_front.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
