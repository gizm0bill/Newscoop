<!-- _tpl/debate_section-phase2.tpl -->

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
                            <p><strong>{{ if $gimme->article->contra }}NEIN{{ else }}JA{{ /if }}</strong> {{ $gimme->article->rebuttal }}</p>
                            <p><a href="javascript:omnibox.showHide()">Kommentieren</a></p>
                        </article>

{{ /list_articles }}                        
                  </div>
                </section>

                <aside>
                    <div class="debatte-aside">

{{ include file="_tpl/debate_section_voting.tpl" }}

{{ include file="_tpl/debate_section_comments.tpl" }}

                    </div>
                </aside>
                       
      </div>
