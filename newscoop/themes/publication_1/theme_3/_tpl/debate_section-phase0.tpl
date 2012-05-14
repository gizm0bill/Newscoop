                <div class="clearfix">
                    
                    <div class="two-columns">
                    
                    	<article class="top-line">

{{ list_articles length="1" constraints="type is deb_moderator" }}                        
                        	<h3>Das Thema</h3>
                            <p>{{ $gimme->article->teaser }}</p>
                        </article>
{{ /list_articles }}
                        
                    	<article class="top-line">
                        
                        	<h3>Die Positionen</h3>
{{ list_articles length="2" constraints="type is deb_statement" }}  
{{ list_article_authors }}                       	
                            <figure>
                            	<img alt="Portrait {{ $gimme->author->name }}" src="{{ $gimme->author->picture->imageurl }}" width="120" class="left" />
                                <h4>{{ if $gimme->article->contra }}NEIN{{ else }}JA{{ /if }}</h4>
                            	<p>{{ $gimme->author->name }}, {{ $gimme->article->position }}</p>
                            </figure>
{{ /list_article_authors }}                            
{{ /list_articles }}                            
                            <a id="jetzt" href="#" class="button mid-button">Jetzt einmischen!</a>
                            
                        </article>
                    
                    </div>
                
                </div>