{{ include file="_tpl/_html-head.tpl" }}
<body>

        <div id="wrapper">
{{ dynamic }}
{{ omnibox }}
{{ /dynamic }}
        
        <div class="content-box top-content-fix clearfix {{$gimme->section->url_name}}">{{* here are some classes, like 'fokus' depending on the section *}}

            <div class="top-werbung">
{{ if $gimme->section->number == 10 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460076"></div>
<!-- END ADITIONTAG -->               
{{ /if }}     
{{ if $gimme->section->number == 20 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460081"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
{{ if $gimme->section->number == 30 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460079"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
{{ if $gimme->section->number == 40 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460082"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
{{ if $gimme->section->number == 50 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460080"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
            </div>
                    
{{ include file="_tpl/navigation_top.tpl" }}

<div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

</div>                          
            <section>

<div class="article-list-view padding-fix rubrik-list">
{{ list_playlist_articles length="12" name=$gimme->section->name }}
{{ include file="_tpl/list-article-teaser-section-big.tpl" }}
{{ if $gimme->current_list->index == 3 }}
<div style="margin-bottom: 15px; display: block">
{{ if $gimme->section->number == 10 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460069"></div>
<!-- END ADITIONTAG -->               
{{ /if }}     
{{ if $gimme->section->number == 20 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460074"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
{{ if $gimme->section->number == 30 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460072"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
{{ if $gimme->section->number == 40 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460075"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
{{ if $gimme->section->number == 50 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460073"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
</div>
{{ /if }}
{{ /list_playlist_articles }}
</div>

{{* FURTHER SECTIONPAGE ARTICLES - use counter to group and cut off previously listed articles *}}


{{ list_playlist_articles columns="5" name=$gimme->section->name }}
  {{ if $gimme->current_list->index == 13 }}
<article>
        <header>
        <p>Weitere Themen</p>
    </header>
    <div class="loader" style="height:297px">
        <ul id="themes-carousel" class="jcarousel-skin-quotes">  
  {{ /if }}
{{ if $gimme->current_list->index > 12 }}
  {{ if $gimme->current_list->column == 3 }}
      <li>
        <ul class="theme-list">
  {{ /if }}
          <li>
            <p>{{ $gimme->section->name }}
              <a href="{{ url options="article" }}">{{ strip }}
                {{ if $gimme->article->SEO_title|trim !== "" }}
                    {{ $gimme->article->SEO_title|escape:'html'|trim }}
                {{ else }}
                    {{ $gimme->article->name|escape:'html'|trim }}
                {{ /if }}
              {{ /strip }}</a>
            </p>
          </li>
  {{ if ($gimme->current_list->column == 2) || $gimme->current_list->at_end }}
        </ul>
      </li>
  {{ /if }}
{{ /if }}
{{ if $gimme->current_list->at_end && $gimme->current_list->index gt 12 }}
        </ul>
        <p class="right-align">Weiterblättern</p>
    <div class="loading" style="height:297px"></div></div>
</article>
{{ /if }}
{{ /list_playlist_articles }}


{{ assign var="cursec" value=$gimme->section->name }}
{{* IF THERE ARE ACTIVE DOSSIERS APPROPRIATE FOR CURRENT SECTION IT WILL BE DISPLAYED HERE *}}
{{ list_articles ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is dossier active is on $cursec is on" }}
                <article>
                    <header>
                        <p>Aktueller Themenschwerpunkt</p>

{{ include file="_tpl/article_info_box.tpl" }}

                    </header>
                    <figure>
                        <a href="{{ uri options="article" }}"><big>Dossier: <b>{{ $gimme->article->name }}</b> {{ $gimme->article->subtitle }}</big></a>
                        {{ include file="_tpl/img/img_640x280.tpl" }}
                    </figure>
                    <p>{{ $gimme->article->lede }}</p>
                </article>                   
{{ /list_articles }}
            
{{* IF THERE IS ACTIVE DEBATTE APPROPRIATE FOR CURRENT SECTION IT WILL BE DISPLAYED HERE *}}            
    
{{ list_articles length="1" ignore_section="true" order="bypublishdate desc" constraints="section is 81 type is deb_moderator $cursec is on" }}            
{{ assign var="debate" value=$cursec }}
{{ /list_articles }}
{{ if $debate == $cursec }}
{{ include file="_tpl/debate_front.tpl" }}
{{ /if }}

            </section>
            
            <aside>

{{ include file="_tpl/newsticker_front.tpl" }}

{{* PARTNER BUTTONS *}}
{{ include file="_tpl/sidebar_partner_buttons.tpl" }}

{{* BLOG TEASERS *}}
{{ include file="_tpl/sidebar_blog_teaser.tpl" blogpl="Blog teasers - {{ $gimme->section->name }}" }}

{{* TEASER BOXES *}}
{{ include file="_tpl/sidebar_teaser_boxes.tpl" }}
                
{{* COMMUNITY ACTIVITY STREAM *}}
{{ include file="_tpl/community_activitystream.tpl" }}
                
                <article>
                    <header>
                        <p>Werbung</p>
                    </header>
                    <span class="werbung">
{{ if $gimme->section->number == 10 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460083"></div>
<!-- END ADITIONTAG -->               
{{ /if }}     
{{ if $gimme->section->number == 20 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460088"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
{{ if $gimme->section->number == 30 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460086"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
{{ if $gimme->section->number == 40 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460089"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
{{ if $gimme->section->number == 50 }}                    
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460087"></div>
<!-- END ADITIONTAG -->               
{{ /if }}
                    </span>
                </article>

{{* LINKS *}}
{{ include file="_tpl/sidebar_links.tpl" linksvar=$gimme->section->name }}

{{ if $gimme->section->number == 10 }}
{{* WEATHER WIDGET *}}
                 <article>
                    <header>
                        <p>Wettervorhersagen</p>
                    </header>
                    <div style="text-align: center">
                    {{ include file="_tpl/weather_sidebar.tpl" }}
                    </div>
                </article>
{{ /if }}

{{* PRINT FRONT PAGE *}}
        {{ include file="_tpl/cover_page.tpl" }}
            
            </aside>

        
        </div>

{{* COMMUNITY AVATARS *}}
{{ include file="_tpl/avatars_front.tpl" }}

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
