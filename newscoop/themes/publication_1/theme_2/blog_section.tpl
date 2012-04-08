{{ include file="_tpl/_html-head.tpl" }}<body>

        <div id="wrapper">
        
{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix">
    
{{ include file="_tpl/navigation_top.tpl" }}

<div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}
</div>  
                                
            <section>

{{ list_articles length="1" constraints="type is bloginfo" }}                 
                <article>  
                    <figure>
                        <big><b>{{ $gimme->article->name }}</b></big>
                        {{ include file="_tpl/img/img_640x280.tpl" }}
                    </figure>
                    </header>
                    <p>{{ strip }}{{ $gimme->article->infolong|strip_tags }}{{ /strip }}</p>
<a href="{{ url options="issue" }}">(&Uuml;bersicht aller Blogs)</a>
                </article>
                {{ assign var="seclike" value=0 }}
                {{ if $gimme->article->section_like }}
                {{ assign var="seclike" value=1 }}
                {{ /if }}
{{ /list_articles }}                
                
<!-- div class="one-columns news-tickers clearfix" -->

{{ list_articles length="7" constraints="type is blog" }} 

{{ if ($seclike == 1) && ($gimme->current_list->at_beginning) }}
<div class="article-list-view padding-fix rubrik-list">
{{ /if }}

                          <article class="blog">

{{ if $seclike == 0 }}

                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
<p class="single-blog-top-info">
<time>Von {{ list_article_authors }}{{ $gimme->author->name }}{{ if !$gimme->current_list->at_end }}, {{ /if }}{{ /list_article_authors }} am {{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</time>
<small><a href="{{ url options="article" }}#comments">({{ $gimme->article->comment_count }} Kommentar{{ if !($gimme->article->comment_count == 1) }}e{{ /if }})</a></small>
</p>
                                {{ else }}
{{ $diff=date_diff(date_create('now'), date_create($gimme->article->publish_date)) }}
<p class="single-blog-top-info">
<time>{{ list_article_authors }}{{ $gimme->author->name }}{{ if !$gimme->current_list->at_end }}, {{ /if }}{{ /list_article_authors }} vor
{{ if $diff->y }} {{ $diff->y }} {{ if $diff->y > 1 }}Jahre{{ else }}Jahr{{ /if }}{{ /if }}
{{ if $diff->m }} {{ $diff->m }} {{ if $diff->m > 1 }}Monate{{ else }}Monat{{ /if }}{{ /if }}
{{ if $diff->d }} {{ $diff->d }} {{ if $diff->d > 1 }}Tagen{{ else }}Tag{{ /if }}{{ /if }}
{{ if $diff->h && (!$diff->d || empty($short)) }} {{ $diff->h }} Std.{{ /if }}
{{ if !$diff->d && $diff->i && (empty($short) || !$diff->h) }} {{ $diff->i }} Min.{{ /if }}
{{ if !$diff->d && !$diff->h && !$diff->i && $diff->s }} {{ $diff->s }} Sek.{{ /if }}</time>
<small><a href="#comments">({{ $gimme->article->comment_count }} Kommentar{{ if !($gimme->article->comment_count == 1) }}e{{ /if }})</a></small> 
</p> 
                                {{ /if }}                              
                                <h2><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h2>
{{ if $gimme->section->number gte 200 }}
                                {{ list_article_images length="1" }}
                                <a href="{{ url options="article" }}"><img alt="{{ $gimme->article->image->description }}" src="{{ url options="image width 640" }}" /></a>
                                {{ /list_article_images }}
{{ else }}
                    {{ if $gimme->article->publish_date gt "2012-01-24 00:00:00" }}
                    <div style="width: 555px">
                    {{ include file="_tpl/article_figure.tpl" }}
                    </div>
                    {{ /if }}
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->body }}</p>
                                <p class="single-blog-top-info"><a href="{{ url options="article" }}#sharebox">Teilen und kommentieren</a></p>
{{ /if }}

{{ else }}{{* if $seclike=1 *}}

        <header style="width: 100%">
<p>
                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}
                                {{ else }}
{{ $diff=date_diff(date_create('now'), date_create($gimme->article->publish_date)) }}
Vor
{{ if $diff->y }} {{ $diff->y }} {{ if $diff->y > 1 }}Jahre{{ else }}Jahr{{ /if }}{{ /if }}
{{ if $diff->m }} {{ $diff->m }} {{ if $diff->m > 1 }}Monate{{ else }}Monat{{ /if }}{{ /if }}
{{ if $diff->d }} {{ $diff->d }} {{ if $diff->d > 1 }}Tagen{{ else }}Tag{{ /if }}{{ /if }}
{{ if $diff->h && (!$diff->d || empty($short)) }} {{ $diff->h }} Std.{{ /if }}
{{ if !$diff->d && $diff->i && (empty($short) || !$diff->h) }} {{ $diff->i }} Min.{{ /if }}
{{ if !$diff->d && !$diff->h && !$diff->i && $diff->s }} {{ $diff->s }} Sek.{{ /if }}
                                {{ /if }}
