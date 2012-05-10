{{extends file="layout.tpl"}}

{{block content_classes}}content-box clearfix{{/block}}

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
    
    $(".tabs").bind("tabsselect", function(e, tab) {
        console.log('qwe');
        if (tab.index == 2) {
            console.log('asd');
            $('#manage_subscription_box').html('<iframe src="https://abo.tageswoche.ch/dmpro?type=abo&mode=update&userkey={{ $userSubscriptionKey }}" width="634" height="600"></iframe>');
            console.log('zxc');
        }
    });
});

function newSubscriber(firstName, lastName, email, productId) {
    var url = 'https://abo.tageswoche.ch/dmpro?type=abo&mode=new&name=' + escape(lastName) + '&firstname=' + escape(firstName) + '&email=' + escape(email) + '&jscallback=afterRegistration&product=' + productId;
    document.getElementById('iframe_subs').src = url;
}
</script>

<section>
            	<div id="edit-profile-holder" class="tabs profile-edit">
                            
                    <ul class="profile-tab-nav">
                        <li><a href="#author-1">Mein Profil</a></li>
                        <li><a href="#author-2">Meine Themen</a></li>
                        <li><a href="#mein-abo">Mein Abo</a></li>
                    </ul>

        <div id="author-1" class="profile-edit-box">
            <form action="{{ $form->getAction() }}" method="{{ $form->getMethod() }}" enctype="multipart/form-data">
                <fieldset>
                    {{ if empty($subscriber) }}
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
                            <div class="info check">
                                <input type="checkbox" id="anzeigen-3" name="email_public" value="1" class="styled" {{ if !empty($user['email_public']) }}checked="checked"{{ /if }} />
                                <p>Andere Nutzer dürfen mir Nachrichten senden</p>
                            </div>
                        </li>
                        <li>
                            <dl>{{ $form->username->setLabel("Benutzername") }}</dl>
                            <div class="info"><p>Dieser Name wird bei Ihren Beiträgen auf tageswoche.ch angezeigt. Wir empfehlen, dass Sie Ihren echten Namen verwenden, erlauben aber auch Pseudonyme.</p></div>
                        </li>
                        <li><dl>{{ $form->password->setLabel("Passwort ändern")->setAttrib('placeholder', '******') }}</dl></li>
                        <li class="buttons">
                            <input type="submit" value="Speichern" class="grey-button" />
                        </li>
                    </ul>
                </fieldset>
                        
                <fieldset>
                    <h3>Profil</h3>
                    <p>Sämtliche nachfolgenden Angaben sind optional. Bitte beachten Sie, dass jene Angaben, die Sie ausfüllen, für alle in Ihrem Profil sichtbar sind und von Suchmaschinen gefunden werden können.</p>
                    <ul>
                        <li class="profile-image">
                            <img src="{{ include file="_tpl/user-image.tpl" user=$user width=125 height=125 }}" />
                            <div>
                                <dl>{{ $form->image->setLabel("Neues Profilbild hochladen") }}</dl>
                                <p>Bitte verwenden Sie keine Bilder, an denen Sie die Rechte nicht besitzenoder auf denen andere Personen als Sie selber abgebildet sind.</p>
                            </div>
                        </li>
                        <li><dl>{{ $form->attributes->bio->setLabel("Über mich")->setAttrib('placeholder', 'Lassen Sie die Community wissen, wer Sie sind und was Sie interessiert.') }}</dl></li>
                        <li>
                            <label>Geburtsdatum</label>
                            <div class="date">
                                <input type="text" value="Bitte auswählen" class="datepicker" value="{{ $user['birth_date'] }}" />
                            </div>
                        </li>
                        <li>
                            <label for="geschlecht">Geschlecht</label>
                            <select id="geschlecht" name="gender" class="cutom-dropdown" style="z-index:0;">
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
                            <input type="text" id="address" value="" class="search" />
                            <input type="submit" id="location-search" class="grey-button" value="Suchen" />
                        </li>
                        <li class="map">
                            <label id="remove-geolocation">Markierung entfernen</label>
                            <div id="map_canvas" class="map-holder" style="width:409px; height:180px"></div>
                        </li>
                        <li class="buttons">
                            <a href="{{ $view->url(['username' => $user->uname], 'user') }}" target="_blank" title="Profil ansehen" class="grey-button">Profil ansehen</a>
                            <input type="submit" value="Speichern" class="grey-button" />
                        </li>
                    </ul>

                    <p>Wenn Sie Ihr Profil löschen wollen, senden Sie bitte ein E-Mail<br />mit Ihrem Benutzernamen an <a href="mailto:abmelden@tageswoche.ch?subject=TagesWoche Community-Profil loeschen">abmelden@tageswoche.ch</a>.</p> 
                </fieldset>
            </form>
        </div>

        <div id="author-2" class="profile-edit-box">
            <h3>Meine Themen</h3>
                    <p class="simple-txt">
                    {{ foreach $user->topics as $id => $topic }}
                    {{ local }}{{ set_topic identifier=$id }}
                    <a href="{{ $view->url(['topic' => $topic], 'topic') }}">{{ $topic }}</a>
                    {{ /local }}
                    {{ /foreach }}
                    </p>

                    <p><a href="{{ $view->url([], 'my-topics') }}" title="Meine Themen">Neue Artikel zu diesen Themen lesen & Themen verwalten</a></p>
        </div>
        <div id="mein-abo" class="profile-edit-box" >
            {{ if !empty($subscriptionService) }}
                {{ if !empty($subscriber) }}
                    {{ if !empty($userSubscriptions) }}
                        Bestellte und verschenkte Abos:
                        <div id="manage_subscription_box"></div>
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
    {{ include file="_tpl/sidebar-community.tpl" }}

    {{ include file="_werbung/user-profile-sidebar.tpl" }}
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

    $('#remove-geolocation').click(function() {
        $('#geolocation').val('');
        marker.setVisible(false);
    });
});
</script>
{{/block}}
