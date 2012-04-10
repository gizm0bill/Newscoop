{{ list_articles length="1" constraints="type is deb_moderator" }}      
{{ assign var="curdeb" value=$gimme->article->number }}
{{ /list_articles }}

{{ list_articles columns="3" ignore_issue="true" ignore_section="true" constraints="type is deb_moderator  number not $curdeb" }}               
{{ if $gimme->current_list->at_beginning }}
            <article>
                <header>
                    <p>Abgeschlossene Wochendebatten</p>
                </header>
                <div class="dossier-list-box">
                    <div class="loader" style="height:263px">
                    <ul id="dossier-list" class="jcarousel-skin-quotes">
{{ /if }}
{{ if $gimme->current_list->column == "1" }}                    
                        <li> 
{{ /if }}                        
                            <article>
                                {{ if $gimme->article->has_image(1) }}
                                <figure>
                                    <img src="{{ uri options="image 1 width 170 height 71 crop center" }}" alt="{{ $gimme->article->image1->description }}" />
                                </figure>
                                {{ /if }}
                                <h3><b><a href="{{ uri options="article" }}">{{ $gimme->article->name }}</a></b><br />
                                <a href="{{ uri options="article" }}">
                                {{ list_articles length="2" constraints="type is deb_statement" }}
                                {{ if $gimme->current_list->at_beginning }}
                                Es debattierten {{ list_article_authors length="1" }}{{ $gimme->author->name }}{{ /list_article_authors }}
                                {{ /if }}
                                {{ if $gimme->current_list->at_end }}
                                &nbsp;und {{ list_article_authors length="1" }}{{ $gimme->author->name }}{{ /list_article_authors }}
                                {{ /if }}
                                {{ /list_articles }}
                                </a></h3>
                            </article>
{{ if ($gimme->current_list->column == 3) || $gimme->current_list->at_end }}                            
                        </li>
{{ /if }}          
{{ if $gimme->current_list->at_end }}              
                    </ul>
                    <p class="right-align">Weitere Debatten</p>
                    <div class="loading" style="height:263px"></div></div>
                </div>
            </article>                    
{{ /if }}
{{ /list_articles }}
