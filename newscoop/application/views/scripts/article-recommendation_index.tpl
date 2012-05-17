{{ include file="_tpl/_html-head.tpl" }}

<div id="email-popup-box" class="popup-box">
        	
    <h3>Diesen Artikel per E-Mail empfehlen</h3>
    {{if $view->userName}}
        <p class="top-info">Angemeldet als <a href="{{ $view->url(['username' => $view->userName], 'user') }}">{{ $view->userRealName }}</a><br />
        <a href="{{ $view->baseUrl() }}/auth/logout">Ausloggen</a></p>
    {{/if}}
    
    <form method="post" action="{{$view->baseUrl()}}/article-recommendation/send">
        <input type="hidden" name="article_number" value="{{ $view->articleNumber }}">
        <ul class="form">
            {{if $view->error}}
                <li>
                    {{ $view->error }}
                </li>
            {{/if}}
            <li>
                <label>E-Mail-Adresse des Empfängers *</label>
                <input type="text" name="recipient_email"/>
            </li>
            <li>
                <label>Ihre Mitteilung</label>
                <textarea name="message"></textarea>
            </li>
            {{if !$view->userName}}
                <li>
                    <label>Ihre E-Mail-Adresse *</label>
                    <input type="text" name="sender_email" />
                </li>
                <li>
                    <label>Ihr Name</label>
                    <input type="text" name="sender_name"/>
                    <p><small>* Pflichtfeld</small></p>
                </li>
            {{/if}}
            <li class="clearfix">
                <input type="submit" value="Senden" class="button right" />
            </li>
        </ul>
    </form>

</div>