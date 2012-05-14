{{extends file="layout.tpl"}}

{{block content_classes}}mobile-single-column{{/block}}

{{block title}}TagesWoche Neues Passwort festlegen{{/block}}

{{block content}}
<section>
    <div class="profile-edit">
        <div class="profile-edit-box register-box">
            <form action="{{ $form->getAction() }}" method="{{ $form->getMethod() }}">
            <fieldset>
                {{ if $form->isErrors() }}
                <p>Ihr Passwort konnte nicht geändert werden. Bitte beachten Sie die Hinweise und versuchen Sie es erneut.</p>
                {{ /if }}

                <ul>
                    <li><dl>
                        {{ $form->password->setLabel("Neues Passwort")->removeDecorator('Errors') }}
                        {{ if $form->password->hasErrors() }}
                        <dd class="error info">Bitte tragen Sie hier Ihr neues Passwort ein (mindestens 6 Zeichen).</dd>
                        {{ /if }}
                    </dl></li>
                    <li><dl>
                        {{ $form->password_confirm->setLabel("Passwort wiederholen")->removeDecorator('Errors') }}
                        {{ if $form->password_confirm->hasErrors() && !$form->password->hasErrors() }}
                        <dd class="error info">Die Bestätigung Ihres Passwortes stimmt nicht mit Ihrem Passwort überein.</dd>
                        {{ /if }}
                    </dl></li>
                    <li class="buttons">
                        <input type="submit" value="Speichern" class="button right" />
                    </li>
                </ul>
            </fieldset>
            </form>
        </div>
    </div>
</section>
{{/block}}
