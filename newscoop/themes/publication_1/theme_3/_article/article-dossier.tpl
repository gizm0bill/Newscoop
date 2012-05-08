{{ include file="_tpl/_html-head.tpl" }}

<body>

{{ include file="_tpl/_netmetrix-stats.tpl" }}

	<div id="wrapper">
        
{{ include file="_werbung/article-dossier-header.tpl" }}        
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}

{{ assign var="curnum" value=$gimme->article->number }}       
        
        <div class="content-box full-size clearfix dossier-single">
            <section>
	             <header class="mobile-header">
                	<p><a href="{{ local }}{{ set_publication identifier="5" }}{{ set_current_issue }}{{ url options="issue" }}{{ /local }}">Dossiers</a></p>
                </header>
                <article class="top">              
                    <figure>
                        {{ include file="_tpl/renditions/img_990x330.tpl" }}
                        <big>Dossier:<br />
                        <b>{{ $gimme->article->name }}</b></big>
                    </figure>
                </article>
            </section>
        </div>
        
        <div class="content-box clearfix">
        
        	<section>
            
            	<article>
                	<p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->lede }}</p>
                </article>

{{ if !($gimme->article->history == "") }}                 
                <article class="mobile-hide">
{{ foreach array_filter(explode("<br />", $gimme->article->history)) as $item }}
{{ if $item@first }}                
                	<div class="slideshow">
                        <header class="top-line">
                            <p>Chronologie</p>
                            <ul class="paging">
                                <li><a class="grey-button prev" href="#">«</a></li>
                                <li class="caption"></li>
                                <li><a class="grey-button next" href="#">»</a></li>
                            </ul>
                        </header>
                        <div class="slides">                        
                            <div class="slide-item">
                                <ul class="chrono-list">

{{ elseif $item@index is div by 5 }}
                                </ul>
                            </div>
                            <div class="slide-item">
                                <ul class="chrono-list">                            
{{ /if }}                       

                        			   {{ $itemAry=explode("-", $item, 2) }}
                                    <li>
                                        <span>{{ str_replace("<p>", "", $itemAry[0]) }}</span>
                                        <span>{{ $itemAry[1] }}</span>
                                    </li>

{{ if $item@last }}
                                </ul>
                            </div>
                        </div>
                    </div>
{{ /if }}
{{ /foreach }}                    

                </article>
{{ /if }}

                <div class="mobile-list-view">

{{ list_related_articles }}  
{{ if $gimme->current_list->index lte "3" }}                          
                    {{ capture name="_noimg" assign="_noimg" }}
{{ image rendition="rubrikenseite" }}
<img src="{{ $image->src }}" width="{{ $image->width }}" height="{{ $image->height }}" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" />
{{ /image }}
{{ /capture }}
{{ if trim($_noimg) }}<article>{{ else }}<article class="no-image">{{ /if }}
                        <header>
                        	{{ if $gimme->article->comment_count gt 0 }}<a class="comments" href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }}</a>{{ /if }}
                            <p>{{ if $gimme->article->type_name == "blog" }}{{ $gimme->section->name }}{{ elseif $gimme->article->type_name == "news" }}{{ if !($gimme->article->dateline == "")}}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->section->name }}{{ /if }}{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->article->Newslinetext }}{{ /if }}{{ /if }}&nbsp;</p>
                        </header>
                        <figure class="left">
                            <a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_300x200.tpl" }}</a>
                        </figure>
                        <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h2>
                        <p>{{ include file="_tpl/admin_frontpageedit.tpl" }} 
  {{ if $gimme->article->type_name == "news" }}
    {{ $gimme->article->teaser|strip_tags }}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  
  {{ elseif $gimme->article->type_name == "newswire" }}
    {{ $gimme->article->DataLead|strip_tags }}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }} 

  {{ elseif $gimme->article->type_name == "blog" }}
    {{ $gimme->article->lede|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }} 
  {{ /if }}
{{ if $gimme->article->comment_count gt 0 }}<a href="{{ url options="article" }}#comments" class="comments mobile-hide">{{ $gimme->article->comment_count }} Kommentar{{ if $gimme->article->comment_count gt 1 }}e{{ /if }}</a>{{ /if }}  
  								</p>
                    </article>
{{ /if }}                    
{{ /list_related_articles }}                    
                
                </div>

