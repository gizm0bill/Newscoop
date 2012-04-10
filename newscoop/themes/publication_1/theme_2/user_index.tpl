{{extends file="layout.tpl"}}

{{block content}}
{{ omnibox }}
<section>
                <article>
                  <header>
                      <p>TagesWoche Community</p>
                    </header>

                    <form method="GET" action="{{ $view->url(['controller' => 'user', 'action' => 'search'], 'default', true) }}">
                    <fieldset class="content-search-form">
                      <input type="search" id="search-field" value="" name="q" placeholder="Name oder Benutzername" />
                      <button>Suchen</button>
                    </fieldset>
                    </form>
                </article>

		<div class="member-filter role">
		    <a href="{{ $view->url(['controller' => 'user', 'action' => 'index'], 'default', true) }}"{{ if $current == 'index' }} class="active"{{ /if }}>Alle</a>
		    <a href="{{ $view->url(['controller' => 'user', 'action' => 'active'], 'default', true) }}"{{ if $current == 'active' }} class="active"{{ /if }}>Aktivste</a>
		    <a href="{{ $view->url(['controller' => 'user', 'action' => 'editors'], 'default', true) }}"{{ if $current == 'editors' }} class="active"{{ /if }}>Redaktion</a>
		</div>
                <div class="member-filter name">
		    {{ foreach range('a', 'z') as $character }}
                    <a href="{{ $view->url(['controller' => 'user', 'action' => 'filter', 'f' => $character], 'default', true) }}"{{ if $currentCharacter == $character }} class="active"{{ /if }}>{{ $character|upper }}</a>
		    {{ /foreach }}
                </div>
                
                <ul class="two-columns member-list clearfix">
                    {{ foreach $users as $user }}
                    <li>
                        <article>
                            <h4><a href="{{ $view->url(['username' => $user->uname], 'user') }}">{{ include file="_tpl/user-name.tpl" user=$user }}</a> <em>({{ $user->posts_count }} Beiträge)</em></h4>
                            <figure>
                                <a href="{{ $view->url(['username' => $user->uname], 'user') }}"><img src="{{ include file="_tpl/user-image.tpl" user=$user width=65 height=65 }}" /></a>
                            </figure>
                            <p>{{ if !empty($user['bio']) }}{{ if $user->isAdmin() || $user->isBlogger() }}{{ $user['bio']|bbcode }}{{ else }}{{ $user['bio']|escape }}{{ /if }}{{ else }}...{{ /if }}</p>
                        </article>
                    </li>
                    {{ /foreach }}
                </ul>
                
                {{include file='paginator_control.tpl'}}

                {{ include file="_tpl/community_activitystream.tpl" is_community=1 }}
</section>
<aside>
{{* TWITTER WIDGET *}}
{{ include file="_tpl/twitter_sidebar_dialog.tpl" }}

                <article>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) {return;}
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<div class="fb-like-box" data-href="http://www.facebook.com/tageswoche" data-width="300" data-show-faces="true" data-stream="false" data-header="false"></div>
                </article>

{{* BLOG TEASERS *}}
{{ include file="_tpl/sidebar_blog_teaser.tpl" blogpl="Blog teasers - Community" }}

</aside>
{{/block}}
