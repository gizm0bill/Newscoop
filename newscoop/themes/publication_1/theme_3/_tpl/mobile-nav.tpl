<select id="mobile-nav-box" class="start">
                        {{ set_publication identifier="1" }}
                        {{ set_current_issue }}
                        <option value="{{ url options="issue" }}"{{ if $gimme->publication == $gimme->default_publication && $gimme->template->name == "front.tpl" }} selected{{ /if }}>Startseite</option>

{{* STANDARD SECTIONS *}}
{{ set_publication identifier="1" }}
{{ set_current_issue }}
{{ list_sections constraints="number smaller_equal 60" }}                    
                        <option value="{{ url options="section" }}"{{ if ($gimme->section->number == $gimme->default_section->number) && ($gimme->template->name != "search.tpl") }} selected{{ /if }}>{{ $gimme->section->name }}</option>
{{ /list_sections }}
                    
{{* BLOGS *}}                    
{{ set_publication identifier="5" }} 
{{ set_current_issue }}                   
                        <option value="{{ url options="issue" }}"{{ if ($gimme->publication == $gimme->default_publication) && ($gimme->template->name != "search.tpl")  }} selected{{ /if }}>{{ $gimme->publication->name }}</option>

{{* DOSSIERS *}}
{{ set_publication identifier="1" }}
{{ set_issue number="1" }}
{{ set_section number="5" }}                        
                        <option value="{{ url options="section" }}"{{ if ($gimme->issue->number == 1) && ($gimme->section == $gimme->default_section) && ($gimme->template->name != "search.tpl")  }} selected{{ /if }}>{{ $gimme->section->name }}</option>

{{* DIALOG *}}
{{ set_current_issue }}
{{ set_section number="80" }}
                        <option value="{{ url options="section" }}"{{ if ($gimme->section->number == $gimme->default_section->number) && ($gimme->template->name != "search.tpl") }} selected{{ /if }}>{{ $gimme->section->name }}</option>

{{* DEBATE *}}
{{ set_current_issue }}
{{ set_section number="81" }}
                        <option value="{{ url options="section" }}"{{ if ($gimme->section->number == $gimme->default_section->number) && ($gimme->template->name != "search.tpl") }} selected{{ /if }}>{{ $gimme->section->name }}</option>
{{* DIALOG *}}
{{ set_current_issue }}
{{ set_section number="70" }}
                        <option value="{{ url options="section" }}"{{ if ((70 == $gimme->default_section->number) || (71 == $gimme->default_section->number) || (72 == $gimme->default_section->number)) && ($gimme->template->name != "search.tpl") }} selected{{ /if }}>Ausgehen</option>
</select>
