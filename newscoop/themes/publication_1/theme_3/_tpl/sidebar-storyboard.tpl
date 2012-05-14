{{ list_articles length="3" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is pinnwand" }}  
{{ if $gimme->current_list->at_beginning }}
                <article>
                	<header>
                    	<p>Storyboard</p>
                    </header>      
{{ /if }}
        <section class="story">
          <p><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></p>
        </section>

{{ if $gimme->current_list->at_end }}
                	<footer>
                    	<a href="{{ url options="article" }}" class="more">Zur Übersicht »</a>
                    </footer>
                </article>
{{ /if }} 
{{ /list_articles }}            