{{ if empty($topics) }}
    {{ $topics = array() }}
    {{ list_article_topics }}
    {{ $topics[$gimme->topic->id] = $gimme->topic->name }}
    {{ /list_article_topics }}
{{ /if }}

<div style="display:none"><div class="follow-topics-popup popup-box" id="theme-abonnieren-content">
    <h3>Diesen Themen folgen</h3>
    {{ dynamic }}
    {{ if $gimme->user->logged_in }}{{ $userTopics=array_keys($gimme->user->topics) }}
        <p>Bitte wählen Sie die Themen aus, die Sie weiter verfolgen möchten. Sie finden dann alles zu diesen Themen unter Ihrer Rubrik "Meine Themen".</p>
        <ul class="topics form check-list">
            {{ foreach $topics as $id => $topic }}
            <li><input type="checkbox" class="topic-to-follow" id="ft_{{ $id }}" name="topic[]" value="{{ $id }}" {{ if in_array($id, $userTopics) }}checked="checked"{{ /if }} /> <label for="ft_{{ $id }}">{{ $topic }}</label></li>
            {{ /foreach }}
            <li class="clearfix"><input type="submit" value="Speichern" class="button right" /></li>
        </ul>
    {{ else }}
    <p>Melden Sie sich an, um Themen zu folgen.</p>
    {{ /if }}
    {{ /dynamic }}
</div></div>
<script type="text/javascript">
$(function() {
    $('.follow-topics-link').each(function() {
        var popup = $('#theme-abonnieren-content');
        $(this).fancybox({'hideOnContentClick': false, 'type': 'inline',
            'onClosed': function() {
                $('p.after', popup).detach();
                $('> *', popup).show();
            }
        });
    });

    $('#theme-abonnieren-content .button').click(function(e) {
        e.preventDefault();
        var context = $(this).closest('.follow-topics-popup');
        var topics = {};
        $('input:checkbox', context).each(function() {
            topics[$(this).attr('value')] = this.checked;
        });

        $.post("{{ $view->url(['controller' => 'dashboard', 'action' => 'update-topics'], 'default') }}", {'topics': topics, 'format': 'json'}, function(data, textStatus, jqXHR) {
            $('> *', context).not('h3').hide();
            $('h3', context).after('<p class="after">Neue Artikel zu allen Themen, denen Sie folgen, finden Sie unter <a href="{{ $view->url([], 'my-topics') }}">Meine Themen</a>.</p>');
        }, 'json');
    });
});
</script>
