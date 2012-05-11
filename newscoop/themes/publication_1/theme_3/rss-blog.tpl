<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:media="http://search.yahoo.com/mrss/">
<channel>
{{ list_articles length="1" ignore_issue="true" constraints="type is bloginfo" }}
<title>{{ $gimme->article->name|html_entity_decode|regex_replace:'/&(.*?)quo;/':'&quot;' }}</title>
<link>{{ url options="section" }}</link>
<description>{{ $gimme->article->infolong|strip_tags|html_entity_decode|regex_replace:'/&(.*?)quo;/':'&quot;' }}</description>
<language>{{ $gimme->language->code }}</language>
{{ /list_articles }}
<copyright>Copyright {{$smarty.now|date_format:"%Y"}}, {{$gimme->publication->name}}</copyright>
<lastBuildDate>{{$smarty.now|date_format:"%a, %d %b %Y %H:%M:%S"}} +0000</lastBuildDate>
<ttl>60</ttl>
<generator>Newscoop</generator>
<image>
<url>{{ url static_file="_css/tw2011/img/logo-beta.png" }}</url>
<title>{{$gimme->publication->name}}</title>
<link>{{ url options="root_level" }}</link>
<width>510</width>
<height>68</height>
</image>
{{list_articles length="20" ignore_issue="true" constraints="type is blog" order="bypublishdate desc" }}
<item>
<title>{{$gimme->article->name|html_entity_decode|regex_replace:'/&(.*?)quo;/':'&quot;'}}</title>
<link>{{ url options="article" }}</link>
<description>
{{ image rendition="rubrikenseite" }}
&lt;img src="{{ $image->src }}" width="120" height="80" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" border="0" align="left" hspace="5" /&gt;
{{ /image }}
{{ if !($gimme->article->lede == "")}}
{{ $gimme->article->lede|strip_tags:false|strip|escape:'html':'utf-8'}}
{{ else }}
{{ $gimme->article->body|strip_tags:false|strip|escape:'html':'utf-8'|truncate:200 }}
{{ /if }}
&lt;br clear="all"&gt;
</description>
<category domain="{{ url options="section" }}">{{$gimme->section->name}}</category>
{{if $gimme->article->author->name}}
<atom:author><atom:name>{{ list_article_authors }}{{$gimme->author->name}}{{ if $gimme->current_list->at_end }}{{ else }}, {{ /if }}{{ /list_article_authors }}</atom:name></atom:author>
{{/if}}
<pubDate>{{$gimme->article->publish_date|date_format:"%a, %d %b %Y %H:%M:%S"}}+0000</pubDate>
<guid isPermaLink="true">{{ url options="article" }}</guid>
</item>
{{/list_articles}}
</channel>
</rss>