{{ assign var="required_switch" value=$linksvar }}

{{ list_articles length="7" ignore_issue="true" ignore_section="true" constraints="type is link $required_switch is on" }}
{{ if $gimme->current_list->at_beginning }}                
                <article>
                    <header>
                        <p>Die <b>TagesWoche</b> empfiehlt</p>
                    </header>
                    <ul class="item-list side-icons-list">
{{ /if }}                    
                        <li class="link">{{ $gimme->article->link_description|strip_tags }}<br />
                        <a href="{{ $gimme->article->link_url }}" target="_blank">{{ $gimme->article->name }}</a></li>
{{ if $gimme->current_list->at_end }}                         
                    </ul>                    
                        <footer>
                        <a href="javascript:omnibox.showHide();">Link vorschlagen</a>
                    </footer>
                </article>
{{ /if }}
{{ /list_articles }}