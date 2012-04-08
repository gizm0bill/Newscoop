{{ if $gimme->article->defined }}
{{ assign var="curart" value=$gimme->article->number }}
{{ else }}
{{ assign var="curart" value=0 }}
{{ /if }}
{{ if $gimme->article->defined }}{{* if slider is shown on dossier page, then show all other dossiers... *}}
{{ list_articles columns="3" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is dossier number not $curart" }}
{{ if $gimme->current_list->at_beginning }}                
                <article>
                    <header>
                        <p>Weitere Dossiers</p>
                    </header>
                <div class="dossier-list-box">
                    <div class="loader" style="height:288px">
                    <ul id="dossier-list" class="jcarousel-skin-quotes">
{{ /if }}            
{{ if $gimme->current_list->column == "1" }}        
                        <li> 
{{ /if }}                        
                            <article>
                                {{ if $gimme->article->has_image(1) }}
                                <figure>
                                    <a href="{{ url options="article" }}"><img src="{{ url options="image 1 width 170 height 71 crop center" }}" alt="{{ $gimme->article->image1->description }}" /></a>
                                </figure>
                                {{ /if }}
                                <h3><b><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></b><br /><a href="{{ url options="article" }}">{{ $gimme->article->subtitle }}</a></h3>
                            </article>

{{ if $gimme->current_list->column == "3" || $gimme->current_list->at_end }}                             
                        </li>
{{ /if }}         
{{ if $gimme->current_list->at_end }}               
                    </ul>
                    <p class="right-align">Weiterblättern</p>
                    <div class="loading" style="height:288px"></div></div>
                </div>
                </article>                    
{{ /if }}
{{ /list_articles }}

{{ else }}{{* ...else if on dossiers overview page, show only inactive dossiers *}}

{{ list_articles columns="3" ignore_issue="true" ignore_section="true" constraints="type is dossier active is off number not $curart" }}
{{ if $gimme->current_list->at_beginning }}                
                <article>
                    <header>
                        <p>Weitere Dossiers</p>
                    </header>
                <div class="dossier-list-box">
                    <div class="loader" style="height:288px">
                    <ul id="dossier-list" class="jcarousel-skin-quotes">
{{ /if }}            
{{ if $gimme->current_list->column == "1" }}        
                        <li> 
{{ /if }}                        
                            <article>
                                {{ if $gimme->article->has_image(1) }}
                                <figure>
                                    <a href="{{ url options="article" }}"><img src="{{ url options="image 1 width 170 height 71 crop center" }}" alt="{{ $gimme->article->image1->description }}" /></a>
                                </figure>
                                {{ /if }}
                                <h3><b><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></b><br /><a href="{{ url options="article" }}">{{ $gimme->article->subtitle }}</a></h3>
                            </article>

{{ if $gimme->current_list->column == "3" || $gimme->current_list->at_end }}                             
                        </li>
{{ /if }}         
{{ if $gimme->current_list->at_end }}               
                    </ul>
                    <p class="right-align">Weiterblättern</p>
                    <div class="loading" style="height:288px"></div></div>
                </div>
                </article>                    
{{ /if }}
{{ /list_articles }} 
{{ /if }}
