{{ include file="_tpl/_html-head.tpl" }}

<body>

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div id="article-front">
        
            <div class="content-box article-single clearfix">
                
                <section>
                
                    <article>
                        <header>
                            <p><a href="#">Basel</a></p>
                        </header>
                        <h2>{{ $gimme->article->name|replace:'  ':'<br />' }}</h2>
                        <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y, %H:%i" }} Uhr {{ if $gimme->article->updated }} (aktualisiert: {{ $gimme->article->updated }}){{ /if }}</span>
                        <h3>{{ if $gimme->article->lede }}{{ $gimme->article->lede|strip_tags }}{{ else }}{{ $gimme->article->DataLead|strip_tags }}{{ /if }} {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }} {{ /if }}{{ /list_article_authors }}</h3>
                        {{ include file="_tpl/article-figure.tpl" }}

								{{ if $gimme->article->body }}{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->body }}{{ else }}{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->DataContent|replace:'h2>':'h4>' }}{{ /if }}

                    </article>
                
                </section><!-- / Main Section -->
                
                <aside>
                
                    <a href="#" class="grey-button article-switch article-view-rear"><span>Hintergrund zum Artikel</span></a>

{{* ARTICLE TOPICS *}}
{{ list_article_topics }}                
{{ if $gimme->current_list->at_beginning }}
                    <article>                                            
                        <header>
                            <p>Mehr zum Thema</p>
                        </header>
                        <p>
{{ /if }}
                        <a href="{{ url options="template _section/section-topic.tpl" }}">{{ $gimme->topic->name }}</a>{{ if !$gimme->current_list->at_end }}, {{ /if }}
                        {{ if $gimme->current_list->at_end }}
                        </p>
                    </article>                        
{{ /if }}   
{{ /list_article_topics }}                    

{{* RELATED ARTICLES *}}
{{ list_related_articles }}
{{ if $gimme->current_list->at_beginning }}  
                    <article>
                        <header>
                            <p>Verwandte Artikel</p>
                        </header>
{{ /if }}                        
                        <p><strong>{{ if !($gimme->article->short_name == "") }}{{ $gimme->article->short_name }}{{ else }}{{ $gimme->article->name }}{{ /if }}</strong> <time>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}{{ if $gimme->article->updated }} (aktualisiert: {{ $gimme->article->updated }}){{ /if }}</time> <a href="{{ url options="article" }}" class="more">Weiterlesen</a></p>
{{ if $gimme->current_list->at_end }}
                    </article>
{{ /if }}
{{ /list_related_articles }}

{{* MAP - display only if set *}}
{{ if $gimme->article->has_map }}   
{{ if $gimme->map->is_enabled }}                 
                    <article>
                        <figure>
                        	{{ map show_locations_list="false" show_reset_link=false auto_focus=false width="100%" height="180" }}
                        	{{ list_map_locations }}{{ if $gimme->current_list->at_beginning }}<p>{{ /if }}{{ $gimme->location->name }}{{ if $gimme->current_list->at_end }}</p>{{ else }}, {{ /if }}{{ /list_map_locations }}
                        </figure>
                    </article>
{{ /if }}
{{ /if }}                    
                    
                    <article>
                        <figure>
                            <big>Dossier: <br />
                            <b>Kulturwerk</b></big>
                            <a href="#"><img src="{{ url static_file="pictures/small-img-1.jpg" }}" rel="resizable" alt="" /></a>
                        </figure>
                    </article>
                  
{{*** WERBUNG ***}}
{{ include file="_werbung/article-sidebar-1.tpl" }}                    
                    
                    <a href="#" class="grey-button article-switch article-view-rear bottom-align"><span>Hintergrund zum Artikel</span></a>
                
                </aside><!-- / Sidebar -->
                
            </div>
            
            <div class="content-box clearfix">
 
{{ include file="_tpl/article-comments.tpl" }}                  
                
                <aside>

