{{ include file="_tpl/_html-head.tpl" }}

<body>

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box dossier-overview clearfix">
        
        	<section>

{{ list_articles ignore_issue="true" ignore_section="true" constraints="type is dossier active is on" order="bysection desc" }}
            
{{ if $gimme->current_list->index == 2 }}                 
                <div class="mobile-list-view clearfix">
{{ /if }}            
 
{{ if $gimme->current_list->index == 1 }}            
            	<article>
                    <figure>
                        <a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_640x280.tpl" }}</a>
                        <big>Dossier:<br />
                        <b>{{ $gimme->article->name|strip }}</b> {{ $gimme->article->subtitle }}</big>
                    </figure>
                    <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->lede|strip_tags }} <a href="{{ url options="article" }}">Zum Dossier</a></p>
                </article>
{{ else }}            
                    <article>
                        <figure class="left">
                            <a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_300x200.tpl" }}</a>
                        </figure>
                        <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|strip }}</a></h2>
                        <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->lede|strip_tags }}  <a href="{{ url options="article" }}">Zum Dossier</a></p>
                    </article>
{{ /if }}                    

{{ if $gimme->current_list->at_end }}                 
                </div>
{{ /if }}                
{{ /list_articles }}
            
            </section>
            
            <aside>
           
            	<article>
                    <header>
                        <p>Alle Dossiers</p>
                    </header>
                    <div class="slideshow">
								<div class="slides">
                    		
{{ list_articles columns="5" ignore_issue="true" ignore_section="true" constraints="type is dossier active is off" }}
{{ if $gimme->current_list->column == "1" }}                    	
	
                        <ul class="dossier-litem-list slide-item">
{{ /if }}                        

                        	<li><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
                        	
{{ if $gimme->current_list->column == "5" || $gimme->current_list->at_end }}                        	
                        </ul>
{{ /if }}                
{{ /list_articles }} 
                        </div>
                        <ul class="paging right">
                           <li><a href="#" class="grey-button prev">&laquo;</a></li>
                           <li class="caption"></li>
                           <li><a href="#" class="grey-button next">&raquo;</a></li>
                        </ul>
                    </div>
                </article>
               
{{*** werbung ***}}                
{{ include file="_werbung/section-dossier-sidebar.tpl" }}
                
                <article>
                	<header>
                    	<p>Tageswoche honorieren</p>
                    </header>
                    <p>Alle Artikel auf tageswoche.ch sind feri verfügbar. Wenn Ihnen unsere Arbeit etwas wert ist, können Sie uns freiwillig unterstützen. Sie entscheiden wieviel Sie bezahlen. Danke, dass Sie uns helfen, tageswoche.ch in Zukunft besser zu machen.</p>
                    <a class="grey-button reward-button" href="#"><span>Jetzt honorieren!</span></a>
                </article>
            
            </aside>
        
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}