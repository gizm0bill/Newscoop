{{ include file="_tpl/_html-head.tpl" }}

<body>

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box clearfix">
            
            <section>
            
{{ include file="_tpl/front-playlist-articles.tpl" }}
                
{{ include file="_tpl/front-debatte.tpl" }}                
                
{{ include file="_tpl/front-dossiers.tpl" }}

{{*** werbung ***}}   
{{ include file="_werbung/front-maincol.tpl" }}
            
            </section><!-- / Main Section -->
            
            <aside>
            
{{ include file="_tpl/sidebar-ticker.tpl" }}

{{ include file="_tpl/sidebar-goodcomments.tpl" }}
 
{{*** werbung ***}}                
{{ include file="_werbung/front-sidebar.tpl" }}

{{ include file="_tpl/sidebar-community.tpl" }}
                
{{ include file="_tpl/sidebar-links.tpl" linksvar="Front" }}
                
{{ include file="_tpl/sidebar-partnerbuttons.tpl" }}
                
{{ include file="_tpl/sidebar-storyboard.tpl" }}
                
{{ include file="_tpl/sidebar-cover.tpl" }}
                
{{ include file="_tpl/sidebar-debatte.tpl" }}
                
{{ include file="_tpl/sidebar-blogs.tpl" blogpl="Blog teasers - front" }}
            
            </aside><!-- / Sidebar -->
            
        </div>
        
        <div class="content-box full-width clearfix">
        
{{ include file="_tpl/front-bildstoff.tpl" }}
            
{{ include file="_tpl/front-blogs.tpl" }}
        	
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}