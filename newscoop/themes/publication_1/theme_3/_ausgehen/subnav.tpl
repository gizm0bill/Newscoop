        <div class="content-box agenda-top">
        
            <a href="#" id="date_picker_button_new" class="trigger grey-button arrow">Heute, 7.3.</a>
            <div id="top-calendar" class="clearfix">
            
                <ul class="left">
                    <li><a href="#">Morgen</a></li>
                    <li><a href="#">nächste 7 T.</a></li>
                    <li>
                        <fieldset>
                            <input type="text" />
                            <span>bis</span>
                            <input type="text" />
                        </fieldset>
                    </li>
                    <li>
                        <input type="submit" value="Fertig" class="button" />
                    </li>
                </ul>
            
                <div id="agenda-datepicker"></div>
            
            </div>
            
            <ul class="nav">
                <li id="nav_all" class="nav_one active"><a href="{{ uri options="issue" }}agenda/">Alles</a></li>
                <li id="nav_kino" class="nav_one"><a href="{{ uri options="issue" }}kinos/">Kino</a></li>
                <li id="nav_theater" class="nav_one"><a href="{{ uri options="issue" }}events/#/;type:theater" onClick="return load_events('theater');">Theater</a></li>
                <li id="nav_musik" class="nav_one"><a href="{{ uri options="issue" }}events/#/;type:musik" onClick="return load_events('musik');">Konzerte</a></li>
                <li id="nav_party" class="nav_one"><a href="{{ uri options="issue" }}events/#/;type:party" onClick="return load_events('party');">Partys</a></li>
                <li id="nav_ausstellung" class="nav_one"><a href="{{ uri options="issue" }}events/#/;type:ausstellung" onClick="return load_events('ausstellung');">Ausstellungen</a></li>
                <li id="nav_andere" class="nav_one"><a href="{{ uri options="issue" }}events/#/;type:andere" onClick="return load_events('andere');">Andere</a></li>
                <!--<li id="nav_restaurants" class="nav_one"><a href="{{ uri options="issue" }}restaurants/">Restaurants</a></li>-->
            </ul>
        
        </div>