<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
    <channel>
        <title>{{block title}}Tageswoche{{/block}}</title>
        <link>{{block rss_link}}{{/block}}</link>
        <atom:link href="{{block atom_link}}{{/block}}" rel="self" type="application/rss+xml" />
        <description>{{block description}}{{/block}}</description>
        <language>de</language>
        <pubDate>{{ $pubDate = date_create() }}{{ $pubDate->format(DateTime::RSS) }}</pubDate>
        <generator>Newscoop</generator>
        {{ foreach $result.response.docs as $doc }}
        <item>
            {{ if $doc.type == 'tweet' }}
            <description>{{ $doc.tweet_user_screen_name|escape }}: {{ $doc.tweet|escape }}</description>
            {{ else }}
            <title>{{ $doc.title|escape }}</title>
            <link>{{ $doc.link }}</link>
            {{ if isset($doc['lead']) }}
            <description>{{ $doc.lead|escape }}</description>
            {{ /if }}
            <guid>{{ $doc.link }}</guid>
            {{ /if }}
            <pubDate>{{ $pubDate = date_create($doc.published) }}{{ $pubDate->format(DateTime::RSS) }}</pubDate>
        </item>
        {{ /foreach }}
    </channel>
</rss>
