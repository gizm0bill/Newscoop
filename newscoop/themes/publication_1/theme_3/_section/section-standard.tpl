{{ include file="_tpl/_html-head.tpl" }}

<body>

{{ include file="_tpl/_netmetrix-stats.tpl" }}

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}

{{ include file="_werbung/section-header.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box clearfix">
            
            <section>
            
{{ list_playlist_articles length="10" name=$gimme->section->name }}

{{ if $gimme->current_list->index == 2 }}                 
                <div class="mobile-list-view clearfix">
{{ /if }}
 
{{ if $gimme->current_list->index == 1 }}           
            	<article>
                    <figure>
                    	<a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_640x280.tpl" }}</a>
                    </figure>
                    <header>
                        <p>{{ if $gimme->article->type_name == "blog" }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ elseif $gimme->article->type_name == "news" }}{{ if !($gimme->article->dateline == "")}}<a href="{{ url options="article" }}">{{ $gimme->article->dateline }}</a>{{ else }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ /if }}{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}<a href="{{ url options="article" }}">{{ $gimme->article->dateline }}</a>{{ else }}<a href="{{ url options="article" }}">{{ $gimme->article->Newslinetext }}</a>{{ /if }}{{ /if }}&nbsp;</p>
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
{{ /strip }} 
{{ if $gimme->article->comment_count gt 0 }}<a href="{{ url options="article" }}#comments" class="comments">{{ $gimme->article->comment_count }} Kommentar{{ if $gimme->article->comment_count gt 1 }}e{{ /if }}</a>{{ /if }}
</p>
                </article>

{{ else }}
                    
                    <article>
                        <header>
                            <p>{{ if $gimme->article->type_name == "blog" }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ elseif $gimme->article->type_name == "news" }}{{ if !($gimme->article->dateline == "")}}<a href="{{ url options="article" }}">{{ $gimme->article->dateline }}</a>{{ else }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ /if }}{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}<a href="{{ url options="article" }}">{{ $gimme->article->dateline }}</a>{{ else }}<a href="{{ url options="article" }}">{{ $gimme->article->Newslinetext }}</a>{{ /if }}{{ /if }}&nbsp;</p>
                        </header>
                        {{* img_170x115.tpl is checking if rendtion exists, and if it does, only then it puts <figure> and <a> tags around the image  *}}
                        {{ include file="_tpl/renditions/img_170x115.tpl" where="sec-standard" }}
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
{{ /strip }} {{ if $gimme->article->comment_count gt 0 }}<a href="{{ url options="article" }}#comments" class="comments">{{ $gimme->article->comment_count }} Kommentar{{ if $gimme->article->comment_count gt 1 }}e{{ /if }}</a>{{ /if }}</p>
                    </article>
{{ /if }}
                    
{{ if $gimme->current_list->at_end }}                 
                </div>
{{ /if }}                
{{ /list_playlist_articles }}                
                
{{*** werbung ***}}   
{{ include file="_werbung/section-maincol.tpl" }}

{{ list_playlist_articles columns="4" length="30" name=$gimme->section->name }}
{{ if $gimme->current_list->index gt 10 }}
{{ if $gimme->current_list->index == 11 }}                
            	<div class="top-line clearfix slideshow mobile-hide">
               <div class="slides">            	
{{ /if }}                
{{ if $gimme->current_list->column == "3" }}                                       
                    <div class="slide-item">
{{ /if }}                    
                <article>
                    <header>
                        <p>{{ if $gimme->article->type_name == "blog" }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ elseif $gimme->article->type_name == "news" }}{{ if !($gimme->article->dateline == "")}}<a href="{{ url options="article" }}">{{ $gimme->article->dateline }}</a>{{ else }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ /if }}{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}<a href="{{ url options="article" }}">{{ $gimme->article->dateline }}</a>{{ else }}<a href="{{ url options="article" }}">{{ $gimme->article->Newslinetext }}</a>{{ /if }}{{ /if }}&nbsp;</p>
                    </header>
                    <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h2>
                </article>                

{{ if $gimme->current_list->column == "2" || $gimme->current_list->at_end }}
                    </div><!-- /.slide-item -->                   
{{ /if }}

{{ if $gimme->current_list->at_end }}
                </div><!-- /.slides -->
                    <ul class="paging content-paging">
                        <li><a class="grey-button prev" href="#">«</a></li>
                        <li class="caption"></li>
                        <li><a class="grey-button next" href="#">»</a></li>
                    </ul>                 
                </div>
{{ /if }}         
{{ /if }}       
{{ /list_playlist_articles }}
            
            
            </section><!-- / Main Section -->
            
            <aside>

{{ if !($gimme->section->number == 60) }}             
{{ include file="_tpl/sidebar-ticker.tpl" id="single" }}
{{ include file="_tpl/sidebar-ticker-init.tpl" ids="single" }}
{{ /if }}

<span class="mobile-hide">                
{{ include file="_tpl/sidebar-partnerbuttons.tpl" }}
</span>                

<span class="mobile-hide">                
{{ include file="_tpl/sidebar-blogs.tpl" blogpl="Blog teasers - {{ $gimme->section->name }}" }}
</span>
                
{{*** werbung ***}}                
{{ include file="_werbung/section-sidebar.tpl" }}

<span class="mobile-hide">                

{{ include file="_tpl/sidebar-links.tpl" linksvar=$gimme->section->name }}
                
{{ include file="_tpl/sidebar-dossier.tpl" }}              
                
{{ include file="_tpl/sidebar-cover.tpl" }}

</span>
            
            </aside><!-- / Sidebar -->
            
        </div>
        
    </div><!-- / Wrapper -->

     <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}
