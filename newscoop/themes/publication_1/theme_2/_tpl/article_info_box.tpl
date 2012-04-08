{{ if $gimme->article->comments_enabled && $gimme->article->content_accessible }}
<a href="#" class="trigger">Open</a>
<ul class="article-header-info"><!-- Article Info Box -->
<li class="comm"><a href="{{ uri options="article" }}#comments">Diskutieren Sie mit ({{ $gimme->article->comment_count }})</a></li>

{{ if $gimme->article->has_topics }}
<li class="list"><a href="{{ uri options="article" }}#themen">Dem Thema folgen</a></li>
{{ /if }}
{{*<li class="recommend"><a href="#">Artikel weiterempfehlen</a></li>*}}
{{*
<li><img src="{{ uri static_file="pictures/sample-fb-like.png" }}" alt="" /></li>
<li><img src="{{ uri static_file="pictures/sample-gplus-icon.png" }}" alt="" /></li>
<li><img src="{{ uri static_file="pictures/sample-tweet-icon.png" }}" alt="" /></li>
*}}
</ul><!-- / Article Info Box -->
{{ /if }}