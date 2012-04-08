<!-- LATEST BLOG POSTS -->
                        {{ list_articles length="5" order="bypublishdate desc" constraints="type is blog" }}

                        {{ if $gimme->current_list->at_beginning }}
                <article>
                    <header>
                    	<p>Aktuell in diesem Blog</p>
                    </header>
                    	<ul id="blog-posts">
                        {{ /if }}

                    	<li>
                                <h3><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a>
                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
<small class="date relative">{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small>
                                {{ else }}
{{ $diff=date_diff(date_create('now'), date_create($gimme->article->publish_date)) }}
<small class="date relative">vor
{{ if $diff->y }} {{ $diff->y }} {{ if $diff->y > 1 }}Jahre{{ else }}Jahr{{ /if }}{{ /if }}
{{ if $diff->m }} {{ $diff->m }} {{ if $diff->m > 1 }}Monate{{ else }}Monat{{ /if }}{{ /if }}
{{ if $diff->d }} {{ $diff->d }} {{ if $diff->d > 1 }}Tagen{{ else }}Tag{{ /if }}{{ /if }}
{{ if $diff->h && (!$diff->d || empty($short)) }} {{ $diff->h }} Std.{{ /if }}
{{ if !$diff->d && $diff->i && (empty($short) || !$diff->h) }} {{ $diff->i }} Min.{{ /if }}
{{ if !$diff->d && !$diff->h && !$diff->i && $diff->s }} {{ $diff->s }} Sek.{{ /if }}
                                {{ /if }}
</h3>
                                {{* <p>{{ $gimme->article->lede|truncate:100 }}</p> *}}
                        </li>

                            {{ if $gimme->current_list->at_end }}
                    	</ul>
                    <p class="right-align">&nbsp;</p>
                </article>
                            {{ /if }}

                        {{ /list_articles }}
                
<!-- END LATEST BLOG POSTS -->
