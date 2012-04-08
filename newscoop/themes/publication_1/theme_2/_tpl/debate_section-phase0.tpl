<!-- _tpl/debate_section-phase0.tpl -->

{{ include file="_tpl/debate_section_navigation.tpl" }}

      <div class="debatte-text thumb-articles debatte-border clearfix">
        <section>
                    <div class="two-columns clearfix">
                    
{{ list_articles length="2" constraints="type is deb_statement" }}                    
                        <article>
                          <div class="debatte-figure">
                          {{ list_article_authors }}
                                <figure>
                                    <a class="debata-img"{{ if $gimme->author->user->defined }} href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}"{{ /if }}><img alt="Portrait {{ $gimme->author->name }}" src="{{ $gimme->author->picture->imageurl }}" width="65"></a>
                                    <figcaption><a class="green-underline"{{ if $gimme->author->user->defined }} href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}"{{ /if }}>{{ $gimme->author->name }}</a> <p>{{ $gimme->article->position }}</p></figcaption>
                                </figure>
                            {{ /list_article_authors }}
                            </div>
                            <p><strong>{{ if $gimme->article->contra }}NEIN{{ else }}JA{{ /if }}</strong>{{ strip }}
&laquo;

           {{ if $wdphase == "1"}}{{$gimme->article->opening|strip_tags|trim|truncate:300:" [...] "}}{{ /if }}
           {{ if $wdphase == "2"}}{{$gimme->article->rebuttal|strip_tags|trim|truncate:300:" [...] "}}{{ /if }}
           {{ if $wdphase == "3"}}{{$gimme->article->closing|strip_tags|trim|truncate:300:" [...] "}}{{ /if }}
           {{ if $wdphase == "4"}}{{$gimme->article->closing|strip_tags|trim|truncate:300:" [...] "}}{{ /if }}
&raquo;
{{ /strip }}</p>
                            <p><a href="?stage=1#{{ if $gimme->article->contra }}contra{{ else }}pro{{ /if }}">Weiterlesen</a></p>
                        </article>
{{ /list_articles }}
                        
                  </div>

                    <div class="debata-tags">
                      Gehe zur: 
{{ if $wdphase > 0 }}<a href="?stage=1">{{ /if }}
Standpunkte
{{ if $wdphase > 0 }}</a>{{ /if }}
&nbsp;
{{ if $wdphase > 1 }}<a href="?stage=2">{{ /if }}
Entgegnung
{{ if $wdphase > 1 }}</a>{{ /if }}
&nbsp;
{{ if $wdphase > 2 }}<a href="?stage=3">{{ /if }}
Schlussworte
{{ if $wdphase > 2 }}</a>{{ /if }}
&nbsp;
{{ if $wdphase > 3 }}  <a href="?stage=4">{{ /if }}
Zusammenfassung
{{ if $wdphase > 3 }}</a>{{ /if }}
&nbsp;
                    </div>

        </section>

{{ list_articles length="1" constraints="type is deb_moderator" }}                
                <aside>
                  <div class="debatte-aside">            
                        <article>
                            <h2>&Uuml;ber diese Debatte</h2>
                            <p>{{ $gimme->article->teaser }}</p>
                            {{ list_article_authors }}
                            <span>{{ $gimme->author->name }}</span>
                            {{ /list_article_authors }}
                        </article>
                  </div>
              </aside>
{{ /list_articles }}
              
      </div>
