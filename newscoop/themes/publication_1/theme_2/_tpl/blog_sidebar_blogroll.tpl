{{ list_articles constraints="type is link" }}
{{ if $gimme->current_list->at_beginning }}                
                <article>
                    <header>
                        <p>Blogroll</p>
                    </header>
                    <ul class="item-list side-icons-list">
{{ /if }}                    
                        <li class="link">{{ $gimme->article->link_description|strip_tags }}<br />
                        <a href="{{ $gimme->article->link_url }}" target="_blank">{{ $gimme->article->name }}</a></li>
{{ if $gimme->current_list->at_end }}                         
                    </ul>                    
                </article>
{{ /if }}
{{ /list_articles }}
