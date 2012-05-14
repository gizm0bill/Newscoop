{{ list_playlist_articles length="3" name=$blogpl }}
{{ if $gimme->current_list->at_beginning }}
                <article>
                    <header>
                        <p>{{ if $blogpl == "Blog teasers - Kino" }}Filmblog Lichtspiele{{ else }}Blogs{{ /if }}</p>
                    </header>
                    <ul class="post-list"> 
{{ /if }}       
{{ if $gimme->current_list->index == "1" }}
{{ $showtpic=1 }}
{{ else }}
{{ $showtpic=0 }}
{{ /if }}
{{ $bloginfo=$gimme->article->get_bloginfo() }}                                
                        <li>
                       		{{ list_articles length="1" constraints="type is blog" order="bypublishdate desc" }}
                        	{{ if $showtpic == 1 }}
                        	{{ include file="_tpl/renditions/img_300x150.tpl" }}
                       		{{ /if }}                       		
                            <h4><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h4>
                            <p>{{ $gimme->article->lede|strip_tags|truncate:100 }} <a href="{{ url options="article" }}">Lesen</a> | <a href="{{ url options="section" }}">zum Blog</a></p>
                            <span class="meta">{{ if $bloginfo }}{{ if $gimme->article->get_bloginfo()->image(1)->imageurl }}<img src="{{ $gimme->article->get_bloginfo()->image(1)->imageurl }}" alt="{{ $gimme->section->name }}" width="60" />{{ /if }}{{ /if }} {{ include file="_tpl/relative-date.tpl" date=$gimme->article->publish_date }} auf {{ $gimme->section->name }}</span>
                            {{ /list_articles }}
                        </li>
                        
{{ if $gimme->current_list->at_end }}                        
                    </ul>
                    {{ if !($blogpl == "Blog teasers - Kino") }}
                    <footer>
                        <a href="{{ url options="issue" }}" class="more">Zu den Blogs »</a>
                    </footer>
                    {{ /if }}
                </article>
{{ /if }}
{{ /list_playlist_articles }}                