{{ assign var="required_switch" value=$linksvar }}
{{ list_articles length="7" ignore_issue="true" ignore_section="true" constraints="type is link $required_switch is on" }}
{{ if $gimme->current_list->at_beginning }}  
                <article>
                	<header>
                    	<p>Die TagesWoche empfiehlt</p>
                    </header>
{{ /if }}                     
                    <section class="recommend">
                        <p>{{ $gimme->article->link_description|strip_tags }} <a href="{{ $gimme->article->link_url }}" target="_blank">{{ $gimme->article->name }}</a></p>
                    </section>

{{ if $gimme->current_list->at_end }}                     
                	<footer>
                    	<a href="#" class="more" style="float: left">Link vorschlagen</a><a href="/ticker/?source=link" class="right more">Alle links»</a>
                    </footer>
                </article>
{{ /if }}                 
{{ /list_articles }}