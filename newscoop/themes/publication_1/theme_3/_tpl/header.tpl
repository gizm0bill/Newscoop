        <div class="content-box top-content-box clearfix">
{{* ONE LOCAL TO SUIT THEM ALL *}}        
{{ local }}    
            <div id="top" class="clearfix">
                <ul>
                    <li>{{ $smarty.now|camp_date_format:"%W %e.%m.%Y" }}</li>
                    <li>{{ weather }}</li>
                    <li><a href="#">Kontakt</a></li>
                    <li><a href="#">Login</a></li>
                </ul>
                <h1><a href="{{ set_publication identifier="1" }}{{ set_current_issue }}{{ url options="issue" }}">Tages Woche</a></h1>
            </div><!-- / Top -->
            <div id="main-nav" class="clearfix">
            	<a href="/" class="start">Startseite</a>
                <ul id="mobile-nav">
                    <li class="search"><a href="#">Search</a>
                    	<ul class="search-mobile">
                        	<li>
                                <form method="GET" action="{{ $view->url(['controller' => 'search', 'action' => 'index'], 'default') }}">
                                <input type="text" name="q" value="">
                                <input type="submit" value="Suchen" class="grey-button">
                                </form>
                            </li>
                        </ul>
                    </li>
                    <li class="settings"><a href="#">Settings</a></li>
                    <li class="login"><a href="#">Login</a>
                    	<ul>
                        	<li><a href="#">Profil bearbeiten</a></li>
                        	<li><a href="#">Meine Themen</a></li>
                        </ul>
                    </li>
                </ul>
                <nav>
                    <ul>

                        {{ set_publication identifier="1" }}
                        {{ set_current_issue }}
                        <li class="desktop-hide"><a href="{{ url options="issue" }}"{{ if $gimme->publication == $gimme->default_publication && $gimme->template->name == "front.tpl" }} class="active"{{ /if }}>Startseite</a></li>

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

{{* DIALOG *}}
{{ set_current_issue }}
{{ set_section number="80" }}
                        <li><a href="{{ url options="section" }}"{{ if ($gimme->section->number == $gimme->default_section->number) && ($gimme->template->name != "search.tpl") }} class="active"{{ /if }}>{{ $gimme->section->name }}</a></li>
                    </ul>
                    
                    <ul>
{{* DIALOG *}}
{{ set_current_issue }}
{{ set_section number="70" }}
                        <li><a href="{{ url options="section" }}"{{ if ((70 == $gimme->default_section->number) || (71 == $gimme->default_section->number) || (72 == $gimme->default_section->number)) && ($gimme->template->name != "search.tpl") }} class="active"{{ /if }}>Ausgehen</a></li>
                    </ul>
                </nav>

{{ /local }}

                {{* SEARCH BOX *}}                
                <form method="get" action="{{ $view->url(['controller' => 'search', 'action' => null], 'default') }}">
                <fieldset>
                    <input type="text" value="" name="q" placeholder="Suchbegriff, Webcode +awafa" />
                    <button>Go</button>
                </fieldset>
                </form>
            </div><!-- / Main Nav -->
            
        </div>
