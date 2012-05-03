{{ include file="_tpl/_html-head.tpl" }}

<body>

{{ include file="_tpl/_netmetrix-stats.tpl" }}

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box clearfix">
            
            <section>
            
{{ include file="_tpl/front-playlist-articles.tpl" }}

<div class="omniticker-main-content desktop-hide">
    <div class="mobile-divider"></div>
    {{ include file="_tpl/sidebar-ticker.tpl" }}
    <div class="mobile-divider"></div>
</div>

<span class="desktop-hide">{{ include file="_tpl/front-blogs.tpl" }}</span>
                
<span class="mobile-hide">{{ include file="_tpl/front-debatte.tpl" }}                
                
{{ include file="_tpl/front-dossiers.tpl" }}

{{*** werbung ***}}   
{{ include file="_werbung/front-maincol.tpl" }}
            
            </section><!-- / Main Section -->
            
            <aside>
            
<span class="mobile-hide">{{ include file="_tpl/sidebar-ticker.tpl" }}</span>

{{ include file="_tpl/sidebar-goodcomments.tpl" }}
 
{{*** werbung ***}}                
{{ include file="_werbung/front-sidebar.tpl" }}

<span class="mobile-hide">{{ include file="_tpl/sidebar-community.tpl" }}
                
{{ include file="_tpl/sidebar-links.tpl" linksvar="Front" }}
                
{{ include file="_tpl/sidebar-partnerbuttons.tpl" }}
                
{{ include file="_tpl/sidebar-storyboard.tpl" }}
                
{{ include file="_tpl/sidebar-cover.tpl" }}
                
{{* include file="_tpl/sidebar-debatte.tpl" *}}
                
{{* include file="_tpl/sidebar-blogs.tpl" blogpl="Blog teasers - front" *}}</span>
            
            </aside><!-- / Sidebar -->
            
        </div>
        
        <div class="content-box full-width clearfix">
        
{{ include file="_tpl/front-bildstoff.tpl" }}
            
<span class="mobile-hide">{{ include file="_tpl/front-blogs.tpl" }}</span>
        	
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">
    
<span class="mobile-hide">{{ include file="_tpl/footer-calendar.tpl" }}</span>

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}