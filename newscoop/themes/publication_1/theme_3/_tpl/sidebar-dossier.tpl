{{ assign var="cursec" value=$gimme->section->name }}
{{* IF THERE ARE DOSSIERS APPROPRIATE FOR CURRENT SECTION IT WILL BE DISPLAYED HERE *}}
{{ list_articles length="2" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is dossier $cursec is on" }}
{{ if $gimme->current_list->at_beginning }}
                <article class="teaser-box">
                	<header>
                    	<p>Dossiers</p>
                    </header>
{{ /if }}                    
                    <section>
                    	  <a href="{{ url options="article" }}">
                        <figure>
                        	<big><b>{{ $gimme->article->name }}</b></big>
                        	{{ include file="_tpl/renditions/img_300x133.tpl" }}
                        </figure>
                        </a>
                    	  <p>{{ $gimme->article->lede }}</p>
                    </section>

{{ if $gimme->current_list->at_end }}                    
                </article>
{{ /if }} 
{{ /list_articles }}