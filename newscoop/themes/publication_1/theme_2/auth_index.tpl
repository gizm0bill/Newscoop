{{extends file="layout.tpl"}}

{{block content}}
<section>
<div class="article-padding edit-profile-tab">
<article>
    <header>
        <p><strong>TagesWoche</strong> Login</p>
    </header>

    <form action="{{ $form->getAction() }}" method="{{ $form->getMethod() }}">

    <fieldset class="fixBackground">

    {{ if $form->isErrors() }}
    <h3>Anmeldung fehlgeschlagen</h3>
    <p>So ein Computer ist erbarmungslos. Einmal vertippt und er lässt einen draussen stehen. Entweder mit Ihrer E-Mail-Adresse oder Ihrem Passwort stimmt etwas nicht.</p>
    <p>Geben Sie nicht auf, gemeinsam kommen wir am Türsteher vorbei.</p>
    <p><a class="register-link" href="{{ $view->url(['controller' => 'auth', 'action' => 'password-restore']) }}">Passwort vergessen?</a></p>
    {{ /if }}

        <ul>
            <li><dl>
                {{ $form->email->setLabel("E-Mail")->removeDecorator('Errors') }}
            </dl></li>
            <li>
                <dl>{{ $form->password->setLabel("Passwort")->removeDecorator('Errors') }}</dl></li>
            <li>
                <dl>{{ $form->persistency->setLabel("Eingeloggt bleiben")->removeDecorator('Errors') }}</dl>
                <span class="input-info">
                    <a class="register-link" href="{{ $view->url(['controller' => 'register', 'action' => 'index']) }}">Benutzerkonto anlegen</a>
                    <a class="register-link" href="{{ $view->url(['controller' => 'auth', 'action' => 'password-restore']) }}">Passwort vergessen?</a>
                </span>
            </li>
        </ul>
		<div class="form-buttons right">
            <!--<button id="submit" class="button">Login</button>//-->
            <input type="submit" id="submit" class="button" value="Login" />
        </div>
    </fieldset>

    </form>

{{*
<ul class="social">
    <li><a href="{{ $view->url(['action' => 'social', 'provider' => 'Facebook']) }}">Facebook</a></li>
</ul>
*}}

</article>
</div>
</section>

<aside>
</aside>

{{/block}}
