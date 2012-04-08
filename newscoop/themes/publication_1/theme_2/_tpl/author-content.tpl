<article id="user-content">
	<header><ul>
		{{ if $user->isAuthor() }}
		<li><a href="#artikel">Artikel</a></li>
		<li><a href="#blogpostings">Blogpostings</a></li>
		{{ /if }}
		<li><a href="#kommentare">Kommentare</a></li>
	</ul></header>

	{{ if $user->isAuthor() }}
	{{ $escapedName=str_replace(" ", "\ ", $user->author->name) }}

	<div id="artikel"><ul class="jcarousel-skin-quotes">
        <li><ul class="item-list extended profil-activity">
			{{ list_articles ignore_publication="true" ignore_issue="true" ignore_section="true" constraints="author is $escapedName type is news" order="bypublishdate desc" }}
            {{ if $gimme->current_list->index > 1 && $gimme->current_list->index % 10 == 1 }}
            </ul></li>
            <li><ul class="item-list extended profil-activity">
            {{ /if }}
			<li>
				<time>{{ $gimme->article->publish_date|camp_date_format:"%d.%m.%Y um %H:%i" }}</time>
				<b><a href="{{ $gimme->article->url }}{{ $gimme->article->seo_url_end }}" title="{{ $gimme->article->title }}">{{ $gimme->article->title }}</a></b>
				<br />{{ $gimme->article->teaser }}
			</li>
			{{ /list_articles }}
		</ul></li>
	</ul></div>

	<div id="blogpostings"><ul class="jcarousel-skin-quotes">
		<li><ul class="item-list extended profil-activity">
			{{ list_articles ignore_publication="true" ignore_issue="true" ignore_section="true" constraints="author is $escapedName type is blog" order="bypublishdate desc" }}
            {{ if $gimme->current_list->index > 1 && $gimme->current_list->index % 10 == 1 }}
            </ul></li>
            <li><ul class="item-list extended profil-activity">
            {{ /if }}
			<li>
				<time>{{ $gimme->article->publish_date|camp_date_format:"%d.%m.%Y um %H:%i" }}</time>
				<b><a href="{{ $gimme->article->url }}{{ $gimme->article->seo_url_end }}" title="{{ $gimme->article->title }}">{{ $gimme->article->title }}</a></b>
				<br />{{ $gimme->article->lede }}
			</li>
			{{ /list_articles }}
		</ul></li>
	</ul></div>
	{{ /if }}
	
	<div id="kommentare"><ul class="jcarousel-skin-quotes">
		<li><ul class="item-list extended profil-activity">
			{{ list_user_comments user=$user->identifier order="bydate desc" length="30" }}
            {{ if $gimme->current_list->index > 1 && $gimme->current_list->index % 10 == 1 }}
            </ul></li>
            <li><ul class="item-list extended profil-activity">
            {{ /if }}
			<li class="commentar">{{ $date=date_create($gimme->user_comment->submit_date) }}
				<time>{{ $date->format('d.m.Y \u\m H:i') }}</time>
        			<b{{* class="{{ cycle values="green-txt," }}"*}}>{{ $gimme->user_comment->subject|escape }}</b><br />
       				«{{ $gimme->user_comment->content|escape|truncate:255:"...":true }}»  Zum Artikel: <a href="{{ $gimme->user_comment->article->url }}">{{ $gimme->user_comment->article->name }}</a>
			</li>
			{{ /list_user_comments }}
		</ul></li>
	</ul></div>
</article>
<script>
$(function() {
	// remove tab switch if list is empty
	$('#user-content header a').each(function() {
		var id = $(this).attr('href');
		if ($(id).find('.item-list li').size() == 0) { // remove empty lists
			$(this).closest('li').detach();
            $(id).detach();
		} else if ($(id).find('.item-list').size() > 1) { // init jcarousel for non empty
            $(id).find('.jcarousel-skin-quotes').jcarousel({ visible: 1, scroll: 1});
        }
	});

	// init tabs only if some tab survived
	if ($('#user-content header li').size()) {
		$('#user-content').tabs();
	} else { // remove content
		$('#user-content').detach();
	}
});
</script>
