{{* $weekbackdate=date_create("-1 week") }}
{{ $weekback=$weekbackdate->format("Y-m-d") }}
{{ list_articles length="5" ignore_section="true" order="byRanking desc" constraints="type is news type is newswire publish_date greater_equal $weekback" }}
{{ if $gimme->current_list->at_beginning }}
                    <article style="margin-top: 15px">
                        <header>
                            <p>Aktuell beliebteste Artikel auf TagesWoche</p>
                        </header>
                        <ul class="details">
{{ /if }}                        
                            <li><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
{{ if $gimme->current_list->at_end }}
                        </ul>
                    </article>
{{ /if }}   
{{ /list_articles *}}
