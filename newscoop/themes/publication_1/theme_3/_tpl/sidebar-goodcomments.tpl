{{ $weekbackdate=date_create("-1 week") }}
{{ $weekback=$weekbackdate->format("Y-m-d") }}
{{ list_articles ignore_issue="true" ignore_section="true" order="byLastUpdate desc" constraints="section is 85 type is good_comment publish_date greater_equal $weekback" }}
{{ if $gimme->current_list->at_beginning }}

                <article>
                	<div class="slideshow">
                        <header>
                            <p>Auf den Punkt gebracht</p>
                            <ul class="paging">
                                <li><a href="#" class="grey-button prev">&laquo;</a></li>
                                <li class="caption"></li>
                                <li><a href="#" class="grey-button next">&raquo;</a></li>
                            </ul>
                        </header>
                        <div class="slides">
{{ /if }}                         
                            <div class="slide-item">
                                <blockquote>{{ $gimme->article->comment_community|strip_tags:false }}</blockquote>
                                <small class="quote-meta">{{ $gimme->article->comment_on_comment|replace:"<p>":""|replace:"</p>":""|strip }}</a></small>
                            </div>

{{ if $gimme->current_list->at_end }} 
                        </div>
                        <footer>
                            <a href="#" class="more">Zur Dialogseite »</a>
                        </footer>
                    </div>
                </article>
{{ /if }}
{{ /list_articles }}                                 