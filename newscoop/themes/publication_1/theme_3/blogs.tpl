{{ include file="_tpl/_html-head.tpl" }}

<body>

{{ include file="_tpl/_netmetrix-stats.tpl" }}

	<div id="wrapper">
        
{{ include file="_werbung/front-blogs-header.tpl" }}        
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
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
                	<p><span class="mobile-hide">Unsere </span>Blogs</p>
                </header>
            </article>
        	
        </div>
        
        <div class="content-box clearfix">
        
            <section>
            
            	<header class="mobile-header first-in-line">
                	<p><span class="mobile-hide">Unsere </span>Blogs</p>
                </header>
                
                <div class=" two-columns mobile-list-view dossier-mobile-list small-titles clearfix">

{{ list_articles ignore_issue="true" ignore_section="true" order="byName asc" constraints="type is bloginfo active is on" }}
                
                    <article>
                        <figure>
                            <big>{{ $gimme->article->name }}</big>
                            <a href="{{ url options="section" }}">{{ include file="_tpl/renditions/img_300x200.tpl" where="blogs" }}</a>
                        </figure>
                        <p>{{ $gimme->article->motto }}</p>
                    </article>

{{ /list_articles }}

                </div>

            </section><!-- / Main Section -->
            
            <aside>

<span class="mobile-hide">                
{{ include file="_tpl/sidebar-community.tpl" }}
</span>
                
{{*** werbung ***}}                
{{ include file="_werbung/front-blogs-sidebar.tpl" }}

<span class="mobile-hide">
{{*** pay what you like ***}}   
{{ include file="_tpl/sidebar-honorieren.tpl" }}                
</span>
            
            </aside><!-- / Sidebar -->
            
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}