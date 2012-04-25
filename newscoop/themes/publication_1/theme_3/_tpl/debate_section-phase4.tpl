                <div class="top-line clearfix">
                
                	<h3>Fazit</h3>
{{ list_articles length="1" constraints="type is deb_moderator" }}                    
                    	<article>
{{ list_article_authors }}                       	
                            <figure>
                            	<img alt="Portrait {{ $gimme->author->name }}" src="{{ $gimme->author->picture->imageurl }}" width="120" class="left" />
                            	<p><b>{{ $gimme->author->name }}</b></p>
                            	<p>{{ $gimme->article->position }}</p>
                            </figure>
{{ /list_article_authors }}                        	
                        	<p>{{ $gimme->article->announcement }}</p>
                        </article>
{{ /list_articles }}  
                
                </div>
