{{ include file="_tpl/_html-head.tpl" }}
<body>

        <div id="wrapper">

{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix fokus">
                    
{{ include file="_tpl/navigation_top.tpl" }}

<div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

</div>                          
            <section>
                
<h2>Suchresultate für {{ $gimme->search_articles_action->search_phrase }}</h2>
<div class="one-columns news-tickers clearfix">

{{ $type_not="event,screening" }}
{{ if !empty($smarty.get.switch_events) }}
{{ $type_not="" }}
{{ /if }}
{{ list_search_results length="10" type_not=$type_not order="bypublishdate desc" }}

{{ if $gimme->current_list->at_beginning }}                  
<input type="checkbox" id="switch-events" name="switch_events" value="1" {{ if !empty($smarty.get.switch_events) }}checked="checked"{{ /if }} /> <label for="switch-events">Auch Veranstaltungen zu diesem Suchbegriff anzeigen</label><br /><br />
                    <ul>
{{ /if }}                        

{{ if $gimme->article->type_name == "newswire" }}
                      <li>
                          <article>
                                <figure>
                                    <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
                                </figure>

                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
                                <small>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small>
                                {{ else }}
                                {{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }}
                                {{ /if }} 

                                <h3><a href="{{ url options="article" }}">{{ $gimme->article->NewsLineText }}{{ if !$gimme->article->NewsLineText }}{{ $gimme->article->name }}{{ /if }}</a></h3>
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->DataLead }}{{ if $gimme->article->DataLead|strip_tags|strip == "" }}{{ $gimme->article->DataContent|strip_tags|truncate:200 }}{{ /if }} <a href="{{ url options="article" }}">Weiterlesen</a></p>
                            </article>
                        </li>
{{ elseif $gimme->article->type_name == "event" }} 
                        <li>
                            <article>
                                <figure>
                                    <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
                                </figure>                        
                                <h3><a href="{{ url options="article" }}">{{ $gimme->article->organizer }}</a></h3>
                                <h3>{{ $gimme->article->headline }}, {{ $gimme->article->time }}Uhr {{ $gimme->article->date|camp_date_format:"%e.%m.%Y" }} </h3>
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->description|truncate:140 }} <a href="{{ url options="article" }}">Weitere Informationen</a></p>
                            </article>
                        </li>
{{ elseif $gimme->article->type_name == "news" }}                       
                      <li>
                          <article>
                                <figure>
                                    <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
                                </figure>
                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
                                <small>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small>
                                {{ else }}
                                {{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }}
                                {{ /if }} 
                                <h3><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h3>
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ if $gimme->article->lead }}{{ $gimme->article->lead }}{{ else }}{{ $gimme->article->body|strip_tags|truncate:200 }}{{ /if }}
                                   {{ if $gimme->article->DataLead }}{{ $gimme->article->DataLead }}{{ else }}{{ $gimme->article->dataContent|strip_tags|truncate:200 }}{{ /if }} <a href="{{ url options="article" }}">Weiterlesen</a></p>
                            </article>
                        </li>
{{ elseif $gimme->article->type_name == "good_comment" }}
                      <li>
                          <article>
                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
                                <small>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small>
                                {{ else }}
                                {{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }}
                                {{ /if }} 
                                <h3>Auf den Punkt gebracht</h3>
                                <p>{{ $gimme->article->comment_community|strip_tags }}<small>{{ $gimme->article->comment_on_comment|strip_tags }}</small></p>
                            </article>
                        </li>
{{ elseif $gimme->article->type_name == "static_page" }}
                      <li>
                          <article>
                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
                                <small>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small>
                                {{ else }}
                                {{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }}
                                {{ /if }} 
                                <h3><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h3>
                                <p>{{ $gimme->article->body|strip_tags|truncate:200 }} <a href="{{ url options="article" }}">Weiterlesen</a></p>
                            </article>
                        </li>
{{ elseif $gimme->article->type_name == "blog" }}                       
                      <li>
                          <article>
                                <figure>
                                    <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
                                </figure>
                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
                                <small>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small>
                                {{ else }}
                                {{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }}
                                {{ /if }} 
                                <h3><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h3>
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ if $gimme->article->lead }}{{ $gimme->article->lead }}{{ else }}{{ $gimme->article->body|strip_tags|truncate:200 }}{{ /if }}
                                   {{ if $gimme->article->lede }}{{ $gimme->article->lede }}{{ else }}{{ $gimme->article->body|strip_tags|truncate:200 }}{{ /if }} <a href="{{ url options="article" }}">Weiterlesen</a></p>
                            </article>
                        </li>  
{{ elseif $gimme->article->type_name == "subscription" }}
                      <li>
                          <article>
                                <h3><a href="{{ url options="section" }}">{{ $gimme->article->name }}</a></h3>
                                <p>{{ $gimme->article->bullet_one }}</p>
                                <p>{{ $gimme->article->bullet_two }}</p>                                
                                <p>{{ $gimme->article->bullet_three }}</p>                                
                            </article>
                        </li>   
{{ elseif $gimme->article->type_name == "bloginfo" }}                       
                      <li>
                          <article>
                                <figure>
                                    <a href="{{ url options="section" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
                                </figure>
                                <h3><a href="{{ url options="section" }}">{{ $gimme->article->name }}</a></h3>
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->motto|strip_tags }}
                                    <a href="{{ url options="section" }}">Weiterlesen</a></p>
                            </article>
                        </li>                                                               
{{ elseif $gimme->article->type_name == "deb_statement" }}                       
                      <li>
                          <article>
                                <figure>
                                    <a href="{{ url options="section" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
                                </figure>
                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
                                <small>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small>
                                {{ else }}
                                {{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }}
                                {{ /if }}                            
                                <h3><a href="{{ url options="section" }}">{{ $gimme->section->name }}</a></h3>
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->opening|strip_tags|truncate:200 }}
                                    <a href="{{ url options="section" }}">Weiterlesen</a></p>
                            </article>
                        </li>                                                               
{{ elseif $gimme->article->type_name == "dossier" }}                       
                      <li>
                          <article>
                                <figure>
                                    <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
                                </figure>
                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
                                <small>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small>
                                {{ else }}
                                {{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }}
                                {{ /if }}                                 
                                <h3><a href="{{ url options="article" }}">Dossier: {{ $gimme->article->name }}</a></h3>
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->lede|strip_tags }}
                                    <a href="{{ url options="article" }}">Weiterlesen</a></p>
                            </article>
                        </li>                                                               
{{ elseif $gimme->article->type_name == "pinnwand" }}                       
                      <li>
                          <article>
                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
                                <small>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small>
                                {{ else }}
                                {{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }}
                                {{ /if }}                               
                                <h3>Die Redaktion sucht... {{ $gimme->article->name }}</h3>
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->teaser|strip_tags }}</p>
                            </article>
                        </li>    
{{ elseif $gimme->article->type_name == "screening" }} 
                        <li>
                            <article>
                                <figure>
                                    <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
                                </figure>                        
                                <h3><a href="{{ url options="article" }}">{{ $gimme->article->organizer }}</a></h3>
                                <h3>{{ $gimme->article->headline }}, {{ $gimme->article->time }}Uhr {{ $gimme->article->date|camp_date_format:"%e.%m.%Y" }} </h3>
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->description|truncate:140 }} <a href="{{ url options="article" }}">Weitere Informationen</a></p>
                            </article>
                        </li>     
{{ elseif $gimme->article->type_name == "link" }}
                      <li>
                          <article>
                                {{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
                                <small>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small>
                                {{ else }}
                                {{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }}
                                {{ /if }} 
                                <h3>Die TagesWoche empfiehlt</h3>
                                <p>{{ $gimme->article->link_description|strip_tags }}<small><a href="{{ $gimme->article->link_url }}">{{ $gimme->article->name }}</a></small></p>
                            </article>
                        </li>                                                                                                      
{{ /if }}

{{ if $gimme->current_list->at_end }}                       
                    </ul>
<script>
$(function() {
    $('#switch-events').change(function() {
        var events = 0;
        if ($(this).attr('checked')) {
            events = 1;
        }
        window.location = "http://{{ $gimme->publication->site }}{{ str_replace(array('&amp;', 'ls-src0=', 'switch_events='), array('&', '', ''), $gimme->url->uri) }}&ls-src0=0&switch_events="+events;
    });
});
</script>

{{ include file="_tpl/pagination.tpl" }}

{{ else }}
<hr />
{{ /if }}
{{ /list_search_results }}  

{{ if $gimme->prev_list_empty }}
    <h3>Ihre Suche hat keine Treffer erzielt</h3>
{{ /if }} 
                 
                </div>

            </section>
            
            <aside>

{{ include file="_tpl/newsticker_front.tpl" }}
                
{{* COMMUNITY ACTIVITY STREAM *}}
{{ include file="_tpl/community_activitystream.tpl" }}
            
            </aside>

        
        </div>

{{* COMMUNITY AVATARS *}}
{{ include file="_tpl/avatars_front.tpl" }}

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
