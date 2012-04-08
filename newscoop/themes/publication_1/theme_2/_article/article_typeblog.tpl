{{ include file="_tpl/_html-head.tpl" }}<body>

        <div id="wrapper">
        
{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix blog-single">
    
            <div class="top-werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460345"></div>
<!-- END ADITIONTAG -->            
            </div><!-- /.top-werbung -->
    
{{ include file="_tpl/navigation_top.tpl" }}

<div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}
</div>  

{{ if $gimme->section->number >= "200" }}
          <div class="wide-box">
         
              <article class="article-text">
                  {{ list_articles length="1" constraints="type is bloginfo" }} 
                  <h2><a href="http://{{ $gimme->publication->site }}{{ uri options="section" }}">{{ $gimme->article->name }}</a></h2>
                  {{ /list_articles }}
                  <header>
                        <p>{{ list_article_authors }}{{ $gimme->author->name }}{{ if !$gimme->current_list->at_end }}, {{ /if }}{{ /list_article_authors }}
                        {{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y, %H:%i" }}Uhr <small><a href="#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a></small></p>                  
                      {{ include file="_tpl/article_info_box.tpl" }}
                  </header>
                    <h3>{{ $gimme->article->name }}</h3>
                    <p>{{ $gimme->article->body }}</p>                  
                    {{ list_article_images }}
                    <figure style="margin-bottom: 15px">
                      <img src="{{ uri options="image width 980" }}" rel="resizable" alt="">
                      <p>{{ $gimme->article->image->description }}</p>
                      <small>{{ $gimme->article->image->photographer }}</small>
                    </figure>
                    {{ /list_article_images }}
                    <a href="{{ uri options="section" }}" class="back">zur&uuml;ck zum Blog</a>                    
                </article>
                
                <section>                
{{ include file="_tpl/article_social_box.tpl" }}

<a name="comments"></a>
{{ include file="_tpl/article_comments_listing.tpl" }}
                </section>
                
            </div>
{{ else }}
                                
            <section>
                
                <article>
{{ list_articles length="1" constraints="type is bloginfo" }} 
                    <figure>
                        <big><a style="text-decoration: none" href="{{ url options="section" }}"><b>{{ $gimme->article->name }}</b></a></big>
                        <a href="{{ url options="section" }}">{{ include file="_tpl/img/img_640x280.tpl" }}</a>
                    </figure>
{{ /list_articles }}
                        <p class="single-blog-top-info">
                        <time>{{ list_article_authors }}{{ $gimme->author->name }}{{ if !$gimme->current_list->at_end }}, {{ /if }}{{ /list_article_authors }}
                        {{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y, %H:%i" }}Uhr,</time> <small><a href="#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a></small>
                        <a href="{{ uri options="section" }}" class="back">zur&uuml;ck zum Blog</a>
                        </p>


                    <h2>{{ $gimme->article->name|replace:'  ':'<br />' }}</h2>
                    {{ if $gimme->article->publish_date gt "2012-01-24 00:00:00" || $gimme->article->creation_date gt "2012-01-24 00:00:00"}}
                    <div style="width: 555px">
                    {{ include file="_tpl/article_figure.tpl" }}
                    </div>
                    {{ /if }}

                    <p>{{ $gimme->article->body }}</p>
                </article>
              
<a name="sharebox"></a>  
{{ include file="_tpl/article_social_box.tpl" }}

<a name="comments"></a>
{{ include file="_tpl/article_comments_listing.tpl" }}

            </section>
            
            <aside>
                
                 <article>
                        <header>
                        {{ list_articles length="1" constraints="type is bloginfo" }}
                        <p>Autor{{ list_article_authors }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index gt 1 }}en{{ /if }}{{ /if }}{{ /list_article_authors }}</p>
                        {{ /list_articles }}
                    </header>
{{ list_article_authors }}
{{ if $gimme->current_list->at_beginning }}                    
                    <dl class="profile-details">
{{ /if }}                    
                        <dt>
                            <h3><a href="{{ if $gimme->author->user->defined }}{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}{{ /if }}">{{ $gimme->author->name }}</a></h3>                        
                            {{ if $gimme->author->user->defined }}
                            <a href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}"><img src="{{ include file="_tpl/user-image.tpl" user=$gimme->author->user width=65 height=65 }}" width="65" height="65" alt="Portrait {{ $gimme->author->name }}" /></a>
                            {{ if !empty($gimme->author->user['bio']) }}
                            <blockquote>{{ $gimme->author->user['bio']|bbcode }}</blockquote>
                            {{ else }}
                            <p>...</p>
                            {{ /if }}

                            {{ else }}
                            <img src="{{ $gimme->author->picture->imageurl }}" alt="Portrait {{ $gimme->author->name }}" width="60" />
                            <blockquote>{{ $gimme->author->biography->text|bbcode }}</blockquote>
                            {{ /if }}
                        </dt>
                        <dd>
                                                       
                        </dd>
{{ if $gimme->current_list->at_end }}                        
                    </dl>
{{ /if }}                    
{{ /list_article_authors }}

                </article>

                {{* LATEST BLOG POSTS *}}
                {{ include file="_tpl/blog_sidebar_posts.tpl" }}

                {{* SUBSCRIBE RSS *}}
                {{ include file="_tpl/blog_sidebar_rss.tpl" }}

                {{* LATEST COMMENTS *}}
                {{ include file="_tpl/blog_sidebar_comments.tpl" }}

                {{* BLOGROLL *}}
                {{ include file="_tpl/blog_sidebar_blogroll.tpl" }}   
             
                <article>
                    <header>
                        <p>Werbung</p>
                    </header>
                    <figure>
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460349"></div>
<!-- END ADITIONTAG -->
                    </figure>
                </article>
                            
            </aside>

{{ /if }}
        
        </div>

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
