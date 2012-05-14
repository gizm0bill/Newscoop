            <div id="top">
                <ul>
                    {{ dynamic }}
                    {{ if $gimme->user->logged_in }}
                    <li class="left-floated">Willkommen <a title="Zu meinem Profil" href="{{ $view->url(['controller' => 'dashboard', 'action' => 'index'], 'default') }}">{{ $gimme->user->first_name }} {{ $gimme->user->last_name }}</a></li>
                    <li class="left-floated"><a href="{{ $view->url(['controller' => 'auth', 'action' => 'logout'], 'default') }}?t={{ time() }}">LogOut</a></li>
                    {{ else }}
                    <li><a href="javascript:omnibox.showHide(){{* $view->url(['controller' => 'auth', 'action' =>'index'], 'default') *}}">Einloggen und einmischen</a></li>
                    {{ /if }}
                    {{ /dynamic }}
                    <li><a href="{{ local }}{{ set_publication identifier="1" }}{{ set_issue number="1" }}{{ set_section number="20" }}http://{{ $gimme->publication->site }}{{ uri options="section" }}{{ /local }}">Abos</a></li>
                    {{*<li>client: browser {{ $gimme->browser }} mobile_data {{ $gimme->mobile_data }}</li>*}}
                    <li><a href="{{ $view->url(['controller' => 'dashboard', 'action' => 'index'], 'default') }}"><strong>Mein Profil</strong></a></li>
                    <li><a href="{{ uri options="template section_my_topics.tpl" }}"><strong>Meine Themen</strong></a></li>
                    {{ dynamic }}{{ if $gimme->browser->browser_working == "webkit" && '/ipad|tablet/i'|preg_match:$smarty.server.HTTP_USER_AGENT }}<li><a href="#" onClick="createCookie('app_mode', 'on', 365, '/', '{{ $gimme->publication->site|strchr:'.' }}'); window.location.reload(); return false;"><strong>Mobile Version</strong></a></li>{{ /if }}{{ /dynamic }}
                </ul>
                <div class="print-logo" style="display:none;"><img src="{{ uri static_file="_css/tw2011/img/tw-logo-print.png" }}" alt="TagesWoche" /></div>
                <h1>{{ local }}{{ set_publication identifier="1" }}<a href="http://{{ $gimme->publication->site }}">Tages <span>Woche</span></a></h1>
                <time><a href="{{ set_current_issue }}{{ set_section number="82" }}{{ url options="section" }}{{ /local }}" style="text-decoration: none">{{ date("d.m.Y") }}</a></time>
            </div><!-- / Top -->
