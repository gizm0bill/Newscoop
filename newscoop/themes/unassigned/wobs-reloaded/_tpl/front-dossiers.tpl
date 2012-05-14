                <div class="two-columns clearfix">
{{ list_articles length="2" order="bysection desc" constraints="issue is 1 section is 5 type is dossier" }}                

                	<article>
                        <figure>
                        	<!-- a href="{{ url options="article" }}" --><big>Dossier:<br />
        <b>{{ $gimme->article->name }}</b></big><!-- /a -->
                        	{{ include file="_tpl/renditions/img_300x200.tpl" }}
                        </figure>
                        <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->lede|strip_tags:false|strip }} <a href="{{ url options="article" }}">Weiterlesen</a> {{ if $gimme->article->comments_enabled }}<a href="{{ url options="article" }}#comments" class="comments">{{ $gimme->article->comment_count }} Kommentar(e)</a>{{ /if }}</p>
                    </article>

{{ /list_articles }}                    
                </div>