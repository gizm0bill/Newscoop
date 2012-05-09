<div id="omni-box-placeholder">
    <div id="omnibox">
        <a href="#" class="trigger">Open</a>
        <div class="omnibox-content" id="omniboxContainer">
            <div id="omniboxMessage" class="message" style="display: none;"></div>
            <div id="omniboxLogin">
                <fieldset>
                    <form id="omniboxLoginForm">
                        <ul class="omnilogin">
                            <li>
                                <h3>Login</h3>
                                <p>Melden Sie sich bei der TagesWoche an, um Artikel zu kommentieren und Mitteilungen direkt an die Redaktion zu schicken.<br>
                                <a href="http://www.tageswoche.ch/de/pages/about/3919/Dialogkultur.htm">Warum muss ich mich registrieren?</a></p>
                            </li>
                            <li>
                                <ul>
                                    <li>
                                        <label for="omniboxLoginEmail">E-Mail-Adresse</label>
                                        <input id="omniboxLoginEmail" type="text" />
                                    </li>
                                    <li>
                                        <label for="omniboxLoginPassword">Passwort</label>
                                        <input id="omniboxLoginPassword" type="password" />
                                    </li>
                                    <li>
                                        <input id="omniboxLoginRemember" type="checkbox" /> <label for="omniboxLoginRemember" style="display: inline;">Eingeloggt bleiben</label>
                                    </li>
                                    <li>
                                        <button class="button">Login</button>
                                        <a href="#" id="omniboxRegisterLink">Benutzerkonto anlegen</a><br>
                                        <a href="#" id="omniboxForgotPasswordLink">Passwort vergessen</a>
                                        <span class="sep"><em>oder</em></span>
                                        <a href="{{ $view->url(['controller' => 'auth', 'action' => 'social', 'provider' => 'Facebook'], 'default') }}" class="button fb-button"><span>Login mit Facebook</span></a>
                                    </li>
                                </ul>
                           </li>
                        </ul>
                    </form>
                </fieldset>
            </div>
            
            <div id="omniboxFeedback">
                <fieldset>
                    <form id="omniboxFeedbackForm">
                        <p class="top-info">
                            eingeloggt als <a id="omniboxFeedbackUserLink" href="{{ $view->baseUrl('/dashboard') }}">{{ $gimme->user->first_name }} {{ $gimme->user->last_name }}</a>
                            <br><a style="float: right;" href="{{ $view->baseUrl('/auth/logout') }}">Ausloggen</a>
                        </p>
                        <br>
                        <h3>An Redaktion schreiben</h3>
                        <ul>
                            <li class="clearfix" id="omniboxFeedbackInnerSwitch">
                                <ul class="radio-list">
                                    <li>
                                        <input type="radio" id="omniboxFeedbackRadioComment" name="omnibox-1" class="styled">
                                        <label for="omniboxFeedbackRadioComment">Kommentar zum Artikel</label>
                                    </li>
                                    <li>
                                        <input type="radio" id="omniboxFeedbackRadioFeedback" name="omnibox-1" class="styled" checked="checked">
                                        <label for="omniboxFeedbackRadioFeedback">Mitteilung an die Redaktion</label>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <label for="omniboxFeedbackSubject">Betreff</label>
                                <input type="text" id="omniboxFeedbackSubject" placeholder="" />
                            </li>
                            <li>
                                <label for="omniboxFeedbackContent">Mitteilung</label>
                                <textarea id="omniboxFeedbackContent" placeholder=""></textarea>
                            </li>
                            <li>
                                <p class="info">Material hochladen: Bilder (jpg, png, gif) Dokumente (pdf)</p>
                                <div class="custom-file-upload" id="omniboxUploadContainer">
                                    <div class="showValue" id="omniboxUploadInfo"></div>
                                    <input type="button" id="omniboxUpload" value="Datei anhängen">
                                </div>
                            </li>
                            <li>
                                <button class="button right">Senden</button>
                            </li>
                        </ul>
                    </form>
                </fieldset>
            </div>
            
            <div id="omniboxComment">
                <fieldset>
                    <form id="omniboxCommentForm">
                        <p class="top-info">
                            eingeloggt als <a id="omniboxFeedbackUserLink" href="{{ $view->baseUrl('/dashboard') }}">{{ $gimme->user->first_name }} {{ $gimme->user->last_name }}</a>
                            <br><a style="float: right;" href="{{ $view->baseUrl('/auth/logout') }}">Ausloggen</a>
                        </p>
                        <br>
                        <h3>Mein Kommentar</h3>
                        <ul>
                            <li class="clearfix">
                                <ul class="radio-list">
                                    <li>
                                        <input type="radio" id="omniboxCommentRadioComment" name="omnibox-2" class="styled" checked="checked">
                                        <label for="omniboxCommentRadioComment">Kommentar zum Artikel</label>
                                    </li>
                                    <li>
                                        <input type="radio" id="omniboxCommentRadioFeedback" name="omnibox-2" class="styled">
                                        <label for="omniboxCommentRadioFeedback">Mitteilung an die Redaktion</label>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <label for="omniboxCommentSubject">Betreff</label>
                                <input type="text" id="omniboxCommentSubject" placeholder="" />
                            </li>
                            <li>
                                <label for="omniboxCommentContent">Kommentar</label>
                                <textarea id="omniboxCommentContent" placeholder=""></textarea>
                            </li>
                            <li>
                                <button class="button right">Senden</button>
                            </li>
                        </ul>
                    </form>
                </fieldset>
            </div>
            
            <div id="omniboxRegister">
                <fieldset>
                    <h3>Registrierung</h3>
                    <p>Mit Ihrem Benutzerkonto können Sie Ihr Abo verwalten, Artikel kommentieren und mit anderen Leserinnen und Lesern in Kontakt treten.</p>
                    <p>Das Benutzerkonto ist kostenlos und kann jederzeit wieder gelöscht werden.</p>
                    <p>Bitte geben Sie Ihre E-Mail Adresse ein. Wir werden diese unter keinen Umständen an Dritte weitergeben.</p>
                    <form id="omniboxRegisterForm">
                        <ul class="reg-form">
                            <li>
                                <input type="text" id="omniboxRegisterEmail" placeholder="Ihre E-Mail-Adresse" />
                            </li>
                            <li class="clearfix">
                                <a href="#" class="left" id="omniboxLoginLink">Lieber doch nicht</a>
                                <button class="button right">Ja, ich will.</button>
                            </li>
                        </ul>
                    </form>
                </fieldset>
            </div>
            
            <div id="omniboxAfterRegister">
                <fieldset>
                    <h3>Fast fertig...</h3>
                    <p>Wir haben Ihren eine E-Mail geschickt.</p>
                    <p>Bitte prüfen Sie Ihren Posteingang und aktivieren Sie Ihr Benutzerkonto, indem Sie auf den Link in der E-Mail klicken.</p>
                    <p>Sollten Sie die E-Mail innert 10 Minuten nicht erhalten haben, kontrollieren Sie, ob die E-Mail möglicherweise im Spam-Filter hängen geblieben ist. Ist die E-Mail auch dort nicht aufzufinden, schreiben Sie uns an anmelden@tageswoche.ch und wir kümmern uns darum.</p>
                    <p>Wir freuen uns, Sie in wenigen Minuten in unserer Community begrüssen zu dürfen. </p>
                </fieldset>
            </div>
            
            <div id="omniboxForgotPassword">
                <fieldset>
                    <h3>Passwort wiederherstellen</h3>
                    <form id="omniboxForgotPasswordForm">
                        <ul class="reg-form">
                            <li>
                                <input type="text" id="omniboxForgotPasswordEmail" placeholder="Ihre E-Mail-Adresse" />
                            </li>
                            <li class="clearfix">
                                <button class="button right">Neues Passwort anfordern</button>
                                <a href="#" class="left" id="omniboxForgotPasswordBackLink">Zurück</a>
                            </li>
                        </ul>
                    </form>
                </fieldset>
            </div>
            
            <div id="omniboxUser">
            </div>
            
        </div>
    </div>
    
    <div id="omni-mobile-box">
        <div class="omnibox-content" style="display: none;">
            <div id="omniboxLoginMobile">
                <div class="top-title-line">
                    <a href="#" class="button-top left" id="omniboxLoginCloseMobile">Zurück</a>
                    <h3>Login</h3>
                </div>
                <fieldset>
                    <div id="omniboxLoginMessageMobile" class="message" style="display: none;"></div>
                    <form id="omniboxLoginFormMobile">
                        <ul class="omnilogin">
                            <li>
                                <p>Melden Sie sich bei der TagesWoche an, um Artikel zu kommentieren und Mitteilungen direkt an die Redaktion zu schicken.<br>
                                <a href="http://www.tageswoche.ch/de/pages/about/3919/Dialogkultur.htm">Warum muss ich mich registrieren?</a></p>
                            </li>
                            <li>
                                <ul>
                                    <li>
                                        <input type="text" id="omniboxLoginEmailMobile" placeholder="Username" />
                                    </li>
                                    <li>
                                        <input type="text" id="omniboxLoginPasswordMobile" placeholder="Password" />
                                    </li>
                                    <li>
                                        <input id="omniboxLoginRememberMobile" type="checkbox" /> <label for="omniboxLoginRememberMobile" style="display: inline;">Eingeloggt bleiben</label>
                                    </li>
                                    <li>
                                        <button class="button">Login</button>
                                    </li>
                                    <li class="clearfix">
                                        <a href="#" id="omniboxRegisterLinkMobile" class="left blank-button">Benutzerkonto anlegen</a>
                                        <a href="#" id="omniboxForgotPasswordLinkMobile" class="right blank-button">Passwort vergessen</a>
                                    </li>
                                    <li>
                                        <p>oder</p>
                                        <a href="{{ $view->url(['controller' => 'auth', 'action' => 'social', 'provider' => 'Facebook'], 'default') }}" class="button fb-button"><span>Login mit Facebook</span></a>
                                    </li>
                                    <li><a href="#" class="blank-button center" id="omniboxRegisterLinkMobile">Warum muss ich mich registrieren?</a></li>
                                </ul>
                           </li>
                        </ul>
                    </form>
                </fieldset>
            </div>
            
            <div id="omniboxFeedbackMobile">
                <form id="omniboxFeedbackFormMobile">
                <div class="top-title-line">
                    <a href="#" id="omniboxFeedbackCloseMobile" class="button-top no-arrow left">Cancel</a>
                    <a href="#" id="omniboxFeedbackSubmitMobile" class="button-top no-arrow right">Senden</a>
                    <h3>An Redaktion schreiben</h3>
                </div>
                <fieldset>
                    <div id="omniboxFeedbackMessageMobile" class="message" style="display: none;"></div>
                    <ul class="radios-list">
                        <div id="omniboxFeedbackInnerSwitchMobile">
                        <li>
                            <input type="radio" id="omniboxFeedbackRadioCommentMobile" name="omnibox-1" class="styled">
                            <label for="omniboxFeedbackRadioCommentMobile">Kommentar zum Artikel</label>
                        </li>
                        <li>
                            <input type="radio" id="omniboxFeedbackRadioFeedbackMobile" name="omnibox-1" class="styled" checked="checked">
                            <label for="omniboxFeedbackRadioFeedbackMobile">Mitteilung an die Redaktion</label>
                        </li>
                        </div>
                        <li class="flat-line"><input id="omniboxFeedbackSubjectMobile" type="text" placeholder="Betreff"></li>
                        <li class="flat-line"><textarea id="omniboxFeedbackContentMobile" placeholder="Mitteulung"></textarea></li>
                    </ul>
                </fieldset>
                </form>
            </div>
            
            <div id="omniboxCommentMobile">
                <form id="omniboxCommentFormMobile">
                <div class="top-title-line">
                    <a href="#" id="omniboxCommentCloseMobile" class="button-top no-arrow left">Cancel</a>
                    <a href="#" id="omniboxCommentSubmitMobile" class="button-top no-arrow right">Senden</a>
                    <h3>Mein Kommentar</h3>
                </div>
                <fieldset>
                    <div id="omniboxCommentMessageMobile" class="message" style="display: none;"></div>
                    <ul class="radios-list">
                        <li>
                            <input type="radio" id="omniboxCommentRadioCommentMobile" name="omnibox-2" class="styled" checked="checked">
                            <label for="omniboxCommentRadioCommentMobile">Kommentar zum Artikel</label>
                        </li>
                        <li>
                            <input type="radio" id="omniboxCommentRadioFeedbackMobile" name="omnibox-2" class="styled">
                            <label for="omniboxCommentRadioFeedbackMobile">Mitteilung an die Redaktion</label>
                        </li>
                        <li class="flat-line"><input id="omniboxCommentSubjectMobile" type="text" placeholder="Betreff"></li>
                        <li class="flat-line"><textarea id="omniboxCommentContentMobile" placeholder="Kommentar"></textarea></li>
                    </ul>
                </fieldset>
                </form>
            </div>
            
            <div id="omniboxUserMobile">
                <div class="top-title-line">
                    <a href="#" id="omniboxUserCloseMobile" class="button-top no-arrow left">Cancel</a>
                </div>
                <fieldset>
                    <ul class="radios-list">
                        <li><b>eingeloggt als <span id="omniboxUserNameMobile">{{ $gimme->user->first_name }} {{ $gimme->user->last_name }}</span></b></li>
                        <li><a href="{{ $view->baseUrl('/dashboard') }}" style="text-decoration: none;">Profil bearbeiten</a></li>
                        <li><a href="{{ $view->baseUrl('/meine-themen') }}" style="text-decoration: none;">Meine Themen</a></li>
                        <li><a href="{{ $view->baseUrl('/auth/logout') }}" style="text-decoration: none;">Ausloggen</a></li>
                    </ul>
                </fieldset>
            </div>
            
            <div id="omniboxRegisterMobile">
                <form id="omniboxRegisterFormMobile">
                <div class="top-title-line">
                    <a href="#" id="omniboxRegisterCloseMobile" class="button-top arrow left">Zurück</a>
                    <a href="#" id="omniboxRegisterSubmitMobile" class="button-top arrow right">Senden</a>
                    <h3>Registrierung</h3>
                </div>
                <fieldset>
                    <div id="omniboxCommentMessageMobile" class="message" style="display: none;"></div>
                    <ul class="radios-list">
                        <li>
                            <p>Mit Ihrem Benutzerkonto können Sie Ihr Abo verwalten, Artikel kommentieren und mit anderen Leserinnen und Lesern in Kontakt treten.</p>
                            <p>Das Benutzerkonto ist kostenlos und kann jederzeit wieder gelöscht werden.</p>
                            <p>Bitte geben Sie Ihre E-Mail Adresse ein. Wir werden diese unter keinen Umständen an Dritte weitergeben.</p>
                        </li>
                        <li>
                            <input type="text" id="omniboxRegisterEmailMobile" placeholder="Ihre E-Mail-Adresse" />
                        </li>
                    </ul>
                </fieldset>
                </form>
            </div>
            
            <div id="omniboxAfterRegisterMobile">
                <div class="top-title-line">
                    <a href="#" id="omniboxAfterRegisterCloseMobile" class="button-top arrow left">Zurück</a>
                    <h3>Registrierung</h3>
                </div>
                <fieldset>
                    <ul class="radios-list">
                        <li>
                            <p>Wir haben Ihren eine E-Mail geschickt.</p>
                            <p>Bitte prüfen Sie Ihren Posteingang und aktivieren Sie Ihr Benutzerkonto, indem Sie auf den Link in der E-Mail klicken.</p>
                            <p>Sollten Sie die E-Mail innert 10 Minuten nicht erhalten haben, kontrollieren Sie, ob die E-Mail möglicherweise im Spam-Filter hängen geblieben ist. Ist die E-Mail auch dort nicht aufzufinden, schreiben Sie uns an anmelden@tageswoche.ch und wir kümmern uns darum.</p>
                            <p>Wir freuen uns, Sie in wenigen Minuten in unserer Community begrüssen zu dürfen. </p>
                        </li>
                    </ul>
                </fieldset>
            </div>
            
            <div id="omniboxForgotPasswordMobile">
                <form id="omniboxForgotPasswordFormMobile">
                <div class="top-title-line">
                    <a href="#" id="omniboxForgotPasswordCloseMobile" class="button-top arrow left">Zurück</a>
                    <a href="#" id="omniboxForgotPasswordSubmitMobile" class="button-top arrow right">Senden</a>
                    <h3>Passwort wiederherstellen</h3>
                </div>
                <fieldset>
                    <div id="omniboxCommentMessageMobile" class="message" style="display: none;"></div>
                    <ul class="radios-list">
                        <li>
                            <input type="text" id="omniboxForgotPasswordEmailMobile" placeholder="Ihre E-Mail-Adresse" />
                        </li>
                    </ul>
                </fieldset>
                </form>
            </div>
            
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    omnibox.initialize();
    
    $('#omniboxLoginForm').submit(function() {
        var data = {
            email: $('#omniboxLoginEmail').val(),
            password: $('#omniboxLoginPassword').val(),
            remember: $('#omniboxLoginRemember').is(':checked') ? 1 : 0
        };
        
        $.ajax({
            type: 'POST',
            url: '{{ $view->baseUrl("/omnibox/login/?format=json") }}',
            data: data,
            dataType: 'json',
            success: function(data) {
                if (data.response == 'OK') {
                    $('#omniboxCommentUserLink').html(data.userData.realName);
                    $('#omniboxCommentUserLink').attr('href', "{{ $view->baseUrl('/user/profile/') }}" + data.userData.userName);
                    $('#omniboxFeedbackUserLink').html(data.userData.realName);
                    $('#omniboxFeedbackUserLink').attr('href', "{{ $view->baseUrl('/user/profile/') }}" + data.userData.userName);
                    omnibox.setMessage('');
                    omnibox.loggedIn = true;
                    if ('afterLogin' in omnibox) {
                        omnibox.afterLogin();
                    }
                    omnibox.checkView();
                    $('#omnibox').width(omnibox.openWidth);
                    $('#omnibox').height(omnibox.openHeight);
                }
                else {
                    omnibox.setMessage(data.response);
                }
            }
        });
        
        return(false);
    });
    
    $('#omniboxLoginFormMobile').submit(function() {
        var data = {
            email: $('#omniboxLoginEmailMobile').val(),
            password: $('#omniboxLoginPasswordMobile').val(),
            remember: $('#omniboxLoginRememberMobile').is(':checked') ? 1 : 0
        };
        
        $.ajax({
            type: 'POST',
            url: '{{ $view->baseUrl("/omnibox/login/?format=json") }}',
            data: data,
            dataType: 'json',
            success: function(data) {
                if (data.response == 'OK') {
                    $('#omniboxUserNameMobile').html(data.userData.realName);
                    omnibox.setMessage('');
                    omnibox.loggedIn = true;
                    if ('afterLogin' in omnibox) {
                        omnibox.afterLogin();
                    }
                    omnibox.checkView();
                }
                else {
                    omnibox.setMessage(data.response);
                }
            }
        });
        
        return(false);
    });
    
    $('#omniboxRegisterForm').submit(function() {
        var data = {
            email: $('#omniboxRegisterEmail').val()
        };
        
        $.ajax({
            type: 'POST',
            url: '{{ $view->baseUrl("/register/register/?format=json") }}',
            data: data,
            dataType: 'json',
            success: function(data) {
                if (data.response == 'OK') {
                    omnibox.setMessage('');
                    omnibox.switchView('omniboxAfterRegister');
                }
                else {
                    omnibox.setMessage(data.response);
                }
            }
        });
        
        return(false);
    });
    
    $('#omniboxRegisterFormMobile').submit(function() {
        var data = {
            email: $('#omniboxRegisterEmailMobile').val()
        };
        
        $.ajax({
            type: 'POST',
            url: '{{ $view->baseUrl("/register/register/?format=json") }}',
            data: data,
            dataType: 'json',
            success: function(data) {
                if (data.response == 'OK') {
                    omnibox.setMessage('');
                    omnibox.switchView('omniboxAfterRegister');
                }
                else {
                    omnibox.setMessage(data.response);
                }
            }
        });
        
        return(false);
    });
    
    $('#omniboxFeedbackForm').submit(function() {
        if ($('#omniboxFeedbackSubject').val() == '' || $('#omniboxFeedbackContent').val() == '') {
            omnibox.setMessage('Sie haben Ihre Nachricht vergessen.');
        }
        
        else {
            if (omnibox.uploader.total.queued > 0) {
                omnibox.uploader.start();
            }
            else {
                var data = {
                    f_feedback_url: String(document.location),
                    f_feedback_subject: $('#omniboxFeedbackSubject').val(),
                    f_feedback_content: $('#omniboxFeedbackContent').val(),
                    f_language: '{{ $gimme->language->number }}',
                    f_section: '{{ $gimme->section->id }}',
                    f_article: '{{ $gimme->article->number }}',
                    f_publication: '{{ $gimme->publication->identifier }}'
                };
                
                if (omnibox.fileType == 'image') {
                    data['image_id'] = omnibox.fileId;
                }
                if (omnibox.fileType == 'document') {
                    data['document_id'] = omnibox.fileId;
                }
                
                $.ajax({
                    type: 'POST',
                    url: '{{ $view->baseUrl("/feedback/save/?format=json") }}',
                    data: data,
                    dataType: 'json',
                    success: function(data) {
                        omnibox.setMessage(data.response);
                        $('#omniboxFeedbackSubject').val('');
                        $('#omniboxFeedbackContent').val('');
                        omnibox.fileType = null;
                        omnibox.fileId = null;
                    }
                });
            }
        }
        return(false);
    });
    
    $('#omniboxFeedbackFormMobile').submit(function() {
        if ($('#omniboxFeedbackSubjectMobile').val() == '' || $('#omniboxFeedbackContentMobile').val() == '') {
            omnibox.setMessage('Sie haben Ihre Nachricht vergessen.');
        }
        
        else {
            var data = {
                f_feedback_url: String(document.location),
                f_feedback_subject: $('#omniboxFeedbackSubjectMobile').val(),
                f_feedback_content: $('#omniboxFeedbackContentMobile').val(),
                f_language: '{{ $gimme->language->number }}',
                f_section: '{{ $gimme->section->id }}',
                f_article: '{{ $gimme->article->number }}',
                f_publication: '{{ $gimme->publication->identifier }}'
            };
            
            $.ajax({
                type: 'POST',
                url: '{{ $view->baseUrl("/feedback/save/?format=json") }}',
                data: data,
                dataType: 'json',
                success: function(data) {
                    omnibox.setMessage(data.response);
                    $('#omniboxFeedbackSubjectMobile').val('');
                    $('#omniboxFeedbackContentMobile').val('');
                }
            });
        }
        return(false);
    });
    
    $('#omniboxCommentForm').submit(function() {
        if ($('#omniboxCommentContent').val() == '') {
            omnibox.setMessage('Sie haben Ihre Nachricht vergessen.');
        }
        
        else {
            var data = {
                f_submit_comment: 'SUBMIT',
                f_comment_nickname: '',
                f_comment_reader_email: '',
                f_comment_content: $('#omniboxCommentContent').val(),
                f_article_number: '{{$gimme->article->number}}',
                f_comment_is_anonymous: 0,
                f_comment_subject: $('#omniboxCommentSubject').val(),
                f_language: '{{ $gimme->language->number }}'
            };
            
            $.ajax({
                type: 'POST',
                url: '{{ $view->baseUrl("/comment/save/?format=json") }}',
                data: data,
                dataType: 'json',
                success: function(data) {
                    if (data.response == 'OK') {
                        omnibox.setMessage('Nachricht gesendet.');
                    }
                    else {
                        omnibox.setMessage(data.response);
                    }
                    
                    $('#omniboxCommentSubject').val('');
                    $('#omniboxCommentContent').val('');
                }
            });
        }
        return(false);
    });
    
    $('#omniboxCommentFormMobile').submit(function() {
        if ($('#omniboxCommentContentMobile').val() == '') {
            omnibox.setMessage('Sie haben Ihre Nachricht vergessen.');
        }
        
        else {
            var data = {
                f_submit_comment: 'SUBMIT',
                f_comment_nickname: '',
                f_comment_reader_email: '',
                f_comment_content: $('#omniboxCommentContentMobile').val(),
                f_article_number: '{{$gimme->article->number}}',
                f_comment_is_anonymous: 0,
                f_comment_subject: $('#omniboxCommentSubjectMobile').val(),
                f_language: '{{ $gimme->language->number }}'
            };
            
            $.ajax({
                type: 'POST',
                url: '{{ $view->baseUrl("/comment/save/?format=json") }}',
                data: data,
                dataType: 'json',
                success: function(data) {
                    if (data.response == 'OK') {
                        omnibox.setMessage('Nachricht gesendet.');
                    }
                    else {
                        omnibox.setMessage(data.response);
                    }
                    
                    $('#omniboxCommentSubjectMobile').val('');
                    $('#omniboxCommentContentMobile').val('');
                }
            });
        }
        return(false);
    });
    
    $('#omniboxForgotPasswordForm').submit(function() {
        var data = {
            email: $('#omniboxForgotPasswordEmail').val()
        };
        
        $.ajax({
            type: 'POST',
            url: '{{ $view->baseUrl("/auth/password-restore-ajax/?format=json") }}',
            data: data,
            dataType: 'json',
            success: function(data) {
                omnibox.setMessage(data.response);
            }
        });
        
        return(false);
    });
    
    $('#omniboxForgotPasswordFormMobile').submit(function() {
        var data = {
            email: $('#omniboxForgotPasswordEmailMobile').val()
        };
        
        $.ajax({
            type: 'POST',
            url: '{{ $view->baseUrl("/auth/password-restore-ajax/?format=json") }}',
            data: data,
            dataType: 'json',
            success: function(data) {
                omnibox.setMessage(data.response);
            }
        });
        
        return(false);
    });
    
    $('#omniboxFeedbackRadioComment').change(function() {
        if ($('#omniboxFeedbackRadioComment').is(':checked')) {
            $('#omniboxCommentRadioComment').attr('checked', 'checked');
            $('#omniboxCommentRadioFeedback').removeAttr('checked');
            omnibox.switchView('omniboxComment');
        }
    });
    
    $('#omniboxFeedbackRadioFeedback').change(function() {
        if ($('#omniboxFeedbackRadioFeedback').is(':checked')) {
            $('#omniboxCommentRadioComment').removeAttr('checked');
            $('#omniboxCommentRadioFeedback').attr('checked', 'checked');
            omnibox.switchView('omniboxFeedback');
        }
    });
    
    $('#omniboxFeedbackRadioCommentMobile').change(function() {
        if ($('#omniboxFeedbackRadioCommentMobile').is(':checked')) {
            $('#omniboxCommentRadioCommentMobile').attr('checked', 'checked');
            $('#omniboxCommentRadioFeedbackMobile').removeAttr('checked');
            omnibox.switchView('omniboxComment');
        }
    });
    
    $('#omniboxFeedbackRadioFeedbackMobile').change(function() {
        if ($('#omniboxFeedbackRadioFeedbackMobile').is(':checked')) {
            $('#omniboxCommentRadioCommentMobile').removeAttr('checked');
            $('#omniboxCommentRadioFeedbackMobile').attr('checked', 'checked');
            omnibox.switchView('omniboxFeedback');
        }
    });
    
    $('#omniboxCommentRadioComment').change(function() {
        if ($('#omniboxCommentRadioComment').is(':checked')) {
            $('#omniboxFeedbackRadioComment').attr('checked', 'checked');
            $('#omniboxFeedbackRadioFeedback').removeAttr('checked');
            omnibox.switchView('omniboxComment');
        }
    });
    
    $('#omniboxCommentRadioFeedback').change(function() {
        if ($('#omniboxCommentRadioFeedback').is(':checked')) {
            $('#omniboxFeedbackRadioComment').removeAttr('checked');
            $('#omniboxFeedbackRadioFeedback').attr('checked', 'checked');
            omnibox.switchView('omniboxFeedback');
        }
    });
    
    $('#omniboxCommentRadioCommentMobile').change(function() {
        if ($('#omniboxCommentRadioCommentMobile').is(':checked')) {
            $('#omniboxFeedbackRadioCommentMobile').attr('checked', 'checked');
            $('#omniboxFeedbackRadioFeedbackMobile').removeAttr('checked');
            omnibox.switchView('omniboxComment');
        }
    });
    
    $('#omniboxCommentRadioFeedbackMobile').change(function() {
        if ($('#omniboxCommentRadioFeedbackMobile').is(':checked')) {
            $('#omniboxFeedbackRadioCommentMobile').removeAttr('checked');
            $('#omniboxFeedbackRadioFeedbackMobile').attr('checked', 'checked');
            omnibox.switchView('omniboxFeedback');
        }
    });
    
    $('#omniboxRegisterLink').click(function() {
        omnibox.switchView('omniboxRegister');
    });
    
    $('#omniboxLoginLink').click(function() {
        omnibox.switchView('omniboxLogin');
    });
    
    $('#omniboxForgotPasswordLink').click(function() {
        omnibox.switchView('omniboxForgotPassword');
    });
    
    $('#omniboxRegisterLinkMobile').click(function() {
        omnibox.switchView('omniboxRegister');
    });
    
    $('#omniboxForgotPasswordLinkMobile').click(function() {
        omnibox.switchView('omniboxForgotPassword');
    });
    
    $('#omniboxForgotPasswordBackLink').click(function() {
        omnibox.switchView('omniboxLogin');
    });
    
    $('#omniboxLoginCloseMobile').click(function() {
        omnibox.hide();
    });
    
    $('#omniboxFeedbackCloseMobile').click(function() {
        omnibox.hide();
    });
    
    $('#omniboxFeedbackSubmitMobile').click(function() {
        $('#omniboxFeedbackFormMobile').submit();
    });
    
    $('#omniboxCommentCloseMobile').click(function() {
        omnibox.hide();
    });
    
    $('#omniboxCommentSubmitMobile').click(function() {
        $('#omniboxCommentFormMobile').submit();
    });
    
    $('#omniboxUserCloseMobile').click(function() {
        omnibox.hide();
    });
    
    $('#omniboxRegisterCloseMobile').click(function() {
        omnibox.switchView('omniboxLogin');
    });
    
    $('#omniboxRegisterSubmitMobile').click(function() {
        $('#omniboxRegisterFormMobile').submit();
    });
    
    $('#omniboxAfterRegisterCloseMobile').click(function() {
        omnibox.switchView('omniboxLogin');
    });
    
    $('#omniboxForgotPasswordCloseMobile').click(function() {
        omnibox.switchView('omniboxLogin');
    });
    
    $('#omniboxForgotPasswordSubmitMobile').click(function() {
        $('#omniboxForgotPasswordFormMobile').submit();
    });
});

