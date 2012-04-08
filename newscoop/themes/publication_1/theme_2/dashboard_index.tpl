{{extends file="layout.tpl"}}

{{block content}}
<script type="text/javascript">
$(document).ready(function(){
    $("a.side-green-box").fancybox({
        'hideOnContentClick': false,
        'transitionIn'  : 'elastic',
        'transitionOut' : 'elastic',
        'speedIn'   : 600, 
        'speedOut'    : 200, 
        'overlayShow' : false        
      });
});

function newSubscriber(firstName, lastName, email, productId) {
    var url = 'https://abo.tageswoche.ch/dmpro?type=abo&mode=new&name=' + escape(lastName) + '&firstname=' + escape(firstName) + '&email=' + escape(email) + '&jscallback=afterRegistration&product=' + productId;
    document.getElementById('iframe_subs').src = url;
}
</script>

<section>
    <div id="edit-profile-holder">
        <ul class="tab-nav">
            <li><a href="#tab-1" class="button">Mein Profil</a></li>
            <li><a href="#tab-4" id="meinAbo" class="button">Mein Abo</a></li>
        </ul>
        <div id="tab-1" class="edit-profile-tab">
            <form action="{{ $form->getAction() }}" method="{{ $form->getMethod() }}" enctype="multipart/form-data">
                <fieldset>
                    {{ if !$subscriber }}
                        <div class="gift-box">
                            <p>Willkommen in der TagesWoche-Community. Erzählen Sie uns ein bisschen was über sich.<br />Das Profil ist Ihre Visitenkarte auf tageswoche.ch.<br /> 
                            Wenn Sie Ihr Profil ausgefüllt haben, schenken wir Ihnen ein Schnupperabo der gedruckten TagesWoche.</p>
                            <a href="#container_subs" class="side-green-box">Zwei Ausgaben geschenkt</a>
                            <div style="display: none;">
                                <div id="container_subs">
                                    <p style="margin-top: 0.3em; font-family: sans-serif; font-size: 1.5em; color: red;">Bis Mittwoch, 15:00 bestellen. <br>Freitags im Briefkasten.</p>
                                    <iframe id="iframe_subs" width="600" height="500" src=""></iframe>
                                    <script>newSubscriber('{{ $user_first_name }}', '{{ $user_last_name }}', '{{ $user_email }}', 19);</script>
                                </div>
                            </div>
                        </div>
                    {{ /if }}
                    
                    <h3>Login</h3>
                    <ul>
                        <li><dl>{{ $form->first_name->setLabel("Vorname") }}</dl></li>
                        <li><dl>{{ $form->last_name->setLabel("Nachname") }}</dl></li>
                        <li>
                            <label for="email">Email</label>
                            <input type="text" id="email" readonly="readonly" value="{{ $user->email }}" />
                            <span class="radio-placeholder">
                                <input type="checkbox" id="anzeigen-3" name="email_public" value="1" class="styled" {{ if !empty($user['email_public']) }}checked="checked"{{ /if }} />
                                <label for="anzeigen-3">E-Mails anderer User empfangen</label>
                            </span>
                        </li>
                        <li>
                            <dl>{{ $form->username->setLabel("Benutzername") }}</dl>
                            <span class="input-info">Dieser Name wird bei Ihren Beiträgen auf tageswoche.ch angezeigt. Wir empfehlen, dass Sie Ihren echten Namen verwenden, erlauben aber auch Pseudonyme.</span>
                        </li>
                        <li><dl>{{ $form->password->setLabel("Passwort ändern") }}</dl></li>
                    </ul>
                    <span class="footer-div form-buttons right"><button class="button">Sichern</button></span>
                </fieldset>
                        
                <fieldset>
                    <h3>Profil <img src="{{ include file="_tpl/user-image.tpl" user=$user width=35 height=35 }}" /> <small><a href="{{ $view->url(['username' => $user->uname], 'user') }}">Vorschau</a></small></h3>
                    <small>Sämtliche nachfolgenden Angaben sind optional. Bitte beachten Sie, dass jene Angaben, die Sie ausfüllen, für alle in Ihrem Profil sichtbar sind und von Suchmaschinen gefunden werden können.</small>
                    <ul>
                        <li><dl>{{ $form->attributes->bio->setLabel("Über mich") }}</dl></li>
                        <li>
                            <dl>{{ $form->image->setLabel("Profilbild") }}</dl>
                            <span class="input-info">Keine Bilder, an denen Sie die Rechte nicht besitzen oder die andere Personen als Sie selber abbilden.</span>
                        </li>
                        <li><dl>{{ $form->attributes->birth_date->setLabel("Geburtsdatum") }}</dl></li>
                        <li>
                            <label for="geschlecht">Geschlecht</label>
                            <select id="geschlecht" name="gender" style="z-index:0;">
                                <option value="">Bitte auswählen</option>
                                <option value="male" {{ if !empty($user['gender']) && $user['gender'] == 'male' }}selected="selected"{{ /if }}>Mann</option>
                                <option value="female" {{ if !empty($user['gender']) && $user['gender'] == 'female' }}selected="selected"{{ /if }}>Frau</option>
                            </select>
                        </li>
                        <li><dl>{{ $form->attributes->facebook->setLabel("facebook.com/") }}</dl></li>
                        <li><dl>{{ $form->attributes->google->setLabel("plus.google.com/") }}</dl></li>
                        <li><dl>{{ $form->attributes->twitter->setLabel("twitter.com/") }}</dl></li>
                        <li><dl>{{ $form->attributes->website->setLabel("http://") }}</dl></li>
                        <li><dl>{{ $form->attributes->organisation->setLabel("Firma") }}</dl></li>
                        <li>
                            <dl>{{ $form->attributes->geolocation->setLabel("Aktueller Wohnort") }}</dl>
                            <input type="text" id="address" value="" />
                            <button id="location-search" class="button">Suchen</button>
                        </li>
                        <li class="map-placeholder">
                            <span id="remove-geolocation">Markierung entfernen.</span>
                            <div id="map_canvas" style="width: 100%; height: 200px"></div>
                        </li>
                    </ul>
                    <!--<div class="form-buttons right"><button class="button">Speichern</button></div>//-->
                    <div class="form-buttons right"><input type="submit" class="button" value="Speichern" /></div>
                </fieldset>
            </form>
        </div>
        <div id="tab-4" style="display: none; font: 11px Arial, Helvetics, sans-serif; color: #333333; line-height: 16px;">
            <script>
                function newSubscription(userSubscriptionKey, productId) {
                    var container = document.getElementById('new_subscription_box');
                    var url = 'https://abo.tageswoche.ch/dmpro?type=abo&mode=new&userkey=' + userSubscriptionKey + '&product=' + productId;
                    container.innerHTML = '<iframe src="'+url+'" width="600" height="300">';
                }
            </script>
            {{ if $subscriptionService }}
                {{ if $subscriber }}
                    {{ if $userSubscriptions }}
                        Bestellte und verschenkte Abos:
                        <div id="manage_subscription_box"></div>
                        <script>
                        $('#meinAbo').click(function() {
                            $('#manage_subscription_box').html('<iframe src="https://abo.tageswoche.ch/dmpro?type=abo&mode=update&userkey={{ $userSubscriptionKey }}" width="634" height="600"></iframe>');
                        });
                        </script>
                    {{ else }}
                        Sie haben noch kein Abo der TagesWoche.
                    {{ /if }}
                {{ /if }}
                <br><a href="{{ url options="root_level" }}de/pages/abos"> Abo bestellen</a>

            {{ else }}
                <br>Der Aboshop ist aufgrund von Wartungsarbeiten derzeit nicht verfügbar. Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.
            {{ /if }}
        </div>
    </div>
