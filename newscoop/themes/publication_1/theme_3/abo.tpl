{{ include file="_tpl/_html-head.tpl" }}
<body>
{{ include file="_tpl/_netmetrix-stats.tpl" }}
    <div id="wrapper">
{{ include file="_werbung/section-header.tpl" }}
{{ include file="_tpl/header-omnibox.tpl" }}
{{ include file="_tpl/header.tpl" }}

<script type="text/javascript">
$(document).ready(function(){
    $("a.green-button, a.grey-button").fancybox({
        'hideOnContentClick': false,
        'transitionIn'  : 'elastic',
        'transitionOut' : 'elastic',
        'speedIn'   : 600, 
        'speedOut'    : 200, 
        'overlayShow' : false        
    });

    $('.abo-register-link').click(function() {
        $.fancybox.close();
        omnibox.show();
        omnibox.switchView('omniboxRegister');
    });
});

var userKey = '{{user_key}}';
var userSubscriber = '{{$gimme->user->subscriber}}';

function newSubscription(productId) {
    var container = document.getElementById('iframe_' + productId);
    container.src = 'https://abo.tageswoche.ch/dmpro?type=abo&mode=new&userkey=' + userKey + '&product=' + productId;
}
function newSubscriptionAnonymous(productId) {
    var container = document.getElementById('iframe_' + productId);
    container.style.display = 'inline';
    container.src = 'https://abo.tageswoche.ch/dmpro?type=abo&mode=new&product=' + productId;
    container.style.width='600px';
}
function newSubscriber(productId, firstName, lastName, email) {
    var container = document.getElementById('iframe_' + productId);
    container.src = 'https://abo.tageswoche.ch/dmpro?type=abo&mode=new&name=' + escape(lastName) + '&firstname=' + escape(firstName) + '&email=' + escape(email) + '&jscallback=afterRegistration&product=' + productId;
}
</script>
        <div class="content-box clearfix">
            <section>
                <div class="mobile-list-view abo-list-view">
                <article class="desktop-hide">
                        <p>Sie können Ihr Abo natürlich auch telefonisch bestellen. Montag bis Freitag, 8:30-12:30 und 13:30-17:30 Uhr.</p>
                </article>
                {{ list_articles ignore_issue="true" ignore_section="true" constraints="issue is 1 section is 20 type is subscription" }}
                    <article>
                        <figure class="left">
                            <img src="{{ uri options="image 1 width 300 height 200 crop center" }}" alt="" />
                            <figcaption>{{ $gimme->article->image(1)->description }}</figcaption>
                        </figure>
                        <div class="abo-list">
                            <h3><a>{{ $gimme->article->name }}</a></h3>
                            <ul class="check-list">
                                {{ if $gimme->article->bullet_one }}<li>{{ $gimme->article->bullet_one }}</li>{{ /if }}
                                {{ if $gimme->article->bullet_two }}<li>{{ $gimme->article->bullet_two }}</li>{{ /if }}
                                {{ if $gimme->article->bullet_three }}<li>{{ $gimme->article->bullet_three }}</li>{{ /if }}
                            </ul>
                            <a href="#container_{{ $gimme->article->id_regular }}" class="green-button">Jetzt online bestellen</a>
                            <a href="#container_{{ $gimme->article->id_regular }}" class="grey-button">Bestellen</a>
                            {{ if $gimme->article->id_gift }}
                            <a href="#container_{{ $gimme->article->id_gift }}" class="green-button">Verschenken</a>
                            <a href="#container_{{ $gimme->article->id_gift }}" class="grey-button">Verschenken</a>
                            {{ /if }}
                            <div style="display: none">
                            {{ if $gimme->user->logged_in }}
                            <div id="container_{{ $gimme->article->id_regular }}">
                            <p style="margin-top: 0.3em; font-family: sans-serif; font-size: 1.5em; color: red;">
                            Bis Mittwoch, 15:00 bestellen. <br>Freitags im Briefkasten.
                            </p>
                            <iframe id="iframe_{{ $gimme->article->id_regular }}" width="600" height="500"></iframe>
                            <script>
                            if (userSubscriber != '') {
                                newSubscription({{ $gimme->article->id_regular }});
                            } else {
                                newSubscriber({{ $gimme->article->id_regular }}, '{{ $gimme->user->first_name }}', '{{ $gimme->user->last_name }}', '{{ $gimme->user->email }}');
                            }
                            </script>
                            </div>
                            {{ else }}
                            <div id="container_{{ $gimme->article->id_regular }}" class="popup-box" style="width: 440px; overflow-x: hidden;">
                                <h3>Abo des TagesWoche bestellen</h3>

                                <p>Bitte wählen Sie den gewünschten Bestellprozess:</p>

                                <p>
                                - <a href="{{ $view->baseUrl('/auth') }}">Profil bei tageswoche.ch bereits vorhanden</a><br/>
                                - <a href="#" class="abo-register-link">Zeitungabo bestellen und gleichzeitig Profil anlegen</a><br/>
                                - <a href="javascript:newSubscriptionAnonymous({{ $gimme->article->id_regular }})">Nur Zeitungsabo bestellen</a>
                                </p>

                                <p style="margin-top: 0.3em;">Bis Mittwoch, 15 Uhr bestellt = am Freitag im Briefkasten</p>
                                <iframe id="iframe_{{ $gimme->article->id_regular }}" width="440" height="500" style="display: none; overflow-x: hidden;"></iframe>
                            </div>
                            {{ /if }}
                            </div>

                            <div style="display: none">
                            {{ if $gimme->user->logged_in }}
                            <div id="container_{{ $gimme->article->id_gift }}">
                                <p style="margin-top: 0.3em; font-family: sans-serif; font-size: 1.5em; color: red;">
                                    Bis Mittwoch, 15:00 bestellen. <br>Freitags im Briefkasten.
                                </p>
                                <iframe id="iframe_{{ $gimme->article->id_gift }}" width="600" height="500"></iframe>
                                <script>
                                if (userSubscriber != '') {
                                    newSubscription({{ $gimme->article->id_gift }});
                                } else {
                                    newSubscriber({{ $gimme->article->id_gift }}, '{{ $gimme->user->first_name }}', '{{ $gimme->user->last_name }}', '{{ $gimme->user->email }}');
                                }
                                </script>
                            </div>
                            {{ else }}
                            <div id="container_{{ $gimme->article->id_gift }}" class="popup-box" style="width: 440px; overflow-x: hidden;">
                                <h3>Abo des TagesWoche bestellen</h3>

                                <p>Bitte wählen Sie den gewünschten Bestellprozess:</p>

                                <p>
                                - <a href="{{ $view->baseUrl('/auth') }}">Profil bei tageswoche.ch bereits vorhanden</a><br/>
                                - <a href="#" class="abo-register-link">Zeitungabo bestellen und gleichzeitig Profil anlegen</a><br/>
                                - <a href="javascript:newSubscriptionAnonymous({{ $gimme->article->id_gift }})">Nur Zeitungsabo bestellen</a>
                                </p>
                                <p style="margin-top: 0.3em;">Bis Mittwoch, 15 Uhr bestellt = am Freitag im Briefkasten</p>
                                <iframe id="iframe_{{ $gimme->article->id_gift }}" width="440" height="500" style="display: none; overflow-x: hidden;"></iframe>
                            </div>
                            {{ /if }}
                            </div>
                        </div>
                    </article>
                {{ /list_articles }}
                    <article>
                        <header>
                            <p>TagesWoche</p>
                        </header>
                        <h3>Unabhängige Berichterstattung aus Basel</h3>
                        <p><small>Mit einem Abonnement der TagesWoche entscheiden Sie sich für kritische und unabhängige Berichterstattung. Unsere Journalisten
                            gehen nah ran und schauen genau hin, damit die TagesWoche Ihnen jede Woche Reportagen, Analysen und Interviews aus der Region Basel
                            wie der ganzen Welt liefern kann.</small></p>
                    </article>
                </div>
            </section>

            <aside>
                <article>
                    <header>
                        <p>Aboservice</p>
                    </header>
                    <p>Sie können Ihr Abo natürlich auch per <a href="mailto:abo@tageswoche.ch">E-Mail</a> oder telefonisch bestellen. Montag bis Freitag, 8:30-12:30 und 13:30-17:30 Uhr.</p>
                    <p><strong>061 561 61 61</strong></p>
                </article>

                <article>
                    <header>
                        <p><b>Abo online verwalten</b></p>
                    </header>
                    <p>Adressänderung, Urlaubsunterbrechung, Umleitung</p>
                    <p><a href="{{ $view->url(['controller' => 'dashboard', 'action' => 'index'], 'default') }}">Zum Benutzerkonto</a></p>
                </article>

                <article>
                    <header>
                        <p><b>Bisherige Ausgaben</b></p>
                    </header>
                    <p>Machen Sie sich selber ein Bild von der TagesWoche und werfen Sie einen Blick in vergangene Ausgaben.</p>
                    <p><a href="http://www.tageswoche.ch/de/pages/about/105160/Zeitungsarchiv.htm">Zeitungsarchiv öffnen</a></p>
                </article>
            </aside>
        </div>
    </div>

    <div id="footer">
    {{ include file="_tpl/footer.tpl" }}
    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}

