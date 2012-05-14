{{ include file="_tpl/_html-head.tpl" }}
<body>

  <div id="wrapper">
      
{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix dossier">
    
            <div class="top-werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460344"></div>
<!-- END ADITIONTAG -->            
            </div><!-- /.top-werbung -->
    
{{ include file="_tpl/navigation_top.tpl" }}

            <div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

            </div>
            
            <article>
{{ if $gimme->article->comments_enabled }}
<small><a href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a></small>
{{ /if }}            
                <header>
                    
{{ include file="_tpl/article_info_box.tpl" }}
{{ assign var="dosnam" value="&nbsp;" }}{{* we need this to print above every related article *}}
<p>{{ $dosnam }}</p>
                </header>
                <figure>
                    <big class="wide">Dossier: <b>{{ $gimme->article->name }}</b> {{ $gimme->article->subtitle }}</big>
                    {{ include file="_tpl/img/img_980x306.tpl" }}
                </figure>                
            </article>
            
            <section>
                <article>
                  <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->lede }}</p>
                </article>
                
{{ if !($gimme->article->history == "") }}                
                <article>
                    <header>
                        <p>Chronologie der Ereignisse</p>
                    </header>
                    {{ foreach array_filter(explode("<br />", $gimme->article->history)) as $item }}
                    {{ if $item@first }}
                    <div class="loader" style="height:237px">
                    <ul id="sequence-list" class="jcarousel-skin-quotes">
                      <li>
                          <ul class="sequence-list">
                    {{ elseif $item@index is div by 4 }}
                          </ul></li><li><ul class="sequence-list">
                    {{ /if }}
                        {{ $itemAry=explode("-", $item, 2) }}
                        <li><time>{{ str_replace("<p>", "", $itemAry[0]) }}</time> <p>{{ $itemAry[1] }}</p></li>
                    {{ if $item@last }}
                          </ul>
                        </li>
                    </ul>
                    <p class="right-align">weitere Ereignisse</p>
                    <div class="loading" style="height:237px"></div></div>
                    {{ /if }}
                    {{ /foreach }}
                </article>
{{ /if }}       
         
                <div class="article-list-view rubrik-list">

