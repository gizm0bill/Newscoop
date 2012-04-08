{{extends file="layout.tpl"}}

{{block content}}
<section>
<div class="article-padding edit-profile-tab">
<article>
    <header>
        <p><strong>TagesWoche</strong> Neues Passwort festlegen</p>
    </header>

    <form action="{{ $form->getAction() }}" method="{{ $form->getMethod() }}">

    <fieldset class="fixBackground">
        {{ if $form->isErrors() }}
        <p>Ihr Passwort konnte nicht geändert werden. Bitte beachten Sie die Hinweise und versuchen Sie es erneut.</p>
        {{ /if }}

        
        <ul>
            <li><dl>
                {{ $form->password->setLabel("Neues Passwort")->removeDecorator('Errors') }}
                {{ if $form->password->hasErrors() }}
                <span class="error-info">Bitte tragen Sie hier Ihr neues Passwort ein (mindestens 6 Zeichen).</span>
                {{ /if }}
            </dl></li>
            <li><dl>
                {{ $form->password_confirm->setLabel("Passwort wiederholen")->removeDecorator('Errors') }}
                {{ if $form->password_confirm->hasErrors() && !$form->password->hasErrors() }}
                <span class="error-info">Die Bestätigung Ihres Passwortes stimmt nicht mit Ihrem Passwort überein.</span>
                {{ /if }}
            </dl></li>
        </ul>
		<div class="form-buttons right">
            <!--<button id="submit" class="button">Speichern</button>//-->
            <input type="submit" id="submit" class="button" value="Speichern" />
        </div>
    </fieldset>

    </form>

</article>
</div>
</section>

<aside>
</aside>

{{/block}}