{{*** WERBUNG ***}}                
{{ include file="_werbung/article-sidebar-2.tpl" }}  
                
                </aside>
            
            </div>
        
        </div>
        
        <div id="article-rear">
        
            <div class="content-box article-single clearfix">
                
                <section>
                
                    <article>
                        <header>
                            <p><a href="#">Informationen zum Artikel</a></p>
                        </header>
                        <h2>Xherdan Shaqiri: Jetzt müssen sich nur noch FCB und FCB einigen</h2>
                        
                        <ul class="article-info">
                        	<li>
                            	<h5>Themen</h5>
                            	<p><a href="#">FC Basel</a>, <a href="#">Champions League</a></p>
                            </li>
                            <li>
                            	<h5>veröffentlicht</h5>
                            	<p>3.2.2012 - 01:48</p>
                            </li>
                            <li>
                            	<h5>zuletzt geändert</h5>
                            	<p>3.2.2012 - 03:08</p>
                            </li>
                            <li>
                            	<h5>Artikelgeschichte</h5>
                            	<p>Erschienen in der Printausgabe vom 24.2.2012. Erster Abschnitt nach Pressekonferenz des Bundesrats ergänzt.</p>
                            </li>
                            
                            <li>
                            	<h5>Downloads</h5>
                            	<p><a href="#">Klageschrift gegen Wegelin</a> (PDF, 4018kb)</p>
                            </li>
                            <li>
                            	<h5>Quellen</h5>
                            	<p><a href="#">FCB Basel</a> (PDF, 4018kb)<br />
                            	<a href="#">Website vom Fussball Club Basel</a><br />
                            	<a href="#">Quellenangabe Nummer 3</a></p>
                            </li>
                            <li>
                            	<h5>Lokalisierung</h5>
                                <?php /*?><div class="map-holder"><iframe width="511" height="180" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=basel&amp;sll=37.0625,-95.677068&amp;sspn=46.36116,112.412109&amp;t=m&amp;ie=UTF8&amp;hq=&amp;hnear=Basle,+Basel-Stadt,+Switzerland&amp;z=13&amp;ll=47.557421,7.592573&amp;output=embed"></iframe></div><?php */?>
                            </li>
                        </ul>
                        
                        <div class="author-box">
                        	
                            <h4><span>Text:</span> Christoph Kieslich</h4>
                        	<ul class="article-info">
                        		<li class="image">
                            		<img src="{{ url static_file="pictures/author-img-1.jpg" }}" alt="" />
                            		<p>Redakteur bei der Badischen Zeitung, für die er zehn Jahre lang arbeitete, zuletzt als Sportredakteur. Nach viereinhalb Jahren bei der Neugründung Zeitung zum Sonntag in Freiburg, schlossen sich vier Jahre als freier Autor für deutsche und Schweizer Tageszeitungen an. Von April 2005 bis Oktober 2011 Sportredaktor bei der Basler Zeitung.</p>
                            	</li>
                                <li>
                                	<h5>Beiträge</h5>
                                    <p>106</p>
                                </li>
                                <li>
                                	<h5>Social Networks</h5>
                                    <p class="social">
                                    	<a href="#" class="grey-button"><span class="fb">Subscribe</span></a> <a href="#" class="grey-button"><span class="tw">Follow</span></a>
                                    </p>
                                </li>
                            </ul>
                            
                            <div class="tabs article-related-tabs">
                            
                            	<ul>
                                	<li><a href="#author-1">Artikel</a></li>
                                	<li><a href="#author-2">Blogbeiträge</a></li>
                                	<li><a href="#author-3">Kommentare</a></li>
                                </ul>
                                
                                <div id="author-1">
                                	
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>    
                                
                                </div>
                                
                                <div id="author-2">
                                	
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>    
                                
                                </div>
                                
                                <div id="author-3">
                                	
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>    
                                
                                </div>
                            
                            </div>
                            
                            <ul class="paging content-paging">
                                <li><a href="#" class="grey-button">&laquo;</a></li>
                                <li>1/12</li>
                                <li><a href="#" class="grey-button">&raquo;</a></li>
                            </ul>
                        
                        </div>
                        
                        <div class="author-box">
                        	
                            <h4><span>Bild:</span> Max Mustermann</h4>
                        	<ul class="article-info">
                        		<li class="image">
                            		<img src="{{ url static_file="pictures/author-img-1.jpg" }}" alt="" />
                            		<p>Redakteur bei der Badischen Zeitung, für die er zehn Jahre lang arbeitete, zuletzt als Sportredakteur. Nach viereinhalb Jahren bei der Neugründung Zeitung zum Sonntag in Freiburg, schlossen sich vier Jahre als freier Autor für deutsche und Schweizer Tageszeitungen an. Von April 2005 bis Oktober 2011 Sportredaktor bei der Basler Zeitung.</p>
                            	</li>
                                <li>
                                	<h5>Beiträge</h5>
                                    <p>106</p>
                                </li>
                                <li>
                                	<h5>Social Networks</h5>
                                    <p class="social">
                                    	<a href="#" class="grey-button"><span class="fb">Subscribe</span></a> <a href="#" class="grey-button"><span class="tw">Follow</span></a>
                                    </p>
                                </li>
                            </ul>
                            
                            <div class="tabs article-related-tabs">
                            
                            	<ul>
                                	<li><a href="#bild-1">Artikel vom Autor</a></li>
                                	<li><a href="#bild-2">Blogpostings vom Autor</a></li>
                                	<li><a href="#bild-3">Kommentare vom Autor</a></li>
                                </ul>
                                
                                <div id="bild-1">
                                	
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>    
                                
                                </div>
                                
                                <div id="bild-2">
                                	
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>    
                                
                                </div>
                                
                                <div id="bild-3">
                                	
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>    
                                
                                </div>
                            
                            </div>
                            
                            <ul class="paging content-paging">
                                <li><a href="#" class="grey-button">&laquo;</a></li>
                                <li>1/12</li>
                                <li><a href="#" class="grey-button">&raquo;</a></li>
                            </ul>
                        
                        </div>
                        
                        <div class="author-box">
                        	
                            <h4><span>Grafik:</span> Max Mustermann</h4>
                        	<ul class="article-info">
                        		<li class="image">
                            		<img src="{{ url static_file="pictures/author-img-1.jpg" }}" alt="" />
                            		<p>Redakteur bei der Badischen Zeitung, für die er zehn Jahre lang arbeitete, zuletzt als Sportredakteur. Nach viereinhalb Jahren bei der Neugründung Zeitung zum Sonntag in Freiburg, schlossen sich vier Jahre als freier Autor für deutsche und Schweizer Tageszeitungen an. Von April 2005 bis Oktober 2011 Sportredaktor bei der Basler Zeitung.</p>
                            	</li>
                                <li>
                                	<h5>Beiträge</h5>
                                    <p>106</p>
                                </li>
                                <li>
                                	<h5>Social Networks</h5>
                                    <p class="social">
                                    	<a href="#" class="grey-button"><span class="fb">Subscribe</span></a> <a href="#" class="grey-button"><span class="tw">Follow</span></a>
                                    </p>
                                </li>
                            </ul>
                            
                            <div class="tabs article-related-tabs">
                            
                            	<ul>
                                	<li><a href="#grafik-1">Artikel vom Autor</a></li>
                                	<li><a href="#grafik-2">Blogpostings vom Autor</a></li>
                                	<li><a href="#grafik-3">Kommentare vom Autor</a></li>
                                </ul>
                                
                                <div id="grafik-1">
                                	
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>    
                                
                                </div>
                                
                                <div id="grafik-2">
                                	
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>    
                                
                                </div>
                                
                                <div id="grafik-3">
                                	
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>
                                    <span class="time">29.12.2011 um 15:14</span>
                                	<h5>Halte durch, Basel, halte durch! </h5>
                                    <p>Das 2:1 des FC Basel gegen Manchester United – eine Nacht, in der nicht nur Sporthistorie geschrieben wurde. Für einen Moment war Marco Streller auf Twitter in den Top Ten Topics – weltweit.</p>    
                                
                                </div>
                            
                            </div>
                            
                            <ul class="paging content-paging">
                                <li><a href="#" class="grey-button">&laquo;</a></li>
                                <li>1/12</li>
                                <li><a href="#" class="grey-button">&raquo;</a></li>
                            </ul>
                        
                        </div>
                        
                    </article>
                
                </section><!-- / Main Section -->
                
                <aside>
                
                    <a href="#" class="grey-button article-switch article-view-front"><span>Zurück zum Artikel</span></a>
                    
                    <article>
                        <header>
                            <p>Verwandte Artikel</p>
                        </header>
                        <p><strong>Gericht im Senegal erlaubt Wades Kandidatur</strong> Senegals Verfassungsgericht bestätigt umstrittene Kondidatenliste <a href="#" class="more">Weiterlesen</a> <span class="time">23.01.2012</span></p>
                        <p><strong>RBS-Chef verzichtet nach Kritik auf Bonus</strong> Chef der Royal Bank of Scotland lehnt umstrittenen Bonus ab <a href="#" class="more">Weiterlesen</a> <span class="time">23.01.2012</span></p>
                        <p><strong>RBS-Chef verzichtet nach Kritik auf Bonus</strong> Chef der Royal Bank of Scotland lehnt umstrittenen Bonus ab <a href="#" class="more">Weiterlesen</a> <span class="time">23.01.2012</span></p>
                    </article>
                    
                    <article>
                        <header>
                            <p>Tageswoche honorieren</p>
                        </header>
                        <p>Alle Artikel auf tageswoche.ch sind feri verfügbar. Wenn Ihnen unsere Arbeit etwas wert ist, können Sie uns freiwillig unterstützen. Sie entscheiden wieviel Sie bezahlen. Danke, dass Sie uns helfen, tageswoche.ch in Zukunft besser zu machen.</p>
                    </article>
                    
                    <a href="#" class="grey-button reward-button"><span>Jetzt honorieren!</span></a>

{{*** WERBUNG ***}}                    
{{ include file="_werbung/article-sidebar-3-backpage.tpl" }}
                
                    <a href="#" class="grey-button article-switch article-view-front bottom-align"><span>Zurück zum Artikel</span></a>
                
                </aside><!-- / Sidebar -->
                
            </div>
            
        </div>

{{ include file="_tpl/article-bottom-top-news.tpl" }}        
        
    </div><!-- / Wrapper -->
    
     <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}