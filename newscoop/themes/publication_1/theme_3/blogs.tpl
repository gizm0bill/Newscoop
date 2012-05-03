{{ include file="_tpl/_html-head.tpl" }}

<body>

{{ include file="_tpl/_netmetrix-stats.tpl" }}

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}

{{ include file="_werbung/front-blogs-header.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box full-width clearfix">
            
            <article>
            	<header>
                	<p>Aktuell in den Blogs</p>
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
            </article>
            
            <article class="single-title">
            	<header>
                	<p>Unsere Blogs</p>
                </header>
            </article>
        	
        </div>
        
        <div class="content-box clearfix">
        
            <section>
            
            	<header class="mobile-header first-in-line">
                	<p><a href="#">Unsere Blogs</a></p>
                </header>
                
                <div class="two-columns mobile-list-view small-titles clearfix">

{{ list_articles ignore_issue="true" ignore_section="true" order="byName asc" constraints="type is bloginfo active is on" }}
                
                    <article>
                        <figure>
                            <big>{{ $gimme->article->name }}</big>
                            <a href="{{ url options="section" }}">{{ include file="_tpl/renditions/img_300x200.tpl" }}</a>
                        </figure>
                        <p>{{ $gimme->article->motto }}</p>
                    </article>

{{ /list_articles }}

                </div>

            </section><!-- / Main Section -->
            
            <aside>
                
{{ include file="_tpl/sidebar-community.tpl" }}
                
{{*** werbung ***}}                
{{ include file="_werbung/front-blogs-sidebar.tpl" }}

{{*** pay what you like ***}}   
{{ include file="_tpl/sidebar-honorieren.tpl" }}                
            
            </aside><!-- / Sidebar -->
            
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}