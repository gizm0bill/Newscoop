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
{{ local }}
{{* agenda *}}
{{ set_current_issue }}
{{ set_section number="70" }}
                <li id="nav_all" class="nav_one active"><a href="{{ uri options="section" }}">Alles</a></li>
{{* movies *}}
{{ set_current_issue }}
{{ set_section number="72" }}
                <li id="nav_kino" class="nav_one"><a href="{{ uri options="section" }}">Kino</a></li>
{{* events *}}
{{ set_current_issue }}
{{ set_section number="71" }}
                <li id="nav_theater" class="nav_one"><a href="{{ uri options="section" }}#/;type:theater" onClick="return load_events('theater');">Theater</a></li>
                <li id="nav_musik" class="nav_one"><a href="{{ uri options="section" }}#/;type:musik" onClick="return load_events('musik');">Konzerte</a></li>
                <li id="nav_party" class="nav_one"><a href="{{ uri options="section" }}#/;type:party" onClick="return load_events('party');">Partys</a></li>
                <li id="nav_ausstellung" class="nav_one"><a href="{{ uri options="section" }}#/;type:ausstellung" onClick="return load_events('ausstellung');">Ausstellungen</a></li>
                <li id="nav_andere" class="nav_one"><a href="{{ uri options="section" }}#/;type:andere" onClick="return load_events('andere');">Andere</a></li>
{{*
                <!--<li id="nav_restaurants" class="nav_one"><a href="{{ uri options="section" }}restaurants/">Restaurants</a></li>-->
*}}
            </ul>
{{ /local }}
        
        </div>
