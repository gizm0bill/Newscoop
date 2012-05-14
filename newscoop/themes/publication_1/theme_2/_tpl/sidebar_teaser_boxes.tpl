{{ if $gimme->template->name == "front.tpl" }}
{{ assign var="required_switch" value="Front_page" }}
{{ else }}
{{ assign var="required_switch" value=$gimme->section->name|strip }}
{{ /if }}
{{ list_articles ignore_issue="true" ignore_section="true" constraints="issue is 2 section is 15 $required_switch is on" }}
{{ if $gimme->current_list->at_beginning }}
              <article>
                  <header>
                      <p>Werbung</p>
                    </header>
                    <ul class="item-list image-list">
{{ /if }}                    
                      <li>
                          <a href="{{ $gimme->article->ad_link }}"><img src="{{ uri options="image 1 width 87" }}" alt="" /></a>
                          {{ $gimme->article->teaser_text|strip_tags }}<br />
                          <a href="{{ $gimme->article->ad_link }}">{{ $gimme->article->name }}</a>
                        </li>
{{ if $gimme->current_list->at_end }}
                    </ul>
                </article>
{{ /if }}  
{{ /list_articles }}              
