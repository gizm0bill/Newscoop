<!-- _tpl/list-blog-teaser-front.tpl -->
{{ list_articles length="3" ignore_publication="true" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is blog" }}               
{{ if $gimme->current_list->at_beginning }} 
                <article>
                        <header>
                        <p>TagesWoche Blogs</p>
                    </header>
                    <ul class="two-columns thumb-articles clearfix">
{{ /if }}
{{ if $gimme->current_list->index == 1 }}
                        <li class="left">
{{ elseif $gimme->current_list->index == 2 }}
                        <li class="right">
{{ /if }}
                            <article>
    
                                <h4><a href="{{ url options="article" }}">{{ $gimme->section->name }}</a> <small>{{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }}</small></h4>
                                {{ $bloginfo=$gimme->article->get_bloginfo() }}
                                {{ if $bloginfo }}
                                {{ if $gimme->article->get_bloginfo()->image(1)->imageurl }}
                                <figure>
                                    <a href="{{ url options="article" }}"><img src="{{ $gimme->article->get_bloginfo()->image(1)->imageurl }}" alt="{{ $gimme->section->name }}" width="60" /></a>
                                </figure>
                                {{ /if }}
                                {{ /if }}

                                {{*<h5>{{ $gimme->article->name }}</h5>*}}

                                <p>&laquo;{{ strip }}
{{ if $gimme->current_list->index == 1 }}
  {{$gimme->article->body|regex_replace:'#<div class="cs_img".*</div>#U':''|strip_tags|trim|truncate:400:" [...]"}} 
{{ else }}
  {{$gimme->article->body|regex_replace:'#<div class="cs_img".*</div>#U':''|strip_tags|trim|truncate:100:" [...]"}}
{{ /if }}
{{ /strip }} &raquo; <a href="{{ url options="article" }}">Lesen</a> | <a href="{{ url options="section" }}">zum Blog</a></p>
                            </article>
{{ if $gimme->current_list->index != 2 }}
                        </li>
{{ /if }}
{{ if $gimme->current_list->at_end }} 
                    </ul>
                    <footer>
                        <a href="{{ local }}{{ set_publication identifier="5" }}{{ set_current_issue }}{{ url options="issue" }}{{ /local }}" class="more">Alle Blogs</a>
                    </footer>
                </article>
{{ /if }}
{{ /list_articles }}
<!-- /_tpl/list-blog-teaser-front.tpl -->
