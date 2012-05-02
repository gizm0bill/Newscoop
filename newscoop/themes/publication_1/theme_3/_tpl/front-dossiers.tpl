<div class="mobile-list-view dossier-mobile-list clearfix">
                <div class="two-columns clearfix">
{{ list_articles length="2" order="bysection desc" constraints="issue is 1 section is 5 type is dossier" }}                

                	<article>
                			<a href="{{ url options="article" }}">
                        <figure>
                        	<big>Dossier:<br />
        <b>{{ $gimme->article->name }}</b></big>
                        	{{ include file="_tpl/renditions/img_647x431.tpl" }}
                        </figure>
                        </a>
                        <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->teaser|strip_tags:false|strip }} <a href="{{ url options="article" }}">Weiterlesen</a> {{ if $gimme->article->comments_enabled }}<a href="{{ url options="article" }}#comments" class="comments">{{ $gimme->article->comment_count }} Kommentar(e)</a>{{ /if }}</p>
                    </article>

{{ /list_articles }}                    
                </div>
</div>                