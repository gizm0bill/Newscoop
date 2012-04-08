{{extends file="layout.tpl"}}

{{block content}}
{{ omnibox }}
<section>
                <article>
                  <header>
                      <p>Profil</p>
                    </header>
                    {{* if $user->isAuthor() }}
                    <small class="redaktion">TagesWoche Redaktion</small>
                    {{ else if $user->isBlogger() }}
                    <small class="redaktion">TagesWoche Blogger</small>
                    {{ /if *}}

                    {{ if !empty($user['bio']) }}
                        {{ if $user->isAdmin() || $user->isBlogger() }}
                        <p style="font-size: 21px; line-height: 25px">{{ $user['bio']|bbcode }}</p>
                        {{ else }}
                        <p style="font-size: 21px; line-height: 25px">{{ $user['bio']|escape }}</p>
                        {{ /if }}
                    {{ else }}
                    <p>...</p>
                    {{ /if }}
                </article>
                
                <dl class="profile-details">
                    <dt>
                        <img src="{{ include file="_tpl/user-image.tpl" user=$user width=130 height=130 }}" alt="{{ $user->uname }}" />
                    </dt>
                    <dd>
                      <h3>{{ include file="_tpl/user-name.tpl" user=$user }} <small>(Mitglied seit dem: {{ $user->created }})</small></h3>

                        {{ if $user['is_verified'] }}
                        <p><span class="verified">Verifiziertes Profil</span></p> 
                        {{ /if }}

                        <p>Veröffentlichte Beiträge: {{ $user->posts_count }}</p>

                        {{ if !empty($profile['organisation']) }}
                        <p>Firma / Organisation: {{ $profile['organisation']|escape }}</p>
                        {{ /if }}

                        {{ if !empty($profile['birth_date']) }}
                        <p>Geboren am: {{ $profile['birth_date']|escape }}</p>
                        {{ /if }}

                        {{ if !empty($profile['website']) }}
                        <p>Webseite: <a rel="nofollow" href="http://{{ $profile['website']|escape:url }}">{{ $profile['website']|escape }}</a></p>
                        {{ /if }}

                        {{ if !empty($profile['blog']) }}
                        <p>Blog: <a rel="nofollow" href="http://{{ $profile['blog']|escape:url }}">{{ $profile['blog']|escape }}</a></p>
                        {{ /if }}

                        {{ if !empty($profile['facebook']) || !empty($profile['twitter']) || !empty($profile['google']) }}
                        <p>in Social Networks: 
                        {{ if (!empty($profile['facebook'])) }}<a rel="nofollow" href="http://www.facebook.com/{{ $profile['facebook']|escape:url }}">Facebook</a>{{ if !empty($profile['twitter']) || !empty($profile['google']) }},{{ /if }}{{ /if }}
                        {{ if (!empty($profile['twitter'])) }}<a rel="nofollow" href="http://www.twitter.com/{{ $profile['twitter']|escape:url }}">Twitter</a>{{ if !empty($profile['google']) }},{{ /if }}{{ /if }}
                        {{ if (!empty($profile['google'])) }}<a rel="nofollow" href="http://plus.google.com/{{ $profile['google']|escape:url }}">Google+</a>{{ /if }}
                        </p>
                        {{ /if }}

                        <span class="footer-div">
                        </span>

{{ if !empty($profile['email_public']) && $gimme->user->logged_in && $gimme->user->identifier != $user->identifier }}
<ul class="item-list profile-url-list">
    <li class="mail"><a id="send-user-email" href="#send-email">{{ include file="_tpl/user-name.tpl" user=$user }}</a> <small>eine Nachricht senden</small></li>
</ul>

<div style="display:none"><div id="send-email">
    <div class="text_container">
    <form id="email-form">
        <label for="email-subject">Betreff</label>
        <input type="text" name="subject" id="email-subject" />
        <br />
        <label for="email-message">Mitteilung</label>
        <textarea id="email-message" name="message" rows="5"></textarea>

        <!--<button id="email-submit">Senden</button>//-->
        <input type="submit" id="email-submit" class="button" value="Senden" />
    </form>
    </div>
