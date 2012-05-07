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
                        <p class="top-info">eingeloggt als <a id="omniboxFeedbackUserLink" href="{{ $view->baseUrl('/dashboard') }}">{{ $gimme->user->name }}</a></p>
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
                        <p class="top-info">eingeloggt als <a id="omniboxCommentUserLink" href="{{ $view->baseUrl('/dashboard') }}">{{ $gimme->user->name }}</a></p>
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
                                <a href="#" class="left" id="omniboxForgotPasswordBackLink">Back</a>
                            </li>
                        </ul>
                    </form>
                </fieldset>
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
                        $('#omniboxFeedbackSubject').val('')
                        $('#omniboxFeedbackContent').val('')
                        omnibox.fileType = null;
                        omnibox.fileId = null;
                    }
                });
            }
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
    
    $('#omniboxRegisterLink').click(function() {
        omnibox.switchView('omniboxRegister');
    });
    
    $('#omniboxLoginLink').click(function() {
        omnibox.switchView('omniboxLogin');
    });
    
    $('#omniboxForgotPasswordLink').click(function() {
        omnibox.switchView('omniboxForgotPassword');
    });
    
    $('#omniboxForgotPasswordBackLink').click(function() {
        omnibox.switchView('omniboxLogin');
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
    width: 0,
    
    initialize: function() {
        omnibox.width = $(document).width();
        
        if ('{{$gimme->user->logged_in}}' != '') {
            omnibox.loggedIn = true;
        }
        if ('{{$gimme->article->number}}' != '' && '{{$gimme->article->comments_locked}}' == 0 && '{{$gimme->article->comments_enabled}}' == 1) {
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
            }
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
        var views = ['omniboxFeedback', 'omniboxComment', 'omniboxLogin', 'omniboxRegister', 'omniboxAfterRegister', 'omniboxForgotPassword'];
        for (var i in views) {
            $('#'+views[i]).hide();
        }
        $('#'+view).show();
    },
    
    setMessage: function(message) {
        $('#omniboxMessage').html(message);
        if (message == '') {
            $('#omniboxMessage').hide();
        }
        else {
            $('#omniboxMessage').show();
        }
    },
    
    show: function() {
        $('#omnibox').animate({
            width: omnibox.openWidth,
            height: omnibox.openHeight
        },500);
        $('.omnibox-content').show();
        $('.overlay').fadeIn(500);
        
        omnibox.status = 1;
    },
    
    hide: function() {
        $('#omnibox').animate({
            width: '44px',
            height: '54px'
        },500);
        $('.omnibox-content').fadeOut(500);
        $('.overlay').fadeOut(500);
        
        omnibox.status = 0;
    },
    
    toggle: function() {
        if (omnibox.status == 0) {
            omnibox.show();
        }
        else if (omnibox.status == 1) {
            omnibox.hide();
        }
    }
}
</script>