{{*** werbung ***}}   
{{ include file="_werbung/article-dossier-maincol.tpl" }}

{{ list_related_articles columns="3" }}
{{ if $gimme->current_list->index gt "3" }}
{{ if $gimme->current_list->index == "4" }}                
            	<div class="top-line clearfix slideshow mobile-hide">
               <div class="slides">            	
{{ /if }}
{{ if $gimme->current_list->column == "1" }}                                       
                    <div class="slide-item">
{{ /if }}                    
                    <article>
                        <header>
                            <p>{{ if $gimme->article->type_name == "blog" }}{{ $gimme->section->name }}{{ elseif $gimme->article->type_name == "news" }}{{ if !($gimme->article->dateline == "")}}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->section->name }}{{ /if }}{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->article->Newslinetext }}{{ /if }}{{ /if }}&nbsp;</p>
                        </header>
                        <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h2>
                    </article>
                    
{{ if $gimme->current_list->column == "3" || $gimme->current_list->at_end }}
                    </div><!-- /.slide-item -->
{{ /if }}                    

{{ if $gimme->current_list->at_end }}
                </div><!-- /.slides -->
                    <ul class="paging content-paging">
                        <li><a class="grey-button prev" href="#">«</a></li>
                        <li class="caption"></li>
                        <li><a class="grey-button next" href="#">»</a></li>
                    </ul>                 
                </div>
{{ /if }}         
{{ /if }}       
{{ /list_related_articles }}
            
            </section>
            <aside>    
 {{ if $gimme->article->has_map }}                
                <article>
                    <figure>
                    		<div class="map-holder">
                        {{ map show_locations_list="false" show_reset_link="false" width="300" height="250" auto_zoom=false }}
                        </div>
                    </figure>
                </article>
{{ /if }}                
                
{{ if !($gimme->article->youtube_shortcode == "") }}
					 <article>                         
                    	 <figure>
                      <script type="text/javascript">
var embedParts="{{ $gimme->article->youtube_shortcode }}".split("/");
document.write("<iframe title=\"YouTube video player\" width=\"300\" height=\"229\" src=\"http://www.youtube.com/embed/"+embedParts[3]+"?wmode=opaque\" frameborder=\"0\" allowfullscreen></iframe>");
</script>
                        <p>{{ $gimme->article->youtube_video_description }}</p>
                    </figure>
                </article>
{{ /if }}       
       
{{*** werbung ***}}                
{{ include file="_werbung/article-dossier-sidebar.tpl" }}


{{*** recommended links ***}}
{{ if !($gimme->article->linklist == "") }}            
            	<article class="mobile-hide">
                	<header>
                    	<p>Interessante Links zum Thema</p>
                    </header>
                    
{{ $links=str_replace("<p>", "", explode("</p>", str_replace("<div>", "", str_replace("</div>", "", $gimme->article->linklist)))) }}
{{ foreach $links as $link }}
{{ $linkAry=explode("- ", $link, 2) }}
{{ if count($linkAry) == 2 }}     
               
                    <section class="recommend">
                        <p>{{ substr($linkAry[1], 0) }} {{ $linkAry[0] }}</p>
                    </section>

{{ /if }}
{{ /foreach }}                    

                	<footer>
                    	<a href="#" class="more">Link vorschlagen</a>
                    </footer>
                </article>
{{ /if }}
            
            </aside>
        
        </div>
        
        <div class="content-box full-width clearfix">
        
            <h3 class="title">Weitere Dossiers</h3>
         <div class="dossier-mobile-list">
        	<div class="three-columns clearfix">
        	
{{ list_articles length="6" ignore_issue="true" ignore_section="true" constraints="type is dossier number not $curnum" order="bysection desc" }} 
       	
                <article>
                    <figure>
                        <a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_300x200.tpl" }}</a>
                        <big>Dossier:<br />
                        <b>{{ $gimme->article->name|strip }}</b></big>
                    </figure>
                </article>

{{ /list_articles }}

            </div>
            </div>
        	
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}
   