</p>
{{ if $gimme->article->comments_enabled }}
<small><a href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a></small>
{{ /if }}
{{ include file="_tpl/article_info_box.tpl" }}
</header>

{{ list_article_images length="1" }}
<figure>
<a href="{{ url options="article" }}"><img src="{{ url options="image width 300 height 200 crop center" }}" style="max-width: 100%" /></a>
</figure>
{{ /list_article_images }}
<h2 class="blog"><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a>{{ include file="_tpl/article_title_tooltip_box.tpl" }}</h2>
<p class="blog">{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ if !($gimme->article->lede|strip_tags:false|strip == "") }}{{ $gimme->article->lede|strip_tags }}{{ else }}{{ $gimme->article->body|strip_tags:false|strip|truncate:200 }}{{ /if }}
    {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }}
  <a href="{{ url options="article" }}">Weiterlesen</a>  
</p>

{{ /if }}

                        </article>

{{ if $gimme->current_list->at_end }}                       

{{ if ($seclike == 1) && ($gimme->current_list->at_end) }}
</div>
{{ /if }}

{{* PAGINATION KOSHER/HALAL WAY *}}
{{ $pages=ceil($gimme->current_list->count/7) }}
{{ $curpage=intval($gimme->url->get_parameter($gimme->current_list_id())) }}
{{ if $pages gt 1 }}
<p class="pagination reverse-border">
    {{ for $i=0 to $pages - 1 }}
        {{ $curlistid=$i*7 }}
        {{ $gimme->url->set_parameter($gimme->current_list_id(),$curlistid) }}
        {{ if $curlistid != $curpage }}
        <a href="{{ uripath options="section" }}?{{ urlparameters }}">{{ $i+1 }}</a>
        {{ else }}
        <span style="font-weight: bold; text-decoration: none">{{ $i+1 }}</span>
        {{ $remi=$i+1 }}
        {{ /if }}
    {{ /for }}
    <span class="nav right">
    {{ if $gimme->current_list->has_previous_elements }}{{ unset_article }}<a href="{{ url options="previous_items" }}" class="prev">Previous</a>{{ /if }}
    {{ if $gimme->current_list->has_next_elements }}{{ unset_article }}<a href="{{ url options="next_items" }}" class="next">Next</a>{{ /if }}
    </span>
</p>
{{ $gimme->url->set_parameter($gimme->current_list_id(),$curpage) }}
{{ /if }} 

{{ /if }} 
{{ /list_articles }}
<! --/div -->                    
                
            </section>
            
            <aside>
                
                 <article>
                        <header>
                        {{ list_articles length="1" constraints="type is bloginfo" }}
                        <p>Autor{{ list_article_authors }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index gt 1 }}en{{ /if }}{{ /if }}{{ /list_article_authors }}</p>
                        {{ /list_articles }}
                    </header>
                    <dl class="profile-details">
{{ list_articles length="1" constraints="type is bloginfo" }} 
{{ list_article_authors }}
{{ if $gimme->current_list->at_beginning }}                    
                    <dl class="profile-details">
{{ /if }}                    
                        <dt>
                            <h3><a href="{{ if $gimme->author->user->defined }}{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}{{ /if }}">{{ if $gimme->author->user->is_admin }}{{ $gimme->author->name }}{{ else }}{{ $gimme->author->user->uname }}{{ /if }}</a></h3>
                            {{ if $gimme->author->user->defined }}
                            <a href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}"><img src="{{ include file="_tpl/user-image.tpl" user=$gimme->author->user width=65 height=65 }}" width="65" height="65" alt="Portrait {{ $gimme->author->user->uname }}" /></a>
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
{{ /list_articles }}

                </article>

                {{* RSS FEED *}}
                {{ include file="_tpl/blog_sidebar_rss.tpl" }}

                {{* LATEST COMMENTS *}}
                {{ include file="_tpl/blog_sidebar_comments.tpl" }}

                {{* BLOGROLL *}}
                {{ include file="_tpl/blog_sidebar_blogroll.tpl" }}
                            
            </aside>
        
        </div>

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
