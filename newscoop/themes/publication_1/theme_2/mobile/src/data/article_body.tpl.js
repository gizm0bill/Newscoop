{{ strip }}
<p><b><span class="title">{{ $gimme->article->name|jsencode }}</span></b></p>
{{ if $gimme->article->type_name != "static_page" }}
  {{ include file="mobile/src/data/article_body_social.tpl" }}
  <p>
    <i>
      {{ if $gimme->article->type_name == "newswire" }}
        sda-Online D&nbsp;
        {{ assign var="replace" value="sda" }}
      {{ else }}
        {{ list_article_authors }}
        {{ if $gimme->current_list->at_beginning}}Von {{ /if }}
          {{ $gimme->author->name }}{{ if $gimme->current_list->at_end}}{{ else }}, {{ /if }}{{ /list_article_authors }},
      {{ /if }}
      &nbsp;{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y, %H:%i" }} Uhr
    </i>
    {{ if $gimme->article->lede|strip_tags || $gimme->article->DataLead|strip_tags }}
      <p><strong>{{ $gimme->article->lede|strip_tags|jsencode }}{{ $gimme->article->DataLead|strip_tags|jsencode }}&nbsp;</strong></p>
    {{ /if }}
  </p>
  
  {{ if $gimme->article->video_url|trim !== "" }}
    <p><a href="{{ $gimme->article->video_url }}" class="linkbox linkvideo" title="Video ansehen" target="_blank">Video ansehen</a></p>          
  {{ /if }}
  
  {{ include file="mobile/src/data/article_image.tpl" }}
  
{{ /if }}

<span class="article-body">
  <p>{{ $gimme->article->body|jsencode }}{{ $gimme->article->DataContent|jsencode }}</p>
</span>

{{ include file="mobile/src/blogs/images.tpl" }}
{{ include file="mobile/src/data/article_body_social.tpl" }}


{{ /strip }}