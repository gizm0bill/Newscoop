<!-- _tpl/debate_section-phase3.tpl -->

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
                            <p><strong>{{ if $gimme->article->contra }}NEIN{{ else }}JA{{ /if }}</strong> &laquo;{{$gimme->article->closing|strip_tags|trim|truncate:300:""}}
                              {{ if $gimme->article->contra }}[<a href="#contra">...</a>]
                              {{ else }}[<a href="#pro">...</a>]
                              {{ /if }}
                              &raquo;
                            </p>
                        </article>
{{ /list_articles }}

                  </div>
                    
{{ list_articles length="1" constraints="type is deb_statement contra is off" }} 
                    <article>        
<a name="pro"></a>        
                    <div class="debata-tags">
                      Zum Text: <a href="#pro">Pro</a> <a href="#contra">Contra</a>
                    </div>          
                        <header>
                            <p>Ja</p>
                        </header>
                    </article>
                    <article>
                        <div class="debatte-figure">
                            {{ list_article_authors }}
                            <figure>
                                <a class="debata-img" href="{{ if $gimme->author->user->defined }}{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}{{ else }}#{{ /if }}"><img alt="Portrait {{ $gimme->author->name }}" src="{{ $gimme->author->picture->imageurl }}" width="65"></a>
                                <figcaption>
                                    <a class="green-underline" href="{{ if $gimme->author->user->defined }}{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}{{ else }}#{{ /if }}">{{ $gimme->author->name }}</a>
                                    <p>{{ $gimme->article->position }}</p>
                                </figcaption>
                            </figure>
                            {{ /list_article_authors }}
                        </div>
                        <h2>{{ $gimme->article->name }}</h2>
                        <p>{{ $gimme->article->closing }}</p>
                        <p><a href="javascript:omnibox.showHide()">Kommentieren</a></p>
                    </article>
{{ /list_articles }}   
{{ list_articles length="1" constraints="type is deb_statement contra is on" }}   
                    <article>       
<a name="contra"></a>        
                    <div class="debata-tags">
                      Zum Text: <a href="#pro">Pro</a> <a href="#contra">Contra</a>
                    </div>      
                        <header>
                            <p>Nein</p>
                        </header>
                    </article>
                    <article>
                        <div class="debatte-figure">
                            {{ list_article_authors }}
                            <figure>
                                <a class="debata-img" href="{{ if $gimme->author->user->defined }}{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}{{ else }}#{{ /if }}"><img alt="Portrait {{ $gimme->author->name }}" src="{{ $gimme->author->picture->imageurl }}" width="65"></a>
                                <figcaption>
                                    <a class="green-underline" href="{{ if $gimme->author->user->defined }}{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}{{ else }}#{{ /if }}">{{ $gimme->author->name }}</a>
                                    <p>{{ $gimme->article->position }}</p>
                                </figcaption>
                            </figure>
                            {{ /list_article_authors }}
                        </div>
                        <h2>{{ $gimme->article->name }}</h2>
                        <p>{{ $gimme->article->closing }}</p>
                        <p><a href="javascript:omnibox.showHide()">Kommentieren</a></p>
                    </article>
{{ /list_articles }}
                    <div class="debata-tags">
                      Zum Text: <a href="#pro">Pro</a> <a href="#contra">Contra</a>
                    </div>       
                </section>
                
                <aside>
                    <div class="debatte-aside">
{{ include file="_tpl/debate_section_voting.tpl" }}

{{ include file="_tpl/debate_section_comments.tpl" }}
                    </div>
                </aside>
                       
      </div>
