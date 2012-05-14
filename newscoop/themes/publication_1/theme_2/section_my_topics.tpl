{{ include file="_tpl/_html-head.tpl" }}
<body>

        <div id="wrapper">

{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix {{ $gimme->section->shortname }}">{{* here are some classes, like 'fokus' depending on the section *}}
                    
{{ include file="_tpl/navigation_top.tpl" }}

<div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

</div>                          

{{ $currentTopic=array_filter((array)$smarty.get.topic) }}
<section id="mytopics">
            <div class="article-padding">
                <article>
                    <header>
                        <p>Meine Themen</p>
                    </header>
                </article>

{{ if $gimme->user->logged_in }}

{{ if count($gimme->user->topics) }}

            <fieldset class="ticker-sort"><ul class="left">
                <li>
                    <input type="checkbox" name="toggle" id="topic-toggle" {{ if !$currentTopic }}checked="checked"{{ /if }} />
                    <label for="topic-toggle">Alle Themen</label>
                </li>
                {{ foreach $gimme->user->topics as $topic }}
                <li>
                    <input type="checkbox" id="topic-{{ $topic@index }}" name="topic" value="{{ $topic@key }}" {{ if $currentTopic && $topic@key == $currentTopic }}checked="checked"{{ /if }} />
                    <label for="topic-{{ $topic@index }}">{{ $topic }} <a href="#" class="remove-topic" title="Thema nicht mehr verfolgen">(x)</a></label>
                </li>
                {{ /foreach }}
            </ul></fieldset>

{{ $topicConstraint="" }}
{{ if $currentTopic }}
    {{ $topicConstraint=sprintf("topic is %s", implode(" topic is ", $currentTopic)) }}
{{ else }}
    {{ $topicConstraint=sprintf("topic is %s", implode(" topic is ", array_keys($gimme->user->topics))) }}
{{ /if }}

    <div class="one-columns news-tickers clearfix">
    {{ list_articles length="15" ignore_publication="true" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is news type is blog $topicConstraint" }}
    {{ if $gimme->current_list->at_beginning }}
<ul class="topic-list-view">
    {{ /if }}
    
    <li>
        <article>
            {{ if $gimme->article->has_image(1) }}
            <figure>
                <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
            </figure>
            {{ /if }}

            {{ $diff=date_diff(date_create('now'), date_create($gimme->article->publish_date)) }}
            <small class="date relative">{{ $gimme->section->name }} vor
            {{ if $diff->d }} {{ $diff->d }} {{ if $diff->d > 1 }}Tagen{{ else }}Tag{{ /if }}{{ /if }}
            {{ if $diff->h && (!$diff->d || empty($short)) }} {{ $diff->h }} Std.{{ /if }}
            {{ if !$diff->d && $diff->i && (empty($short) || !$diff->h) }} {{ $diff->i }} Min.{{ /if }}
            {{ if !$diff->d && !$diff->h && !$diff->i && $diff->s }} {{ $diff->s }} Sek.{{ /if }}
            </small>

            <h3><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h3>
            <p>{{ str_replace(array("<p>", "</p>"), "", $gimme->article->lede) }} <a href="{{ url options="article" }}">Weiterlesen</a></p>
        </article>
    </li>
    
    {{ if $gimme->current_list->at_end }}
    </ul>
    
    {{* PAGINATION KOSHER/HALAL WAY *}}
    {{ $pages=ceil($gimme->current_list->count/15) }}
    {{ $curpage=intval($gimme->url->get_parameter($gimme->current_list_id())) }}
    {{ if $pages gt 1 }}
    <p class="pagination reverse-border">
    {{ for $i=0 to $pages - 1 }}
        {{ $curlistid=$i*15 }}
        {{ $gimme->url->set_parameter($gimme->current_list_id(),$curlistid) }}
        {{ if $curlistid != $curpage }}
        <a href="{{ uri }}">{{ $i+1 }}</a>
        {{ else }}
        <span style="font-weight: bold; text-decoration: none">{{ $i+1 }}</span>
        {{ $remi=$i+1 }}
        {{ /if }}
    {{ /for }}
    <span class="nav right">
    {{ if $gimme->current_list->has_previous_elements }}<a href="{{ uri options="previous_items" }}" class="prev">Previous</a>{{ /if }}
    {{ if $gimme->current_list->has_next_elements }}<a href="{{ uri options="next_items" }}" class="next">Next</a>{{ /if }}
    </span>
    </p>
    {{ $gimme->url->set_parameter($gimme->current_list_id(),$curpage) }}
    {{ /if }}
    {{ /if }}
    {{ /list_articles }}
    </div>

{{ else }}{{* user has no topics *}}
<p>Auf dieser Seite können Sie sich Ihre ganz individuelle TagesWoche zusammenstellen. Wählen Sie aus den Themen jene aus, die Sie persönlich interessieren. Weitere Themen können Sie auch jeweils direkt bei einem Artikel zu Ihrer TagesWoche hinzufügen.</p>
{{ /if }}

{{ else }}{{* user not logged in *}}
<p>Auf dieser Seite können Sie sich Ihre ganz individuelle TagesWoche zusammenstellen. Wählen Sie aus den Themen jene aus, die Sie persönlich interessieren. Weitere Themen können Sie auch jeweils direkt bei einem Artikel zu Ihrer TagesWoche hinzufügen.</p>

<p>Um diese Funktion nutzen zu können, müssen Sie angemeldet sein.</p>
<a href="javascript:omnibox.showHide()" title="Login">Login</a> &nbsp; <a href="{{ $view->url(['controller' => 'register', 'action' => 'index'], 'default') }}" title="Kostenloses Benutzerkonto anlegen">Kostenloses Benutzerkonto anlegen</a>
{{ /if }}
</div>
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

</aside>

<script>
$(function() {
    var topics = [];
    {{ if $currentTopic }}
    topics.push({{ $currentTopic[0] }});
    {{ /if }}

    var reload = function() {
        $.get("{{ uri }}", {
            'topic': topics,
            'tpl': 50
            }, function(data, textStatus, jqXHR) {
                var dom = $(data);
                $('section .news-tickers').html($('section .news-tickers', dom).html());
                //$('.pagination').html($('.pagination', dom).html());
                window.set_cufon_fonts();
                Cufon.now();
            });
    };

    $('input[name="topic"]').change(function() {
        if (this.checked) {
            topics.push($(this).val());
            $('#topic-toggle').removeAttr('checked');
        } else {
            topics.splice(topics.indexOf($(this).val()), 1);
            if (!$('input[name="topic"]:checked').size()) {
                $('#topic-toggle').attr('checked', 'checked');
            }
        }

        reload();

        return false;
    });

    $('#topic-toggle').change(function() {
        if (this.checked) {
            $('input[name="topic"]').removeAttr('checked');
            topics = [];
            reload();
        } else {
            $(this).attr('checked', 'checked');
        }
    });

    $('.remove-topic').click(function() {
        var context = $(this).closest('li');
        var id = $('input', context).val();
        var topics = {};
        topics[id] = false;

        $.getJSON("{{ $view->url(['controller' => 'dashboard', 'action' => 'update-topics'], 'default') }}?format=json", {
            'topics': topics
        }, function(data, textStatus, jqXHR) {
            context.detach();
        });

        return false;
    });
    
    $('.pagination a').live('click', function() {
        $.get($(this).attr('href'), {
            'topic': topics
            }, function(data, textStatus, jqXHR) {
                var dom = $(data);
                $('.topic-list-view').html($('.topic-list-view', dom).html());
                $('.pagination').html($('.pagination', dom).html());                
            });

        return false;
    });
});
</script>
            
        
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
