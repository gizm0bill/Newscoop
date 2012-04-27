{{extends file="layout.tpl"}}

{{block content}}
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
    </div>
</article>

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
    </div>
    {{ /if }}

<p>posts No.: {{ $user->posts_count }}</p>

{{ list_user_comments user=$user->identifier length=10 order="bydate desc" }}
    <p>{{ $gimme->user_comment->submit_date }}</p>
    <p>{{ $gimme->user_comment->subject }}</p>
    <p>{{ $gimme->user_comment->content }}</p>
    <p><a href="{{ $gimme->user_comment->article->url }}">{{ $gimme->user_comment->article->name }}</a></p>
{{ /list_user_comments }}

{{ assign var=i value=1 }}
{{ list_images user=$user->identifier order="byLastUpdate desc"}}
    {{ if $i <= 10 }}
        <a class="user_uploaded_pics" rel="user_pics" href="{{ uri options="image" }}"><img src="{{ uri options="image width 50 height 50" }}" alt=""/></a>
    {{ else }}
        <a class="user_uploaded_pics" rel="user_pics" href="{{ uri options="image" }}"></a>
    {{ /if }}

    {{ $i = $i + 1 }}
{{ /list_images }}

{{/block}}

