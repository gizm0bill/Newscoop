{{ include file="_tpl/_html-head.tpl" }}<body>

        <div id="wrapper">
        
{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix article-page">
    
{{ include file="_tpl/navigation_top.tpl" }}

<div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}
</div>  
                   
            <div class="wide-title">
                <header>
                    <p>{{ $gimme->section->name }}</p>
                    {{ include file="_tpl/article_title_tooltip_box.tpl" }}
                </header>
            </div>                
                <div id="article-front" class="article-content clearfix">

                <section>
                
                    <article class="article-text">
                        {{ include file="_tpl/admin_frontpageedit.tpl" }}
                        <h2>{{ $gimme->article->name }}</h2>

{{ assign var="lastimg" value=0 }}
{{ list_article_images length="1" order="bynumber desc" }}
{{ if $gimme->image->article_index gt 11 }}{{ assign var="lastimg" value=$gimme->image->article_index }}{{ else }}{{ assign var="lastimg" value=1 }}{{ /if }}
{{ /list_article_images }}

{{* if article has more different pictures, slideshow will be shown with first image as part of it, otherwise just the figure tag is used without ul and li *}}
{{ if $lastimg  gt 1 }}
                        <ul id="article-single-carousel" class="jcarousel-skin-article-single">
                            <li>
{{ /if }} 
                                <figure>
{{ include file="_tpl/img/img_555x370.tpl" }}
                                      <p>{{ $gimme->article->image->description }} {{ include file="_tpl/image-photographer.tpl" image=$gimme->article->image }}</p>
                                </figure>
{{ if $lastimg  gt 1 }}                                
                            </li>
{{ /if }}

{{ if $lastimg gt 1 }}
{{ list_article_images }}
{{ if $gimme->article->image->article_index gt 11 }}                            
                            <li>
                                <figure>
                                        <img src="{{ url options="image width 555 height 370 crop center" }}" width="555" height="370" rel="resizable" alt="{{ $gimme->article->image->description }}">
                                        <p>{{ $gimme->article->image->description }} {{ include file="_tpl/image-photographer.tpl" image=$gimme->article->image }}</p>
                                </figure>
                            </li>
{{ /if }}                            
{{ /list_article_images }}                            
{{ /if }}
{{ if $lastimg gt 1 }}</ul>{{ /if }}

<p>{{ $gimme->article->body }}</p>

                    </article>
                    
{{ include file="_tpl/article_social_box.tpl" }}

{{ list_related_articles }}
{{ if $gimme->current_list->at_beginning }}                    
                    <article>
                        <header>
                            <p>Verwandte Artikel</p>
                        </header>
                      <ul class="details">
{{ /if }}
                                <li><time>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}:</time> <a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
{{ if $gimme->current_list->at_end }}
                      </ul>  
                    </article>{{ /if }}
{{ /list_related_articles }}                    
                    
{{* MOST POPULAR ARTICLES *}}
{{ include file="_tpl/article_most_popular.tpl" }}
            
                </section>

{{ if $gimme->article->number == 3918 && false }}
<section>
<div class="article-padding edit-profile-tab">
<article>
{{ if in_array('form_contact_done', $gimme->flash_messages) }}
<p>Your email has been sent.</p>
{{ else }}
<article>
<form method="{{ $gimme->form_contact->getMethod() }}" action="{{ $gimme->form_contact->getAction() }}">
<fieldset class="fixBackground">

<ul>
    <li><dl>{{ $gimme->form_contact->first_name->setLabel("Vorname") }}</dl></li>
    <li><dl>{{ $gimme->form_contact->last_name->setLabel("Nachname") }}</dl></li>
    <li><dl>{{ $gimme->form_contact->email->setLabel("E-Mail") }}</dl></li>
    <li><dl>{{ $gimme->form_contact->subject->setLabel("Betreff")->setMultiOptions([
        'tic' => 'toc'
    ]) }}</dl></li>
    <li><dl>{{ $gimme->form_contact->message->setLabel("Mitteilung") }}</dl></li>
    <li><dl>{{ $gimme->form_contact->captcha->setLabel("Captcha") }}</dl></li>
    <li><dl>{{ $gimme->form_contact->submit->setLabel("Senden") }}</dl></li>
</ul>

</fieldset>
</form>
{{ /if }}
</article>
</div>
</section>
{{ /if }}
                
                <aside>
{{ if $gimme->article->name == "Zeitungsarchiv" }}
{{* PRINT FRONT PAGE *}}
{{ include file="_tpl/cover_page.tpl" }}
{{ else }}             
                        <article>
                        <p class="tag-list">Erstellt am: <br />
                        <span>{{ $gimme->article->creation_date|camp_date_format:"%e.%c.%Y - %H:%i" }}</span></p>
                        <p class="tag-list">Erstmals ver&ouml;ffentlicht: <br />
                        <span>{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y - %H:%i" }}</span></p>
                        <p class="tag-list">Letzte &Auml;nderungen: <br />
                        <span>{{ $gimme->article->last_update|camp_date_format:"%e.%c.%Y - %H:%i" }}</span></p>

                        </article>
                        
{{ list_article_attachments }}
{{ if $gimme->current_list->at_beginning }}
                        <article>
                        <dl class="simple-def-list">
                                <dt>Dokumente: </dt>
{{ /if }}
                            <dd><a href="{{ uri options="articleattachment" }}">
                                {{ $gimme->attachment->description }}
                                ({{ $gimme->attachment->extension|upper }}, {{ $gimme->attachment->size_kb }}kb)
                                </a></dd>
{{ if $gimme->current_list->at_end }}
                        </dl>
{{ /if }}
                        </article>
{{ /list_article_attachments }}   

{{ /if }}
             
{{* MAP - display only if set *}}
{{ if $gimme->article->has_map }}
                    <article>
                        <p class="small-box-title">Verortung des Artikels:</p>

                        <figure>
    {{ map show_locations_list="false" show_reset_link=false auto_focus=false width="100%" height="250" }}
                        </figure>
                    </article>                
{{ /if }}
                    
                    <article>
                        <header>
                            <p>Aktuelle Top-Themen</p>
                        </header>
                        <ul class="simple-list">
{{ list_playlist_articles length="3" id="6" }}                        
                            <li><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
{{ /list_playlist_articles }}
                        </ul>
                
                </aside>
                
            </div><!-- / Front article side -->

        </div>

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
