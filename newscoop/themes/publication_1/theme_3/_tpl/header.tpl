        <div class="content-box top-content-box clearfix">
{{* ONE LOCAL TO SUIT THEM ALL *}}        
{{ local }}    
            <div id="top" class="clearfix">
                <ul>
                    <li>Freitag 13.02.2011</li>
                    <li><img src="{{ url static_file="pictures/icon-weather-sunny.png" }}" alt=""> 5°C Basel</li>
                    <li><a href="#">Kontakt</a></li>
                    <li><a href="#">Login</a></li>
                </ul>
                <h1><a href="{{ set_publication identifier="1" }}{{ set_current_issue }}{{ url options="issue" }}">Tages Woche</a></h1>
            </div><!-- / Top -->
            <div id="main-nav" class="clearfix">
                <nav>
                    <ul>

{{* STANDARD SECTIONS *}}
{{ set_publication identifier="1" }}
{{ set_current_issue }}
{{ list_sections constraints="number smaller_equal 60" }}                    
                        <li><a href="{{ url options="section" }}"{{ if ($gimme->section->number == $gimme->default_section->number) && ($gimme->template->name != "search.tpl") }} class="active"{{ /if }}>{{ $gimme->section->name }}</a></li>
{{ /list_sections }}

                    </ul>
                    <ul>
                    
{{* BLOGS *}}                    
{{ set_publication identifier="5" }} 
{{ set_current_issue }}                   
                        <li><a href="{{ url options="issue" }}"{{ if ($gimme->publication == $gimme->default_publication) && ($gimme->template->name != "search.tpl")  }} class="active"{{ /if }}>{{ $gimme->publication->name }}</a></li>

{{* DOSSIERS *}}
{{ set_publication identifier="1" }}
{{ set_issue number="1" }}
{{ set_section number="5" }}                        
                        <li><a href="{{ url options="section" }}"{{ if ($gimme->issue->number == 1) && ($gimme->section == $gimme->default_section) && ($gimme->template->name != "search.tpl")  }} class="active"{{ /if }}>{{ $gimme->section->name }}</a></li>

                        <li><a href="#">Dialog</a></li>
                    </ul>
                    <ul>
                        <li><a href="#">Ausgehen</a></li>
                    </ul>
                </nav>

{{ /local }}

{{* SEARCH BOX *}}                
                <fieldset>
{{ search_form template="search.tpl" submit_button="&nbsp;" button_html_code="style=\"display: none\""  html_code="onclick=\"return asSubmit();\"" }}
    {{ camp_edit object="search" attribute="keywords" html_code="id=\"search-field\" placeholder=\"Webcode, Stichworte\"" }}
    <button>Go</button>
    <input type="hidden" name="f_search_articles" />
    <input type="hidden" name="f_search_level" value="0" />
{{ /search_form }}                    
                </fieldset>
                
            </div><!-- / Main Nav -->
            
        </div>