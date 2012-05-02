        <div class="top-line clearfix">
                
                	<h3>Standpunkte</h3>
                    
                    <div class="two-columns">
                    
{{ list_articles length="2" constraints="type is deb_statement" }}                    
                    	<article>
{{ list_article_authors }}                       	
                            <figure>
                            	<img alt="Portrait {{ $gimme->author->name }}" src="{{ $gimme->author->picture->imageurl }}" width="120" class="left" />
                                <h4>{{ if $gimme->article->contra }}NEIN{{ else }}JA{{ /if }}</h4>
                            	<p>{{ $gimme->author->name }}, {{ $gimme->article->position }}</p>
                            </figure>
{{ /list_article_authors }}
                        	<p>{{ $gimme->article->opening }}</p>                        
                        </article>
{{ /list_articles }}                        
                    
                    </div>                
                </div>