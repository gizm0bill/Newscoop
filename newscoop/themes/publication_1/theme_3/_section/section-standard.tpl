{{ include file="_tpl/_html-head.tpl" }}

<body>

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box clearfix">
            
            <section>
            
{{ list_playlist_articles length="7" name=$gimme->section->name }}

{{ if $gimme->current_list->index == 2 }}                 
                <div class="mobile-list-view clearfix">
{{ /if }}
 
{{ if $gimme->current_list->index == 1 }}           
            	<article>
                    <figure>
                    	<a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_640x280.tpl" }}</a>
                    </figure>
                    <header>
                        <p><a href="#">Basel</a></p>
                    </header>
                    <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h2>
                    <p>{{ strip }}<!-- {{ $gimme->article->type_name }} --> 
{{ include file="_tpl/admin_frontpageedit.tpl" }}
  {{ if $gimme->article->type_name == "news" }}
    {{ $gimme->article->teaser|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  <a href="{{ url options="article" }}">Weiterlesen</a>
  {{ elseif $gimme->article->type_name == "newswire" }}
    {{ $gimme->article->DataLead|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  <a href="{{ url options="article" }}">Weiterlesen</a> 
  {{ elseif $gimme->article->type_name == "blog" }}
    {{ $gimme->article->lede|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  <a href="{{ url options="article" }}">Weiterlesen</a> 
  {{ /if }}  
{{ /strip }} <a href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a></p>
                </article>

{{ else }}
                    
                    <article>
                        <header>
                            <p><a href="#">International</a></p>
                        </header>
                        <figure class="left">
                            <a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_170x115.tpl" }}</a>
                        </figure>
                        <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h2>
                        <p>{{ strip }}<!-- {{ $gimme->article->type_name }} --> 
{{ include file="_tpl/admin_frontpageedit.tpl" }}
  {{ if $gimme->article->type_name == "news" }}
    {{ $gimme->article->teaser|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  {{ elseif $gimme->article->type_name == "newswire" }}
    {{ $gimme->article->DataLead|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }} 
  {{ elseif $gimme->article->type_name == "blog" }}
    {{ $gimme->article->lede|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }} 
  {{ /if }}  
{{ /strip }} <a href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a></p>
                    </article>
{{ /if }}
                    
{{ if $gimme->current_list->at_end }}                 
                </div>
{{ /if }}                
{{ /list_playlist_articles }}
                
{{*** werbung ***}}   
{{ include file="_werbung/section-maincol.tpl" }}
                
                <article>
                    <header>
                        <p><a href="#">Schweiz</a></p>
                    </header>
                    <h2><a href="#">Keine politischen Gegengeschäfte beim Kampfjet-Kauf erreicht</a></h2>
                </article>
                
                <article>
                    <header>
                        <p><a href="#">International</a></p>
                    </header>
                    <h2><a href="#">Niqab-Trägerin wehrt sich</a></h2>
                </article>
                
                <article>
                    <header>
                        <p><a href="#">Schweiz</a></p>
                    </header>
                    <h2><a href="#">Keine politischen Gegengeschäfte beim Kampfjet-Kauf erreicht</a></h2>
                </article>
                
                <ul class="paging content-paging">
                    <li>Weiterblattern</li>
                    <li><a class="grey-button" href="#">»</a></li>
                </ul>
            
            </section><!-- / Main Section -->
            
            <aside>
            
{{ include file="_tpl/sidebar-ticker.tpl" }}
                
{{ include file="_tpl/sidebar-partnerbuttons.tpl" }}
                
{{ include file="_tpl/sidebar-blogs.tpl" blogpl="Blog teasers - {{ $gimme->section->name }}" }}
                
{{*** werbung ***}}                
{{ include file="_werbung/section-sidebar.tpl" }}
                
{{ include file="_tpl/sidebar-links.tpl" linksvar=$gimme->section->name }}
                
{{ include file="_tpl/sidebar-cover.tpl" }}
            
            </aside><!-- / Sidebar -->
            
        </div>
        
    </div><!-- / Wrapper -->

     <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}