{{ list_related_articles }}  
{{ if $gimme->article->type_name == "deb_moderator" }}
{{ include file="_tpl/debate_section.tpl" }}
{{ else }}
                    <article>
                    <header style="width: 100%">
                            <p>{{ $dosnam }}</p>
{{ if $gimme->article->comments_enable }}
<small><a href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a></small>
{{ /if }}
{{ include file="_tpl/article_info_box.tpl" }}

                        </header>
                        <figure>
                            <a href="{{ url options="article" }}">
                                {{ include file="_tpl/img/img_300x200.tpl" }}
                            </a>
                        </figure> 
                        <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h2>
                        <p>{{ include file="_tpl/admin_frontpageedit.tpl" }} 
  {{ if $gimme->article->type_name == "news" }}
    {{ $gimme->article->teaser|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  <a href="{{ url options="article" }}">Weiterlesen</a>
  {{ elseif $gimme->article->type_name == "newswire" }}
    {{ $gimme->article->DataLead|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  <a href="{{ url options="article" }}">Weiterlesen</a> 
  {{ elseif $gimme->article->type_name == "blog" }}
    {{ $gimme->article->lede|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  <a href="{{ url options="article" }}">Weiterlesen</a> 
  {{ /if }}    
 								</p>
                  </article>
{{ /if }}
{{ /list_related_articles }}
                    
                </div>
{{* here we need to check if the debate is connected to dossier - compare switches, if they have same *}}
{{* include file="_tpl/debate_front.tpl" *}}
                
{{ include file="_tpl/dossier_section_slider.tpl" }}            

            </section>
            
            <aside>

{{ if !($gimme->article->youtube_shortcode == "") }}                
                <article>
                    <header>
                        <p>Video</p>
                    </header>                    
                    <figure>
                      <script type="text/javascript">
var embedParts="{{ $gimme->article->youtube_shortcode }}".split("/");
document.write("<iframe title=\"YouTube video player\" width=\"300\" height=\"229\" src=\"http://www.youtube.com/embed/"+embedParts[3]+"?wmode=opaque\" frameborder=\"0\" allowfullscreen></iframe>");
</script>
                        <p>{{ $gimme->article->youtube_video_description }}</p>
                    </figure>
                </article>
{{ /if }}
                
                <article>
                    <header>
                        <p>Werbung</p>
                    </header>
                    <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460347"></div>
<!-- END ADITIONTAG -->
                    </span>
                </article>

{{* SLIDESHOW *}}

<script type="text/javascript">
$(document).ready(function() {
    $("a.dossier_image_list").fancybox({
        type: 'image'
    });
});
</script>

{{ if $gimme->article->publish_date gt "2012-02-27 13:00:00" || $gimme->article->creation_date gt "2012-02-27 13:00:00"}}

{{ foreach $gimme->article->slideshows as $slideshow }}
<script type="text/javascript">
$(document).ready(function() {
    $("a.big_slideshow_list").fancybox({
        type: 'image'
    });
});
</script>
                <article>
                  <header>
                      <p>Bilder zum Thema</p>
                    </header>
<div class="loader" style="height:255px">
<ul id="side-img-carosel" class="jcarousel-skin-quotes">
    {{ foreach $slideshow->items as $item }}
    <li><figure>
        {{ if $item->is_image }}
        <a href="{{ $item->image->original }}" title="{{ $item->caption }}" class="dossier_image_list" rel="dossier_img_list"><img src="{{ $item->image->src }}" width="300" height="200" alt="{{ $item->caption }}" /><div class="zoomie"></div></a>
        {{ else }}
        {{ video_player video=$item->video width="300" height="200" }}
        {{ /if }}
    </figure></li>
    {{ /foreach }}
</ul>
    <p class="right-align">Weitere</p>
<div class="loading" style="height:255px"></div></div>
{{ /foreach }}

{{ else }}

{{ assign var="slideshow_index" value=0 }}
{{ list_article_images }}
{{ if $gimme->image->article_index gt 11 }}
{{ assign var="slideshow_index" value=$slideshow_index+1 }}
{{ if $slideshow_index == 1 }}
                <article>
                  <header>
                      <p>Bilder zum Thema</p>
                    </header>
                    <div class="loader" style="height:255px">
                    <ul id="side-img-carosel" class="jcarousel-skin-quotes">
{{ /if }}                    
                      <li>
                          <figure>
                          {{ assign var="imgno" value=$gimme->image->article_index }}
                          <a href="{{ url options="image $imgno" }}" class="dossier_image_list" rel="dossier_img_list" ><img src="{{ uri options="image $imgno width 300 height 200" }}" /></a>
                            <p>{{ $gimme->article->image($imgno)->description }}</p>
                        </figure>
                        </li>
{{ if $gimme->current_list->at_end }}                        
                    </ul>
                    <p class="right-align">Weitere</p>
                    <div class="loading" style="height:255px"></div></div>
                </article>
{{ /if }}                
{{ /if }}                
{{ /list_article_images }}

{{ /if }}  
              
 {{ if $gimme->article->has_map }}                
                <article>
                    <header>
                        <p>Ort des Geschehens</p>
                    </header>
                    <figure>
                        {{ map show_locations_list="false" show_reset_link="false" width="300" height="250" auto_zoom=false }}
                    </figure>
                </article>
{{ /if }}
               
{{ if !($gimme->article->linklist == "") }}                
                <article>
                    <header>
                      <p>Interessante Links zum Thema</p>
                    </header>
                    <ul class="item-list side-icons-list">
                        {{ $links=str_replace("<p>", "", explode("</p>", str_replace("<div>", "", str_replace("</div>", "", $gimme->article->linklist)))) }}
                        {{ foreach $links as $link }}
                        {{ $linkAry=explode("- ", $link, 2) }}
                        {{ if count($linkAry) == 2 }}
                        <li class="link">{{ substr($linkAry[1], 0) }}<br />{{ $linkAry[0] }}</li>{{*i substr fixing some unicode white character at the beginning of the string *}}
                        {{ /if }}
                        {{ /foreach }}
                    </ul>                   
                </article>
{{ /if }}
                            
            </aside>
        
        </div>

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}
<link rel="stylesheet" href="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.css') }}" type="text/css" media="screen" />
</body>
</html>
