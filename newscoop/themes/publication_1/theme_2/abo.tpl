{{ include file="_tpl/_html-head.tpl" }}

<body>
        <div id="wrapper">

{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix">
    
{{ include file="_tpl/navigation_top.tpl" }}

            <div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

            </div>           

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
          <div id="abo-iframe">
                <section>
                    <article>
                        <header>
                            <p><b>TagesWoche</b> Abonnement</p>
                        </header>
                     </article>
                     
{{ list_articles ignore_issue="true" ignore_section="true" constraints="issue is 1 section is 20 type is subscription" }}                    
                    <article>
                        <figure>
                            <img src="{{ uri options="image 1 width 300 height 200 crop center" }}" alt="" />
                            <figcaption>{{ $gimme->article->image(1)->description }}</figcaption>
                        </figure>    
                        <h2 class="abo-title">{{ $gimme->article->name }}</h2>
                        <ul class="check-list">
                            {{ if $gimme->article->bullet_one }}<li>{{ $gimme->article->bullet_one }}</li>{{ /if }}
                            {{ if $gimme->article->bullet_two }}<li>{{ $gimme->article->bullet_two }}</li>{{ /if }}
                            {{ if $gimme->article->bullet_three }}<li>{{ $gimme->article->bullet_three }}</li>{{ /if }}
                        </ul>                          
<a href="#container_{{ $gimme->article->id_regular }}" class="side-green-box">
    <h3>Jetzt online bestellen</h3>
</a> 
{{ if $gimme->article->id_gift }}
<a href="#container_{{ $gimme->article->id_gift }}" class="side-green-box"> 
    <h3>Verschenken</h3> 
</a>
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
}
else {
  newSubscriber({{ $gimme->article->id_regular }}, '{{ $gimme->user->first_name }}', '{{ $gimme->user->last_name }}', '{{ $gimme->user->email }}');
}
</script>
</div>
{{ else }}
<div id="container_{{ $gimme->article->id_regular }}" class="popup-content" style="width: 440px; overflow-x: hidden;">
<a href="{{ $view->baseUrl('/auth') }}">Login</a><br>
<a href="{{ $view->baseUrl('/register') }}">Benutzerkonto anlegen</a><br>
<a href="javascript:newSubscriptionAnonymous({{ $gimme->article->id_regular }})">Abo bestellen (ohne Profil auf der Website)</a>
<p style="margin-top: 0.3em; font-family: sans-serif; font-size: 1.5em; color: red;">
Bis Mittwoch, 15:00 bestellen. <br>Freitags im Briefkasten.
</p>
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
}
else {
  newSubscriber({{ $gimme->article->id_gift }}, '{{ $gimme->user->first_name }}', '{{ $gimme->user->last_name }}', '{{ $gimme->user->email }}');
}
</script>
</div>

{{ else }}
<div id="container_{{ $gimme->article->id_gift }}" class="popup-content" style="width: 440px; overflow-x: hidden;">
<a href="{{ $view->baseUrl('/auth') }}">Login</a><br>
<a href="{{ $view->baseUrl('/register') }}">Benutzerkonto anlegen</a><br>
<a href="javascript:newSubscriptionAnonymous({{ $gimme->article->id_gift }})">Abo bestellen (ohne Profil auf der Website)</a>
<p style="margin-top: 0.3em; font-family: sans-serif; font-size: 1.5em; color: red;">
Bis Mittwoch, 15:00 bestellen. <br>Freitags im Briefkasten.
</p>
<iframe id="iframe_{{ $gimme->article->id_gift }}" width="440" height="500" style="display: none; overflow-x: hidden;"></iframe>
</div>
{{ /if }}
</div>
                    </article>
{{ /list_articles }}                    
                                        
                    <article>
                        <header>
                            <p><b>TagesWoche</b></p>
                        </header>
                        <h2>Unabhängige Berichterstattung aus Basel</h2>
                        <p>Mit einem Abonnement der TagesWoche entscheiden Sie sich für kritische und unabhängige Berichterstattung. Unsere Journalisten gehen nah ran und schauen genau hin, damit die TagesWoche Ihnen jede Woche Reportagen, Analysen und Interviews aus der Region Basel wie der ganzen Welt liefern kann.</p>
                    </article>
                
                </section>
                
            </div>
            <aside>
                <article>
                    <header>
                        <p>Aboservice</p>
                    </header>
                    <p>Sie können Ihr Abo natürlich auch telefonisch bestellen. Montag bis Freitag, 8:30-12:30 und 13:30-17:30 Uhr.</p>
                    <ul class="item-list padding-fix">
                        <li> 061 561 61 61</li>
                    </ul>
                </article>
                
                <article>
                    <header>
                        <p><b>Abo online verwalten</b></p>
                    </header>
                    <p>Adressänderung, Urlaubsunterbrechung, Umleitung</p>
                    <footer>
                        <a href="{{ $view->url(['controller' => 'dashboard', 'action' => 'index'], 'default') }}">Zum Benutzerkonto</a>
                    </footer>
                </article>

                <article>
                    <header>
                        <p><b>Bisherige Ausgaben</b></p>
                    </header>
                    <p>Machen Sie sich selber ein Bild von der TagesWoche und werfen Sie einen Blick in vergangene Ausgaben.</p>
                    <footer>
                        <a href="http://www.tageswoche.ch/de/pages/about/105160/Zeitungsarchiv.htm">Zeitungsarchiv öffnen</a>
                    </footer>
                </article>
                           
            </aside>
        
        </div>

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}
<link rel="stylesheet" href="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.css') }}" type="text/css" media="screen" />
</body>
</html>
