{{ include file="_tpl/_html-head.tpl" }}

<body>

{{ include file="_tpl/_netmetrix-stats.tpl" }}

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box clearfix">
            
            <section>
            
                <article class="quote-list mobile-hide">            
{{ $weekbackdate=date_create("-1 week") }}
{{ $weekback=$weekbackdate->format("Y-m-d") }}
{{ list_articles length="4" ignore_issue="true" ignore_section="true" order="byLastUpdate desc" constraints="section is 85 type is good_comment publish_date greater_equal $weekback" }}                
                
                    <blockquote>{{ $gimme->article->comment_community|strip_tags:false }}</blockquote>
                    <small class="quote-meta">{{ $gimme->article->comment_on_comment|replace:"<p>":""|replace:"</p>":""|strip }}</a></small>
                    
{{ /list_articles }}
                </article>
                
                <aside class="desktop-hide">
                {{ include file="_tpl/sidebar-goodcomments.tpl" }}
                </aside>					
					
{{ include file="_tpl/dialog-article-comments.tpl" }}

            </section><!-- / Main Section -->

            <aside class="mobile-hide">

{{ include file="_tpl/sidebar-community.tpl" where="dialog" }}

{{ include file="_tpl/sidebar-facebook.tpl" }}

{{ include file="_tpl/sidebar-twitter.tpl" where="dialog" }}

<div class="right"><a href="https://twitter.com/tageswoche" class="twitter-follow-button" data-show-count="false" data-lang="de" data-size="large">@tageswoche folgen</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script></div>

{{ include file="_tpl/sidebar-blogs.tpl" blogpl="Blog teasers - {{ $gimme->section->name }}" }}

{{ include file="_tpl/sidebar-debatte.tpl" }}

            </aside><!-- / Sidebar -->
            
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}
