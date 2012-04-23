            <article>
            	<header>
                	<p>Blogs</p>
                </header>
                <ul class="post-list">
                
{{ list_articles length="6" ignore_publication="true" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is blog" }}                

{{ $bloginfo=$gimme->article->get_bloginfo() }}

                	<li>
                    	<h4><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h4>
                        <p>{{$gimme->article->body|regex_replace:'#<div class="cs_img".*</div>#U':''|strip_tags|trim|truncate:100:" [...]"}} <a href="{{ url options="article" }}">Lesen</a> | <a href="{{ url options="section" }}">zum Blog</a></p>
                        <span class="meta">{{ if $bloginfo }}{{ if $gimme->article->get_bloginfo()->image(1)->imageurl }}<img src="{{ $gimme->article->get_bloginfo()->image(1)->imageurl }}" alt="{{ $gimme->section->name }}" width="60" />{{ /if }}{{ /if }} {{ include file="_tpl/relative-date.tpl" date=$gimme->article->publish_date }} auf {{ $gimme->section->name }}</span>
                    </li>

{{ /list_articles }}

                </ul>
                <footer>
                	<a href="{{ local }}{{ set_publication identifier="5" }}{{ set_current_issue }}{{ url options="issue" }}{{ /local }}" class="more">Zu den Blogs »</a>
                </footer>
            </article>