</div></div>

<script>
$(function() {
    $('#email-form').submit(function() {
        var subject = $('#email-subject').val();
        var message = $('#email-message').val();

        if (!subject) {
            $('#email-subject').addClass('error');
        } else {
            $('#email-subject').removeClass('error');
        }

        if (!message) {
            $('#email-message').addClass('error');
        } else {
            $('#email-message').removeClass('error');
        }

        if ($('#email-message.error, #email-subject.error').size()) {
            return false;
        }

        $.post("{{ $view->url(['action' => 'send-email', 'username' => $user->uname], 'user')}}?format=json", {
            'subject': subject,
            'message': message,
        }, function(data, textStatus, jqXHR) {
            $('#email-form').hide();
            if (data.status) {
                $('<p class="confirm">Ihre E-Mail wurde verschickt.</p>').appendTo($('#send-email')).css('margin', '0');
            } else {
                $('<p class="confirm" style="color: #c00;">There was an error. Please try again later.</p>').appendTo($('#send-email')).css('margin', '0');
            }
        }, 'json');

        return false;
    });

    $('#send-user-email').fancybox({
        'hideOnContentClick': false,
        'type': 'inline',
        'onClosed': function() {
            $('#send-email p.confirm').detach();
            $('#email-message, #email-subject').val('');
            $('#email-form').show();
        }
    });
});
</script>
{{ /if }}

                    </dd>
                </dl>
                
                {{ if !empty($profile['geolocation']) }}
                <article>
                  <header>
                      <p>Aktueller Wohnort</p>
                    </header>
                    <figure>
                        <div id="map_canvas" style="height:248px"></div>
                        {{* <p>Auf vergrößerter Karte öffnen</p> *}}
                    </figure>
                </article>
                {{ /if }}
                
{{ include file="_tpl/author-content.tpl" user=$user }}

{{*
                {{ if !$user->is_admin }}
                {{ list_images user=$user->identifier order="byLastUpdate desc"}}
                {{ if $gimme->current_list->at_beginning }}
                <article>
                    <header>
                        <p>Meine bilder</p>
                    </header>
                    <ul class="photo-blog-list jcarousel-skin-photoblog">
                {{ /if }}
                        <li><img src="{{ uri options="image width 170 height 115" }}" alt=""/></li>

                
                {{ if $gimme->current_list->at_end }}
                    </ul>
                </article>
                {{ /if }}
                {{ /list_images }}
                {{ /if }}
*}}                
            </section>
            
            <aside>
                <article>
                    <header>
                        <p>Mitglieder suchen</p>
                    </header>
                    <form method="POST" action="{{ $view->url(['controller' => 'user', 'action' => 'search'], 'default', true) }}">
                    <fieldset class="content-search-form">
                      <input type="search" id="search-field-inner" name="q" value="" placeholder="Namen" />
                      <button>Go</button>
                  </fieldset>
                    </form>
                </article>
    
                {{ include file="_tpl/community_activitystream.tpl" }}
</aside>

{{ if !empty($profile['geolocation']) }}
<script>
var map;
var marker;

function initialize() {
    var geolocation = "{{ $profile['geolocation']|escape:javascript }}".split(",");
    var latLng = new google.maps.LatLng(geolocation[0], geolocation[1]);
    var mapOptions = {
        zoom: 13,
        center: latLng,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        streetViewControl: false,
        mapTypeControl: false,
        draggable: false
    }

    map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
    marker = new google.maps.Marker({
        position: latLng,
        map: map
    });
}

function loadScript() {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize";
    document.body.appendChild(script);
}

$(document).ready(loadScript);
</script>
{{ /if }}

{{/block}}