var omnibox = {
    loggedIn: false,
    commentable: false,
    uploadUrl: '{{ $view->baseUrl("/feedback/upload/?format=json") }}',
    flashRuntime: '{{ $view->baseUrl("/js/plupload/js/plupload.flash.swf") }}',
    silverlightRuntime: '{{ $view->baseUrl("/js/plupload/js/plupload.silverlight.xap") }}',
    fileType: null,
    fileId: null,
    openWidth: 0,
    openHeight: 0,
    status: 0,
    mobile: false,
    currentView: false,
    
    initialize: function() {
        if ($(document).width() <= 768) {
            omnibox.mobile = true;
            $('#omnibox').hide();
            $('#omni-mobile-box').show();
        }
        else {
            omnibox.mobile = false;
            $('#omnibox').show();
            $('#omni-mobile-box').hide();
        }
        
        if ('{{$gimme->user->logged_in}}' != '') {
            omnibox.loggedIn = true;
        }
        if ('{{$gimme->article->number}}' != '' && '{{$gimme->article->comments_locked}}' == '0' && '{{$gimme->article->comments_enabled}}' == '1') {
            omnibox.commentable = true;
        }
        
        omnibox.checkView();
    },
    
    checkView: function() {
        if (omnibox.loggedIn == true) {
            if (omnibox.commentable == true) {
                omnibox.switchView('omniboxComment');
            }
            else {
                omnibox.switchView('omniboxFeedback');
                $('#omniboxFeedbackInnerSwitch').hide();
                $('#omniboxFeedbackInnerSwitchMobile').hide();
            }
            if (!omnibox.mobile) {
                omnibox.uploader = new plupload.Uploader({
                    runtimes: 'html5,html4',
                    browse_button: 'omniboxUpload',
                    max_file_size: '20mb',
                    flash_swf_url: omnibox.flashRuntime,
                    silverlight_xap_url: omnibox.silverlightRuntime,
                    url: omnibox.uploadUrl,
                    filters: [{title: "Image files", extensions: "jpg,gif,png"}, {title: "Document", extensions: "pdf"}],
                    multi_selection: false
                });
                omnibox.uploader.init();
                omnibox.uploader.refresh();
                omnibox.uploader.bind('FilesAdded', function(up, files) {
                    if (this.files.length > 1) {
                        this.removeFile(this.files[0]);
                    }
                    $('#omniboxUploadInfo').html(files[0].name);
                });
                omnibox.uploader.bind('FileUploaded', function(up, file, info) {
                    var fileNameParts = file.name.split('.');
                    var extension = fileNameParts[fileNameParts.length - 1];
                    extension = extension.toLowerCase();
                    
                    if (extension == 'jpg' || extension == 'gif' || extension == 'png') {
                        omnibox.fileType = 'image';
                        response = $.parseJSON(info.response);
                        omnibox.fileId = response.response;
                        $('#omniboxFeedbackForm').trigger('submit');
                    }
                    if (extension == 'pdf') {
                        omnibox.fileType = 'document';
                        response = $.parseJSON(info.response);
                        omnibox.fileId = response.response;
                        $('#omniboxFeedbackForm').trigger('submit');
                    }
                });
            }
        }
        else {
            omnibox.switchView('omniboxLogin');
        }
    },
    
    switchView: function(view) {
        if (view == 'omniboxLogin') {
            omnibox.openWidth = 319;
            omnibox.openHeight = 500;
        }
        else {
            omnibox.openWidth = 582;
            omnibox.openHeight = 420;
        }
        var views = ['omniboxFeedback', 'omniboxComment', 'omniboxLogin', 'omniboxRegister', 'omniboxAfterRegister', 'omniboxForgotPassword', 'omniboxUser'];
        for (var i in views) {
            if (omnibox.mobile == true) {
                $('#'+views[i]+'Mobile').hide();
            }
            else {
                $('#'+views[i]).hide();
            }
        }
        if (omnibox.mobile == true) {
            $('#'+view+'Mobile').show();
        }
        else {
            $('#'+view).show();
        }
        omnibox.currentView = view;
    },
    
    setMessage: function(message) {
        var id = 'omniboxMessage';
        if (omnibox.mobile == true) {
            id = omnibox.currentView + 'MessageMobile';
        }
        
        $('#'+id).html(message);
        if (message == '') {
            $('#'+id).hide();
        }
        else {
            $('#'+id).show();
        }
    },
    
    show: function() {
        if (omnibox.mobile == true) {
            $('.omnibox-content').show();
        }
        else {
            $('#omnibox').animate({
                width: omnibox.openWidth,
                height: omnibox.openHeight
            },500);
            $('.omnibox-content').show();
            $('.overlay').fadeIn(500);
        }
        
        omnibox.status = 1;
    },
    
    hide: function() {
        if (omnibox.mobile == true) {
            $('.omnibox-content').hide();
        }
        else {
            $('#omnibox').animate({
                width: '44px',
                height: '54px'
            },500);
            $('.omnibox-content').fadeOut(500);
            $('.overlay').fadeOut(500);
        }
                
        omnibox.status = 0;
    },
    
    toggle: function() {
        if (omnibox.status == 0) {
            omnibox.show();
        }
        else if (omnibox.status == 1) {
            omnibox.hide();
        }
    },
    
    showLogin: function() {
        if (omnibox.loggedIn) {
            omnibox.switchView('omniboxUser');
        }
        else {
            omnibox.switchView('omniboxLogin');
        }
        omnibox.show();
    },
    
    showContent: function() {
        if (omnibox.loggedIn) {
            omnibox.checkView();
            omnibox.show();
        }
        else {
            omnibox.showLogin();
        }
    }
}
</script>