</section>
            
            <aside>

            {{ include file="_tpl/community_activitystream.tpl" }}
            
                <article>
                    <header>
                        <p>Meine Themen</p>
                    </header>
                    <p class="simple-txt">
                    {{ foreach $user->topics as $id => $topic }}
                    {{ local }}{{ set_topic identifier=$id }}
                    <a href="{{ uri options="template section_topic.tpl" }}">{{ $topic }}</a>
                    {{ /local }}
                    {{ /foreach }}
                    </p>
                    <footer>
                    <a href="{{ uri options="template section_my_topics.tpl" }}" title="Meine Themen">Themen verwalten</a>
                    </footer>
                </article>
                
                <article> 
                    <header> 
                        <p>Profil löschen?</p> 
                    </header> 
                    <p class="simple-txt">Wenn Sie Ihr Profil löschen wollen, senden Sie bitte ein E-Mail mit Ihrem Benutzernamen an 
                    <a href="mailto:abmelden@tageswoche.ch?subject=TagesWoche Community-Profil loeschen">abmelden@tageswoche.ch</a>.</p> 
                    <footer> 
                    </footer> 
                </article>
            
                
            </aside>

<script>
var geocoder;
var map;
var marker;

function initialize() {
    var latLng = new google.maps.LatLng(47.557421, 7.5925727);
    var myOptions = {
        zoom: 12,
        center: latLng,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        streetViewControl: false,
        mapTypeControl: false
    }

    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    geocoder = new google.maps.Geocoder();

    var geolocation = document.getElementById('geolocation').value;
    var markerPosition = map.getCenter();
    if (geolocation) {
        var lat = geolocation.split(",")[0];
        var lng = geolocation.split(",")[1];
        var latLng = new google.maps.LatLng(lat, lng);

        markerPosition = latLng;
        map.panTo(latLng);
    }

    marker = new google.maps.Marker({
        position: markerPosition,
        map: map,
        draggable: true,
        visible: document.getElementById('geolocation').value.length > 0
    });

    google.maps.event.addListener(marker, 'position_changed', function() {
        marker.setVisible(true);
        var latLng = marker.getPosition();
        document.getElementById("geolocation").value = latLng.lat() + ', ' + latLng.lng();
    });
}

function loadScript() {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize";
    document.body.appendChild(script);
}

$(document).ready(function() {

loadScript();

$('#birth_date').datepicker({
    showOn: "button",
    buttonImage: "{{ url static_file='_css/tw2011/img/calendar.png' }}",
    buttonImageOnly: true,
    changeYear: true,
    yearRange: '1911:2001',
    dateFormat: 'dd.mm.yy'
});

$('#location-search').click(function() {
    var address = $('#address').attr('value');
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        marker.setPosition(results[0].geometry.location);
      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });

    return false;
});

$('#geolocation').hide();

$('#bio').keydown(function(e) {
    if (e.keyCode == '46' || e.keyCode == '8' || e.keyCode == '37' || e.keyCode == '38' || e.keyCode == '39' || e.keyCode == '40') {
        return;
    }

    var value = $(this).attr('value');
    if (value.length >= 150) {
        return false;
    }
});

$('#password').attr('placeholder', '******');
$('#bio').attr('placeholder', 'Lassen Sie die Community wissen, wer Sie sind und was Sie interessiert.');

$('#remove-geolocation').click(function() {
    $('#geolocation').val('');
    marker.setVisible(false);
});

});
</script>
{{ include file="_tpl/_footer_javascript.tpl" }}
<link rel="stylesheet" href="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.css') }}" type="text/css" media="screen" />
{{/block}}
