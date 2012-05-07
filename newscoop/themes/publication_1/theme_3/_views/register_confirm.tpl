{{extends file="layout.tpl"}}

{{block content_classes}}mobile-single-column{{/block}}

{{block title}}TagesWoche Benutzerkonto{{/block}}

{{block content}}
        	<section>
            
            	<div class="profile-edit">
                    
                    <div class="profile-edit-box register-box">
        
                        <form action="{{ $form->getAction() }}" method="{{ $form->getMethod() }}" enctype="multipart/form-data">
                        <fieldset>
                        
                    		<h3>Die Community ist noch einen Schritt entfernt</h3>
                            <p>Bitte vervollständigen Sie nun Ihre Zugangsdaten, um Ihr Benutzerkonto zu aktivieren. Mit Ihrem Benutzerkonto können Sie Ihr Abo verwalten, Artikel kommentieren und mit anderen TagesWoche-Leserinnen und -Lesern in Kontakt treten.</p>
                        
                        	<ul>
                            	<li><dl>
                                    {{ $form->first_name->setLabel("Vorname*")->removeDecorator('Errors') }}
                                    {{ if $form->first_name->hasErrors() }}
                                    <dd class="error info"><p>Bitte geben Sie eine Vorname an.</p></dd>
                                    {{ /if }}
                                </dl></li>
                            	<li><dl>
                                    {{ $form->last_name->setLabel("Nachname*")->removeDecorator('Errors') }}
                                    {{ if $form->last_name->hasErrors() }}
                                    <dd class="error info"><p>Bitte geben Sie eine Nachname an.</p></dd>
                                    {{ /if }}
                                </dl></li>
                            	<li><dl>
                                    {{ $form->username->setLabel("Nutzername*")->removeDecorator('Errors') }}
                                    {{ if $form->username->hasErrors() && !$form->username->getValue() }}
                                    <dd class="error info"><p>Bitte geben Sie eine Nutzername an.</p></dd>
                                    {{ else if $form->username->hasErrors() }}
                                    <dd class="error info"><p>Nutzername besetzt. Bitte geben Sie eine andere Nutzername an.</p></dd>
                                    {{ /if }}
                                    <dd class="info"><p>Dieser Name wird bei Ihren Beiträgen auf tageswoche.ch angezeigt. Wir empfehlen, dass Sie Ihren echten Namen verwenden, erlauben aber auch Pseudonyme.</p></dd>
                                </dl></li>
                            	<li class="profile-image">
                                	<img src="{{ $img }}" alt="" />
                                    <div><dl>
                                        {{ $form->image->setLabel("Laden Sie ein eigenes Profilbild hoch.") }}
                                    	<dd>Bitte verwenden Sie keine Bilder, an denen Sie die Rechte nicht besitzen oder auf denen andere Personen als Sie selber abgebildet sind.</dd>
                                    </dl></div>
                                </li>
                            	<li><dl>
                                    {{ $form->password->setLabel("Passwort*")->removeDecorator('Errors') }}
                                    {{ if $form->password->hasErrors() }}
                                    <dd class="error info"><p>Bitte geben Sie eine Passwort mindestens 6 Zeichen lang an.</p></dd>
                                    {{ /if }}
                                    <dd class="info"><p>Ihre Passwort solite mindestens 6 Zeichen lang sein.</p></dd>
                                </dl></li>
                            	<li><dl>
                                    {{ $form->password_confirm->setLabel("Password wiederholen*")->removeDecorator('Errors') }}
                                    {{ if !$form->password->hasErrors() && $form->password_confirm->hasErrors() }}
                                    <dd class="error info"><p>Bitte geben Sie seine Passwort noch einmal an.</p></dd>
                                    {{ /if }}
                                    <dd class="info"><p>Bitten geben Sie Ihr passwort erneut ein, um Tippfehler auszuschliesen.</p></dd>
                                </dl></li>
                                <li class="terms-box">
                                	<h4>Unsere Nutzungsbedingungen</h4>
                                    <div class="terms-content">
                                        {{ include file="_tpl/terms-of-use.tpl" }}
                                    </div>
                                    <div class="check"><dl>
                                        {{ $form->terms_of_use->setLabel("")->removeDecorator('Errors') }}
                                        <dd><p><label for="terms_of_use">Ich habe die Nutzungsbedingungen gelesen und stimme Ihnen zu.</label></p></dd>
                                        {{ if $form->terms_of_use->hasErrors() }}
                                        <dd class="error info"><p>Sie können sich nur registrieren, wenn Sie unseren Nutzungsbedingungen zustimmen. Dies geschieht zu Ihrer und unserer Sicherheit. Bitten setzen Sie im entsprechenden Feld ein Häkchen.</p></dd>
                                        {{ /if }}
                                    </dl></div>
                                </li>
                                <li class="buttons">
                                    <input type="submit" value="Konto aktivieren" class="button right" />
                                </li>
                            </ul>
                        
                        </fieldset>
                        </form>
                    
                    </div>
                
                </div>
            
            </section>

            {{ if !empty($social) }}
            <aside>
            	<div class="profile-edit-box register-box">
                    <form method="POST" action="{{ $view->url(['controller' => 'auth', 'action' => 'merge'], 'default') }}">
                    <fieldset>
                        <h3>Sie haben schon ein Profil bei der TagesWoche?</h3>
                        <p>Umso besser. Loggen Sie sich ein, um Ihr bestehendes Konto mit Facebook zu verknüpfen.</p>
                        <ul>
                            <li>
                                <label>E-Mail-Adresse</label>
                                <input type="text" name="email" value="" />
                            </li>
                            <li>
                                <label>Passwort</label>
                                <input type="password" name="password" value="" />
                            </li>
                            <li class="buttons">
                                <input type="submit" value="Konto verknüpfen" class="button" />
                            </li>
                        </ul>
                    </fieldset>
                    </form>
                </div>
            </aside>
            {{ /if }}

<script type="text/javascript">
$('#first_name, #last_name').keyup(function() {
    $.post('{{ $view->url(['controller' => 'register', 'action' => 'generate-username'], 'default') }}?format=json', {
        'first_name': $('#first_name').val(),
        'last_name': $('#last_name').val()
    }, function (data) {
        $('#username').val(data.username).css('color', 'green');
    }, 'json');
});

$('#username').change(function() {
    $.post('{{ $view->url(['controller' => 'register', 'action' => 'check-username'], 'default') }}?format=json', {
        'username': $(this).val()
    }, function (data) {
        if (data.status) {
            $('#username').css('color', 'green');
        } else {
            $('#username').css('color', 'red');
        }
    }, 'json');
}).keyup(function() {
    $(this).change();
});
</script>
{{/block}}
