<!-- BLOG TEASER -->
                        {{ list_playlist_articles name=$blogpl }}

                        {{ if $gimme->current_list->at_beginning }}
                <article>
                    <header>
                    	<p>TagesWoche Blogs</p>
                    </header>
                        <div class="loader" style="height:371px">
                    	<ul id="blog-carousel" class="jcarousel-skin-quotes">
                        {{ /if }}

                    	<li>
                            <figure>
                            	<a href="{{ url options="section" }}"><big>{{ $gimme->article->name }}</big></a><a href="{{ url options="section" }}"><img style="max-width: 100%" alt="" rel="resizable" src="{{ url options="image 1 width 300" }}"></a>
                       	    </figure>
                            <p>{{ $gimme->article->motto }}</p>

                            {{ list_articles length="3" constraints="type is blog" order="bypublishdate desc" }}
                            <section>
                                <h3><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a>
{{ $diff=date_diff(date_create('now'), date_create($gimme->article->publish_date)) }}
{{* include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date *}}</h3>
                                {{ if $gimme->current_list->index == 1 }}
                                <p>{{ $gimme->article->lede|strip_tags|truncate:100 }} » <a href="{{ url options="article" }}">Lesen</a></p>
                                {{ /if }}
                            </section>
                            {{ /list_articles }}
                        </li>

                            {{ if $gimme->current_list->at_end }}
                    	</ul>
                    <p class="right-align">&nbsp;</p>
                    <div class="loading" style="height:371px"></div></div>
                </article>
                            {{ /if }}

                        {{ /list_playlist_articles }}
                
                <!-- END BLOG TEASER -->
