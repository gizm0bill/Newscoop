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
{{ list_articles ignore_issue="true" ignore_section="true" order="byName asc" constraints="type is bloginfo active is on" }}
{{ if $gimme->current_list->at_beginning }}
                <article>
                    <header>
                        <p>Blogs</p>
                    </header>
                </article>
                <ul class="two-columns member-list clearfix">
{{ /if }}                                    
                    <li>
                        <article>
                            <h4><a href="{{ url options="section" }}">{{ $gimme->article->name }}</a></h4>
                            {{* if $gimme->article->has_image(1) *}}<a href="{{ url options="section" }}">{{ include file="_tpl/img/img_300x133.tpl" }}</a>{{* /if *}}
                            <p>{{ $gimme->article->motto }}</p>                            
                        </article>
                    </li>
{{ if $gimme->current_list->at_end }}                    
                </ul>    
{{ /if }}                
{{ /list_articles }}
 </section>
            
            <aside>

                {{* LATEST POSTS *}}
                {{ include file="_tpl/blog_sidebar_latestposts.tpl" }}

                {{* COMMUNITY ACTIVITY STREAM *}}
                {{ include file="_tpl/community_activitystream.tpl" }} 
                
                <article>
                    <header>

                        <p class="green-txt"><b>Jetzt Einmischen!</b></p>
                    </header>
                    <p class="simple-txt">Wenn nur lesen auch Ihnen nicht genügt, dann erstellen Sie jetzt Ihr eigenes Profil und mischen Sie sich ein.<br />
                    <a href="http://blogs.tageswoche.ch/register">Zur Registrierung</a></p>
                </article>
                
                {{*
                <article>
                    <header>
                        <p>Mitglieder suchen</p>
                    </header>
                    <fieldset class="content-search-form">
                        <input type="search" id="search-field-inner" value="" placeholder="Namen" />
                        <button>Go</button>
                    </fieldset>
                </article>
                *}}         
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
