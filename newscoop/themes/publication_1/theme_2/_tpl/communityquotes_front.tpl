<!-- _tpl/communityquotes_front.tpl -->  
{{ $weekbackdate=date_create("-1 week") }}
{{ $weekback=$weekbackdate->format("Y-m-d") }}
{{ list_articles ignore_issue="true" ignore_section="true" order="byLastUpdate desc" constraints="section is 85 type is good_comment publish_date greater_equal $weekback" }}
{{ if $gimme->current_list->at_beginning }}
<article>
    <header>
        <p>Auf den Punkt gebracht</p>
    </header>
    <div class="quotes-box">
        <ul id="quotes-carousel" class="jcarousel-skin-quotes">
{{ /if }}        
                <li>
                    <blockquote>{{ $gimme->article->comment_community|strip_tags:false }}</blockquote>
                    <small>{{ $gimme->article->comment_on_comment|replace:"<p>":""|replace:"</p>":""|strip }}</small>
                </li>
{{ if $gimme->current_list->at_end }}                
        </ul>
        <p>Mehr davon</p>
    </div>
</article>
{{ /if }}
{{ /list_articles }}
<!-- / _tpl/communityquotes_front.tpl -->
