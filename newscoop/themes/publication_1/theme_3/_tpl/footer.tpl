		<div class="footer-holder">
            <ul>
                <li>
                    <h4>TagesWoche</h4>
                    <ul>
                        <li><a href="#">Über uns</a></li>
                        <li><a href="#">Dialogkultur</a></li>
                        <li><a href="#">Kontakt</a></li>
                        <li><a href="#">Werbung</a></li>
                        <li><a href="#">Impressum</a></li>
                        <li><a href="#">Zeitungsarchiv</a></li>
                        <li><a href="#">RSS-Feeds</a></li>
                        <li><a href="#">Press Corner</a></li>
                        <li><a href="#">AGB</a></li>
                        <li><a href="#">Abos</a></li>
                    </ul>
                </li>
                <li>
                    <h4>Dialog</h4>
                    <ul>
                        <li><a href="#">Kommentare</a></li>
                        <li><a href="#">Nutzersuche</a></li>
                        <li><a href="#">Storyboard</a></li>
                        <li><a href="#">Wochendebatte</a></li>
                    </ul>
                </li>
                <li>
                    <h4>Themen</h4>
                    <ul>
                        <li><a href="#">Meine Themen</a></li>
                        <li><a href="#">Basel</a></li>
                        <li><a href="#">Schweiz</a></li>
                        <li><a href="#">International</a></li>
                        <li><a href="#">Sport</a></li>
                        <li><a href="#">Kultur</a></li>
                        <li><a href="#">Leben</a></li>
                        <li><a href="#">Dossiers</a></li>
                        <li><a href="#">Alle Nachrichten</a></li>
                    </ul>
                </li>
                <li>
{{ local }}
{{* agenda *}}
{{ set_current_issue }}
{{ set_section number="70" }}
                    <h4><a href="{{ uri options="section" }}#/;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt">Ausgehen</a></h4>
                    <ul>
{{*
                        <li><a href="#">Veranstaltungen</a></li>
*}}
{{* movies *}}
{{ set_current_issue }}
{{ set_section number="72" }}
                        <li><a href="{{ uri options="section" }}#/;type:kino;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt">Kino</a></li>
{{* events *}}
{{ set_current_issue }}
{{ set_section number="71" }}
                        <li><a href="{{ uri options="section" }}#/;type:theater;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt;page:1">Theater</a></li>
                        <li><a href="{{ uri options="section" }}#/;type:musik;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt;page:1">Konzerte</a></li>
                        <li><a href="{{ uri options="section" }}#/;type:party;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt;page:1">Partys</a></li>
                        <li><a href="{{ uri options="section" }}#/;type:ausstellung;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt;page:1">Ausstellungen</a></li>
                        <li><a href="{{ uri options="section" }}#/;type:andere;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt;page:1">Andere</a></li>
{{*
                <!--<li id="nav_restaurants" class="nav_one"><a href="{{ uri options="section" }}restaurants/">Restaurants</a></li>-->
*}}
                    </ul>
{{ /local }}
                </li>
                <li>
                    <h4>Blogs</h4>
                    <ul>
                        <li><a href="#">Bildstoff</a></li>
                        <li><a href="#">FF-Blog</a></li>
                        <li><a href="#">Doppelspitze</a></li>
                        <li><a href="#">Bohnenkult</a></li>
                        <li><a href="#">Kulturschocker</a></li>
                        <li><a href="#">Habenmuss</a></li>
                        <li><a href="#">Lichtspiele</a></li>
                        <li><a href="#">Listomania</a></li>
                        <li><a href="#">Mittendrin</a></li>
                    </ul>
                </li>
                <li>
                    <h4>Folgen Sie uns</h4>
                    <ul class="social">
                        <li class="fb"><a href="#">Facebook</a></li>
                        <li class="tw"><a href="#">Twitter</a></li>
                        <li class="yt"><a href="#">YouTube</a></li>
                        <li class="sc"><a href="#">Soundcloud</a></li>
                    </ul>
                </li>
            </ul>
            <p class="footer-text">All rights reserved</p>
        </div>
        
    </div><!-- / Footer -->
