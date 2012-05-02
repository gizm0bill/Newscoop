<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
    <channel>
        <title>Tageswoche | Themen {{ $topic }}</title>
        {{ $link = sprintf('%s%s?format=xml', $view->serverUrl(), $view->url(['topic' => $topic], 'topic')) }}
        <link>{{ $link }}</link>
        <atom:link href="{{ $link }}" rel="self" type="application/rss+xml" />
        <description>Alle Artikel der TagesWoche zum Thema {{ $topic|escape }}</description>
        <language>de</language>
        <pubDate>{{ $pubDate = date_create() }}{{ $pubDate->format(DateTime::RSS) }}</pubDate>
        <generator>Newscoop</generator>
        {{ foreach $result.response.docs as $doc }}
        <item>
            <title>{{ $doc.title|escape }}</title>
            <link>{{ $doc.link }}</link>
            {{ if isset($doc['lead']) }}
            <description>{{ $doc.lead|escape }}</description>
            {{ /if }}
            <pubDate>{{ $pubDate = date_create($doc.published) }}{{ $pubDate->format(DateTime::RSS) }}</pubDate>
            <guid>{{ $doc.link }}</guid>
        </item>
        {{ /foreach }}
    </channel>
</rss>
