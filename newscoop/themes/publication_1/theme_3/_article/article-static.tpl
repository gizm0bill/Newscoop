{{ include file="_tpl/_html-head.tpl" }}

<body>

{{ include file="_tpl/_netmetrix-stats.tpl" }}

<div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '204329636307540',
      xfbml      : true  // parse XFBML
    });
  };

  // Load the SDK Asynchronously
  (function(d){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     ref.parentNode.insertBefore(js, ref);
   }(document));
</script>

	<div id="wrapper">      
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
            <div class="content-box article-single clearfix">
            
            <section>
                
                    <article class="article-main-front">
                        <header>
                            <p>{{ if $gimme->article->type_name == "blog" }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ elseif $gimme->article->type_name == "news" }}{{ if !($gimme->article->dateline == "")}}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->section->name }}{{ /if }}{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->article->Newslinetext }}{{ /if }}{{ /if }}&nbsp;</p>
                        </header>
                        <p class="time desktop-hide">{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y, %H:%i" }} Uhr</p>
                        <h2>{{ $gimme->article->name|replace:'  ':'<br />' }}</h2>
                        <span class="time mobile-hide">{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y, %H:%i" }} Uhr {{ if $gimme->article->updated }} (aktualisiert: {{ $gimme->article->updated }}){{ /if }}</span>
                        {{ include file="_tpl/article-figure.tpl" }}

								{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->body }}

                    </article>
                    
                    {{ include file="_tpl/social-bookmarks.tpl" }}
                
                </section><!-- / Main Section -->
                
                <aside>                              

<ul class="article-info">
        
                            <li>
                            	<h5>veröffentlicht</h5>
                            	<p>{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y - %H:%i" }}</p>
                            </li>
                            <li>
                            	<h5>zuletzt geändert</h5>
                            	<p>{{ $gimme->article->last_update|camp_date_format:"%e.%c.%Y - %H:%i" }}</p>
                            </li>
                            
                            {{ if $gimme->article->history != "" }}
                            <li>
                            	<h5>Artikelgeschichte</h5>
                            	<p>{{ $gimme->article->history }}</p>
                            </li>
                            {{ /if }}
                            
                            {{ list_article_attachments }}
									 {{ if $gimme->current_list->at_beginning }}
                            <li>
                            	<h5>Downloads</h5>
                            {{ /if }}
                            	<p><a href="{{ url options="articleattachment" }}">{{ $gimme->attachment->description }}</a> ({{ $gimme->attachment->extension|upper }}, {{ $gimme->attachment->size_kb }}kb)</p>
									 {{ if $gimme->current_list->at_end }}
                            </li>
                            {{ /if }}
                            {{ /list_article_attachments }}                            
                            
                            {{ if $gimme->article->sources != "" }}
                            <li>
                            	<h5>Quellen</h5>
                            	<p>{{ $gimme->article->sources }}</p>
                            </li>
                            {{ /if }}
									
									 <li>
                            	<h5>Artikel-Webcode</h5>
                            	<p>tageswoche.ch/{{ $gimme->article->webcode }}</p>
                            </li>                            
                        </ul>

                         
                
                </aside><!-- / Sidebar -->
                
            </div>

{{ include file="_tpl/article-bottom-top-news.tpl" }}        
        
    </div><!-- / Wrapper -->
    
     <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}