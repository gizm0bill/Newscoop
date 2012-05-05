		<div class="footer-holder">
            <ul>
                <li>
                    <h4>TagesWoche</h4>
                    <ul>
{{ local }}                    
{{ set_publication identifier="1" }}
            {{ unset_topic }}
            {{ list_articles ignore_issue="true" ignore_section="true" constraints="issue is 1 section is 10 type is static_page number not 3919" }}
            {{ if $gimme->current_list->index == 2 }}
            				<li><a href="/user/editors">Redaktion</a></li>        
            {{ /if }}            
								<li><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
				{{ /list_articles }}   				                     
                    </ul>
                </li>
                
                <li>
                    <h4>Dialog</h4>
                    <ul>
                       	<li><a href="{{ set_publication identifier="1" }}{{ set_current_issue }}{{ set_section number="80" }}{{ url options="section" }}">Kommentare</a></li> 
								<li><a href="/user">Community</a></li> 
								<li><a href="{{ set_section number="81" }}{{ url options="section" }}">Wochendebatte</a></li>
								{{ set_article number="3919" }} 
								<li><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>                         
                    </ul>
                </li>
                
                <li>
                    <h4>Themen</h4>
                    <ul>
                        <li><a href="/dashboard">Meine Themen</a></li>
								{{ set_current_issue }}
								{{ list_sections constraints="number smaller_equal 60" }}                        
                        <li><a href="{{ url options="section" }}">{{ $gimme->section->name }}</a></li>
                        {{ /list_sections }}
                        {{ set_issue number="1" }}
                        {{ set_section number="5" }}
                        <li><a href="{{ url options="section" }}">Dossiers</a></li>
                        <li><a href="/omniticker">Alle Nachrichten</a></li>
                    </ul>
                </li>
                
                <li>
{{* agenda *}}
{{ set_publication identifier="1" }}
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
{{ list_articles ignore_publication="true" ignore_issue="true" ignore_section="true" order="byName asc" constraints="type is bloginfo active is on" }}                    
                        <li><a href="{{ url options="section" }}">{{ $gimme->article->name }}</a></li>
{{ /list_articles }}
                    </ul>
                </li>
                <li>
                    <h4>Folgen Sie uns</h4>
                    <ul class="social">
                        <li class="fb"><a href="https://www.facebook.com/tageswoche" target="_blank">Facebook</a></li>
                        <li class="tw"><a href="https://twitter.com/#!/tageswoche" target="_blank">Twitter</a></li>
                        <li class="yt"><a href="http://www.youtube.com/user/tageswoche" target="_blank">YouTube</a></li>
                        <li class="sc"><a href="http://soundcloud.com/tageswoche" target="_blank">Soundcloud</a></li>
                    </ul>
                </li>
            </ul>
            <p class="footer-text">All rights reserved</p>
        </div>
