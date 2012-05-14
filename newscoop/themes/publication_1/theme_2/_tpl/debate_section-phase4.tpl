<!-- _tpl/debate_section-phase4.tpl -->

{{ include file="_tpl/debate_section_navigation.tpl" }}

      <div class="debatte-text thumb-articles debatte-border clearfix">
            
        <section>

{{ list_articles length="1" constraints="type is deb_moderator" }}         
                    <article>
                        <header>
                            <p>Die Moderation</p>
                        </header>
                    </article>
                    <article>
                        <div class="debatte-figure">
                            {{ list_article_authors }}
                            <figure>
                                <a class="debata-img"{{ if $gimme->author->user->defined }} href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}"{{ /if }}><img alt="Portrait {{ $gimme->author->name }}" src="{{ $gimme->author->picture->imageurl }}" width="65"></a>
                                <figcaption>
                                    <a class="green-underline"{{ if $gimme->author->user->defined }} href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}"{{ /if }}>{{ $gimme->author->name }}</a>, Moderator der Debatte
                                    <p>{{ $gimme->article->position }}</p>
                                </figcaption>
                            </figure>
                            {{ /list_article_authors }}
                        </div>
                        <h2>Fazit</h2>
                        <p>{{ $gimme->article->announcement }}</p>
                    </article>
{{ /list_articles }}                    
                </section>
                
                <aside>
                    <div class="debatte-aside">
{{ include file="_tpl/debate_section_voting.tpl" }}

{{ include file="_tpl/debate_section_comments.tpl" }}
                    </div>
                </aside>
                       
      </div>
