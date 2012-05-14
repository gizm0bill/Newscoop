{{ $uniqid=$gimme->article->number }}
<a class="follow-topics" href="#follow-topics-popup-{{ $uniqid }}">Diesen Themen folgen</a>
<div style="display:none"><div class="follow-topics-popup" id="follow-topics-popup-{{ $uniqid }}">
    <article>
        <header><p>Diesen Themen folgen</p></header>

        {{ dynamic }}        
        {{ if $gimme->user->logged_in }}
        <p>Bitte wählen Sie die Themen aus, die Sie weiter verfolgen möchten. Sie finden dann alles zu diesem Themen unter Ihrer Rubrik "Meine Themen".</p>
    
        <form>
            <ul class="topics">
                {{ list_article_topics }} 
                <li>
                    <input type="checkbox" class="topic-to-follow" id="ft_{{ $gimme->topic->id }}" name="topic[]" value="{{ $gimme->topic->id }}" />
                    <label for="ft_{{ $gimme->topic->id }}">{{ $gimme->topic->name }}</label>
                </li>
                {{ /list_article_topics }}
            </ul>
            <button class="button">Speichern</button>
        </form>
        
        {{ else }}
        <p>Melden Sie sich an, um Themen zu folgen.</p>
        {{ /if }}
        {{ /dynamic }}
    </article>
</div></div>

{{ if !defined('FOLLOW_TOPICS_INCLUDED') }}
<script src="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.pack.js') }}"></script>
<script>
$(function() {
    $('head').append('<link rel="stylesheet" href="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.css') }}" />');

    $('.follow-topics').each(function() {
        var popup = $('.follow-topics-popup', $(this).next('div'));
        $(this).fancybox({
            'hideOnContentClick': false,
            'type': 'inline',
            'onClosed': function() {
                $('p.after', popup).detach();
                $('article > *', popup).show();
            }
        });
    });

    $('.follow-topics-popup button').click(function(e) {
        e.preventDefault();
        var context = $(this).closest('.follow-topics-popup');
        var topics = {};
        $('input:checkbox', $(this).closest('form')).each(function() {
            topics[$(this).attr('value')] = this.checked;
        });

        $.getJSON("{{ $view->url(['controller' => 'dashboard', 'action' => 'update-topics'], 'default') }}", {'topics': topics, 'format': 'json'}, function(data, textStatus, jqXHR) {
            $('article > *', context).not('header').hide();
            $('header', context).after('<p class="after">Ihre Themen wurden gespeichert. Sie finden die zugehörigen Artikel in Ihrer Rubrik "<a href="{{ uri options="template section_my_topics.tpl" }}">Meine Themen</a>".</p>');
        });
    });

    {{ $userTopics=array_keys($user->topics) }}
    {{ foreach $userTopics as $topic }}
    $('input.topic-to-follow[value="{{ $topic }}"]').attr('checked', 'checked');
    {{ /foreach }}

    if (window.location.hash == '#themen') {
        $('.follow-topics').first().click();
        window.location.hash = '';
    }
});
</script>
{{ $tmp=define('FOLLOW_TOPICS_INCLUDED', 1) }}
{{ /if }}
