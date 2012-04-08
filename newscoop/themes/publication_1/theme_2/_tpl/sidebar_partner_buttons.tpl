{{ if $gimme->template->name == "front.tpl" }}
{{ assign var="required_switch" value="Front_page" }}
{{ else }}
{{ assign var="required_switch" value=$gimme->section->name|strip }}
{{ /if }}
{{ list_articles ignore_issue="true" ignore_section="true" constraints="issue is 2 section is 5 partner_button is on $required_switch is on type is advertisment" }}
{{ if $gimme->current_list->at_beginning }}
              <article>
                  <header>
                      <p><b>TagesWoche</b> Partner</p>
                    </header>
                    <ul class="partner-list">
{{ /if }}                    
                      <li>
                          <a href="{{ $gimme->article->ad_link }}" target="_blank"><img src="{{ uri options="image 1" }}" alt="{{ $gimme->article->ad_link }}" /></a>
                        </li>

{{ if $gimme->current_list->at_end }}
                    </ul>
                </article>
{{ /if }}  
{{ /list_articles }}              
