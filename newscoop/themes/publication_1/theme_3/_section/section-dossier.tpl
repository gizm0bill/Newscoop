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
                    <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ if !($gimme->article->teaser == "") }}{{ $gimme->article->teaser|strip_tags }}{{ else }}{{ $gimme->article->lede|strip_tags }}{{ /if }} <a href="{{ url options="article" }}">Zum Dossier</a></p>
                </article>
{{ else }}            
                    <article>
                        <figure class="left">
                            <a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_300x200.tpl" }}</a>
                        </figure>
                        <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|strip }}</a></h2>
                        <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ if !($gimme->article->teaser == "") }}{{ $gimme->article->teaser|strip_tags }}{{ else }}{{ $gimme->article->lede|strip_tags }}{{ /if }}  <a href="{{ url options="article" }}">Zum Dossier</a></p>
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
                        <p>Topics</p>
                    </header>                    	
                        <ul class="dossier-litem-list">    
                        	<li><a href="">Hardcoded topic 1</a></li>
                        	<li><a href="">Hardcoded topic 2</a></li>
                        	<li><a href="">Hardcoded topic 3</a></li>
                        	<li><a href="">Hardcoded topic 4</a></li>  	
                        </ul>
              </article>      
           
            	<article>
                    <header>
                        <p>Alle Dossiers</p>
                    </header>
                    		
{{ list_articles ignore_issue="true" ignore_section="true" order="byname asc" constraints="type is dossier" }}
{{ if $gimme->current_list->at_beginning == "1" }}                    	
	
                        <ul class="dossier-litem-list">
{{ /if }}                        

                        	<li><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
                        	
{{ if $gimme->current_list->at_end }}                        	
                        </ul>
{{ /if }}                
{{ /list_articles }} 

                </article>
               
{{*** werbung ***}}                
{{ include file="_werbung/section-dossier-sidebar.tpl" }}
                
{{ include file="_tpl/sidebar-honorieren.tpl" }}
            
            </aside>
        
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}