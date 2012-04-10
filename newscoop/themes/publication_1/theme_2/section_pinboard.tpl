{{ include file="_tpl/_html-head.tpl" }}
<body>

        <div id="wrapper">

{{ local }}
{{ unset_article }}
{{ omnibox }}
{{ /local }}   
        <div class="content-box top-content-fix clearfix pinwand">
{{* here are some classes, like 'fokus' or 'pinwand' depending on the section / article *}}
                    
{{ include file="_tpl/navigation_top.tpl" }}

            <div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

            </div>             
            
            <section>
                
                <article>
                        <header>
                        <p>Storyboard</p>
                    </header>
                    <h2>Die Redaktion sucht...</h2>

                    <p>Die Redaktion der TagesWoche weiss vieles, aber natürlich nicht alles. Helfen Sie uns bei unseren Geschichten, indem Sie Ihr Wissen und Ihre Ideen einbringen. Aktuell suchen wir zu diesen Themen Inputs oder Material:</p>
                </article>
                
                <div id="pinwand-holder">
{{*******************************
* options to style boxes:
<div class="sticker-box normal pink">
<div class="sticker-box normal yellow">
<div class="sticker-box normal blue">
<div class="sticker-box wider pink">
<div class="sticker-box wider yellow">
<div class="sticker-box wider blue">
*}}

{{ list_articles ignore_issue="true" columns="3" ignore_section="true" order="bypublishdate desc" constraints="type is pinnwand" }}
                     <div class="sticker-box{{ strip }}
{{ assign var='size' value=1|rand:2 }}
{{ if $size == 1}} normal{{ else }} wider{{ /if }}
{{ if $gimme->current_list->column == 1}} yellow{{ elseif $gimme->current_list->column == 2 }} blue{{ else }} pink{{ /if }}
{{ /strip }}">
                        <h3><a href="#">{{ $gimme->article->name }}</a> <small>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</small></h3>
                        <p>{{ $gimme->article->body }}
                          <a href="#">Input an die Redaktion senden</a>
                        </p>
                    </div>
{{ /list_articles }}
                
                </div><!--#pinwand-holder-->

<script>
$(function() {
    $('#pinwand-holder a').click(function() {
        if ($('#ob_main:hidden').size()) {
            omnibox.showHide();
        }

        return false;
    });
});
</script>

                
            </section>
            
            <aside>
   
                    <article>
                        <header>
                            <p>Aktuelle Top-Themen</p>
                        </header>
                        <ul class="simple-list">
{{ list_playlist_articles length="3" id="6" }}                        
                            <li><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
{{ /list_playlist_articles }}
                        </ul>
                    </article>
                
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
