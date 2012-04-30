{{extends file="layout.tpl"}}

{{block content_classes}}content-box clearfix{{/block}}

{{block content}}

<section class="clearfix">
    <div class="mobile-list-view header-fix no-lines clearfix">
        <article>
            <figure class="left">
            {{ if $user->image() }}
                <img src="{{ $user->image(120, 120) }}" alt="{{ $user->name }}" rel="resizable" />
            {{ /if }}
            </figure>

            <div class="profile-info">
                <h4>{{ $user->name }}{{ if $user['is_verified'] }} <a href="#" class="green-button">Verifiziertes Profil</a>{{ /if }}</h4>
                <p>{{ $profile.bio }}</p>
                <ul class="links">
                    {{ if $user->logged_in }}
                    <li><a href="{{ $view->url(['controller' => 'dashboard', 'action' => 'index'], 'default') }}">Edit profile</a>.</li>
                    {{ /if }}
                    {{ if !empty($profile.organisation) }}
                    <li>Firma/Organisation: {{ $profile.organisation|escape }}</li>
                    {{ /if }}
                    {{ if !empty($profile.birth_date) }}
                    <li>Geboren am: {{ $profile.birth_date|escape }}</li>
                    {{ /if }}
                    {{ if !empty($profile.website) }}
                    <li>Webseite: <a rel="nofollow" href="http://{{ $profile.website|escape:url }}" target="_blank">{{ $profile.website|escape }}</a></li>
                    {{ /if }}
                    {{ if !empty($profile.blog) }}
                    <li>Blog: <a rel="nofollow" href="http://{{ $profile.blog|escape:url }}" target="_blank">{{ $profile.blog|escape }}</a></li>
                    {{ /if }}
                    {{ if !empty($profile['facebook']) || !empty($profile['twitter']) || !empty($profile['google']) }}
                    <li>In Social Networks:
                    {{ if (!empty($profile['facebook'])) }}<a rel="nofollow" href="http://www.facebook.com/{{ $profile['facebook']|escape:url }}">Facebook</a>{{ if !empty($profile['twitter']) || !empty($profile['google']) }},{{ /if }}{{ /if }}
                    {{ if (!empty($profile['twitter'])) }}<a rel="nofollow" href="http://www.twitter.com/{{ $profile['twitter']|escape:url }}">Twitter</a>{{ if !empty($profile['google']) }},{{ /if }}{{ /if }}
                    {{ if (!empty($profile['google'])) }}<a rel="nofollow" href="http://plus.google.com/{{ $profile['google']|escape:url }}">Google+</a>{{ /if }}
                    </li>
                    {{ /if }}
                    <li>Auf tageswoche.ch seit: {{ $user->created }}</li>
                </ul>

                {{ if !empty($profile.email_public) }} {{* && $gimme->user->logged_in && $gimme->user->identifier != $user->identifier *}}
                <a id="send-user-email" class="email" href="#send-email">{{ include file="_tpl/user-name.tpl" user=$user }} eine Nachricht senden</a>
                <div style="display:none">
                <div id="send-email">
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
                </div>
                </div>
            {{ /if }}
            </div>
        </article>
    </div>

    <article class="mobile-hide">
        <header class="top-line">
            <p>Beiträge auf tageswoche.ch: {{ $user->posts_count }}</p>
        </header>
    </article>

    <div class="tabs article-related-tabs mobile-hide">

        <ul>
            {{ if $user->isAuthor() }}
            <li><a href="#author-1">Artikel</a></li>
            <li><a href="#author-2">Blogbeiträge</a></li>
            {{ /if }}
            <li><a href="#author-3">Kommentare</a></li>
        </ul>

        {{ if $user->isAuthor() }}
        {{ $escapedName=str_replace(" ", "\ ", $user->author->name) }}

        {{ list_articles ignore_publication="true" ignore_issue="true" ignore_section="true" constraints="author is $escapedName type is news" order="bypublishdate desc" }}
            {{ if $gimme->current_list->at_beginning }}
            <div id="author-1">
            {{ /if }}
            <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%d.%m.%Y um %H:%i" }}</span>
            <h5><a href="{{ $gimme->article->url }}{{ $gimme->article->seo_url_end }}" title="{{ $gimme->article->title|escape }}">{{ $gimme->article->title }}</a></h5>
            {{ $gimme->article->teaser }}
            {{ if $gimme->current_list->at_end }}
            </div>
            {{ /if }}
        {{ /list_articles }}

        {{ list_articles ignore_publication="true" ignore_issue="true" ignore_section="true" constraints="author is $escapedName type is blog" order="bypublishdate desc" }}
            {{ if $gimme->current_list->at_beginning }}
            <div id="author-2">
            {{ /if }}
            <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%d.%m.%Y um %H:%i" }}</span>
            <h5><a href="{{ $gimme->article->url }}{{ $gimme->article->seo_url_end }}" title="{{ $gimme->article->title|escape }}">{{ $gimme->article->title }}</a></h5>
            <p>{{ $gimme->article->lede|trim }}</p>
            {{ if $gimme->current_list->at_end }}
            </div>
            {{ /if }}
        {{ /list_articles }}
        {{ /if }}

        {{ list_user_comments user=$user->identifier length=10 order="bydate desc" }}
            {{ if $gimme->current_list->at_beginning }}
            <div id="author-3">
            {{ /if }}
            <span class="time">{{ $gimme->user_comment->submit_date }}</span>
            <h5>{{ $gimme->user_comment->subject }}</h5>
            <p>{{ $gimme->user_comment->content|trim }}</p>
            <p><a href="{{ $gimme->user_comment->article->url }}">{{ $gimme->user_comment->article->name }}</a></p>
            {{ if $gimme->current_list->at_end }}
            </div>
            {{ /if }}
        {{ /list_user_comments }}

    </div>
</section>

<aside>
    {{ if !empty($profile.geolocation) }}
    <article>
        <header>
            <p>{{ $user->name }} Standort</p>
        </header>
        <figure>
            <div id="map_canvas" class="map-holder"></div>
        </figure>
    </article>
    {{ /if }}

    <article class="community omni-corner-box mobile-hide">
        <header>
            <p>Willkommen in der Community!</p>
        </header>
    </article>

    {{ include file="_werbung/user-profile-sidebar.tpl" }}

</aside>

{{ if !empty($profile.geolocation) }}
<script>
var map;
var marker;

function initialize() {
    var geolocation = "{{ $profile.geolocation|escape:javascript }}".split(",");
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

