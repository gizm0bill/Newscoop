{{ include file="_tpl/_html-head.tpl" }}
<body>

        <div id="wrapper">
{{ local }}
{{ unset_article }}
{{ uri }}
{{ omnibox }}
{{ /local }}
        <div class="content-box top-content-fix clearfix pinwand">
{{* here are some classes, like 'fokus' or 'pinwand' depending on the section / article *}}
                    
{{ include file="_tpl/navigation_top.tpl }}

            <div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

            </div>             
            
            <section>
                
                <article>
                        <header>
                        <p>Storyboard</p>
                        {{*<a href="#" class="trigger">Open</a>*}}
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

{{ list_articles ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="onfrontpage is on onsection is on" }}
                     <div class="sticker-box wider pink">
                        <h3>
                        <a href="#">{{ $gimme->article->name }}</a> <small>24.04.2012</small></h3>
                        <p>{{ $gimme->article->body }}
                          <a href="#">Input an die Redaktion senden</a>
                        </p>
                    </div>
{{ /list_articles }}
{{ list_articles ignore_issue="true" columns="3" ignore_section="true" order="bypublishdate desc" constraints="onfrontpage is off onsection is on" }}
                     <div class="sticker-box{{ strip }}
{{assign var='size' value=1|rand:2}}
{{ if $size == 1}} normal{{ else }} wider{{ /if }}
{{ if $gimme->current_list->column == 1}} yellow{{ elseif $gimme->current_list->column == 2 }} blue{{ else }} pink{{ /if }}
{{ /strip }}">
                        <h3><a href="#">{{ $gimme->article->name }}</a> <small>24.04.2012</small></h3>
                        <p>{{ $gimme->article->body }}
                          <a href="#">Input an die Redaktion</a>
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
                        <p>Sidebar</p>
                        <a href="#" class="trigger">Open</a>
                    </header>

                </article>
            
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
