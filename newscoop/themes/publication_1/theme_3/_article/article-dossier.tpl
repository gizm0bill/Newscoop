{{ include file="_tpl/_html-head.tpl" }}

<body>

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box full-size clearfix">
            <section>
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
                <article>
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
                    <article>
                        <header>
                            <p><a href="#">Schweiz</a></p>
                        </header>
                        <figure class="left">
                            <a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_300x200.tpl" }}</a>
                        </figure>
                        <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h2>
                        <p>{{ include file="_tpl/admin_frontpageedit.tpl" }} 
  {{ if $gimme->article->type_name == "news" }}
    {{ $gimme->article->teaser|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  {{ elseif $gimme->article->type_name == "newswire" }}
    {{ $gimme->article->DataLead|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }} 
  {{ elseif $gimme->article->type_name == "blog" }}
    {{ $gimme->article->lede|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }} 
  {{ /if }}
<a class="comments" href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a>  
  								</p>
                    </article>
{{ /list_related_articles }}                    
                
                </div>
                
                <article>
                    <header class="top-line">
                        <p><em>Werbung</em></p>
                    </header>
                    <figure>
                    	<a href="#"><img src="pictures/werbung-content-1.png" alt="" /></a>
                    </figure>
                </article>
                
            	<div class="top-line clearfix">
                
                    <article>
                        <header>
                            <p><a href="#">Schweiz</a></p>
                        </header>
                        <h2><a href="#">Keine politischen Gegengeschäfte beim sdfsd Kauf erreicht</a></h2>
                    </article>
                    
                    <article>
                        <header>
                            <p><a href="#">Schweiz</a></p>
                        </header>
                        <h2><a href="#">Keine politischen Gegengeschäfte beim </a></h2>
                    </article>
                    
                    <article>
                        <header>
                            <p><a href="#">Schweiz</a></p>
                        </header>
                        <h2><a href="#">Keine politischen</a></h2>
                    </article>
                    
                    <ul class="paging content-paging">
                        <li><a class="grey-button" href="#">«</a></li>
                        <li>1/12</li>
                        <li><a class="grey-button" href="#">»</a></li>
                    </ul>
                
                </div>
            
            </section>
            
            <aside>
            
            	<article>
                    <figure>
                        <div class="map-holder"><iframe width="304" height="180" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=basel&amp;sll=37.0625,-95.677068&amp;sspn=46.36116,112.412109&amp;t=m&amp;ie=UTF8&amp;hq=&amp;hnear=Basle,+Basel-Stadt,+Switzerland&amp;z=13&amp;ll=47.557421,7.592573&amp;output=embed"></iframe></div>
                        <p>Stadion St. Jakob</p>
                    	<iframe width="306" height="185" src="http://www.youtube.com/embed/yiIc0wee-HQ" frameborder="0" allowfullscreen></iframe>
                    	<p>Video zum Dossier</p>
                    </figure>
                </article>
            
            	<article>
                	<header>
                    	<p><em>Werbung</em></p>
                    </header>
                    <span class="werbung">
                    	<img src="pictures/werbung-sidebar.jpg"  rel="resizable" alt="" />
                    </span>
                </article>
            
            	<article>
                	<header>
                    	<p>Interessante Links zum Thema</p>
                    </header>
                    <section class="recommend">
                        <p>Bei Spox.com gibt es ein Video vom Eklat an der Pressekonferenz nach dem Boxkampf Klitschko vs. Chisora. <a href="#">Schlägerei! Riesen-Skandal nach Klitschko-Sieg</a></p>
                    </section>
                    <section class="recommend">
                        <p>Bei Spox.com gibt es ein Video vom Eklat an der Pressekonferenz nach dem Boxkampf Klitschko vs. Chisora. <a href="#">Schlägerei! Riesen-Skandal nach Klitschko-Sieg</a></p>
                    </section>
                    <section class="recommend">
                        <p>Bei Spox.com gibt es ein Video vom Eklat an der Pressekonferenz nach dem Boxkampf Klitschko vs. Chisora. <a href="#">Schlägerei! Riesen-Skandal nach Klitschko-Sieg</a></p>
                    </section>
                	<footer>
                    	<a href="#" class="more">Link vorschlagen</a>
                    </footer>
                </article>
            
            </aside>
        
        </div>
        
        <div class="content-box full-width clearfix">
        
            <h3 class="title">Weitere Dossiers</h3>
            
        	<div class="three-columns clearfix">
                <article>
                    <figure>
                        <a href="#"><img src="pictures/top-news-1.jpg" rel="resizable" alt="" /></a>
                        <big>Dossier:<br />
                        <b>Europa in der Krise</b></big>
                    </figure>
                </article>
                <article>
                    <figure>
                        <a href="#"><img src="pictures/top-news-1.jpg" rel="resizable" alt="" /></a>
                        <big>Dossier:<br />
                        <b>Europa in der Krise</b></big>
                    </figure>
                </article>
                <article>
                    <figure>
                        <a href="#"><img src="pictures/top-news-1.jpg" rel="resizable" alt="" /></a>
                        <big>Dossier:<br />
                        <b>Europa in der Krise</b></big>
                    </figure>
                </article>
                <article>
                    <figure>
                        <a href="#"><img src="pictures/top-news-1.jpg" rel="resizable" alt="" /></a>
                        <big>Dossier:<br />
                        <b>Europa in der Krise</b></big>
                    </figure>
                </article>
                <article>
                    <figure>
                        <a href="#"><img src="pictures/top-news-1.jpg" rel="resizable" alt="" /></a>
                        <big>Dossier:<br />
                        <b>Europa in der Krise</b></big>
                    </figure>
                </article>
                <article>
                    <figure>
                        <a href="#"><img src="pictures/top-news-1.jpg" rel="resizable" alt="" /></a>
                        <big>Dossier:<br />
                        <b>Europa in der Krise</b></big>
                    </figure>
                </article>
            </div>
        	
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}