<?xml version="1.0" encoding="UTF-8"?><?xml-stylesheet type="text/xsl" href="{{ uri static_file="/_css/tw2011/smap.xsl" }}"?><!-- generator="Newscoop/3.6" -->  
<!-- generated-on="{{ $smarty.now|date_format:"%a, %d %b %Y %H:%M:%S" }} +0100" --> 
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
{{ list_articles ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is news" }}
   <url>
      <loc>http://tageswoche.ch{{ uri options="article" }}</loc>
      <lastmod>{{ $gimme->article->publish_date|camp_date_format:"%Y-%m-%d" }}</lastmod>
      <changefreq>daily</changefreq>
      <priority>0.8</priority>
   </url>
{{ /list_articles }}{{ list_articles ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is newswire behave_as_news is on" }}
   <url>
      <loc>http://tageswoche.ch{{ uri options="article" }}</loc>
      <lastmod>{{ $gimme->article->publish_date|camp_date_format:"%Y-%m-%d" }}</lastmod>
      <changefreq>daily</changefreq>
      <priority>0.8</priority>
   </url>
{{ /list_articles }}{{ /list_articles }}{{ list_articles ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is newswire" }}
   <url>
      <loc>http://tageswoche.ch{{ uri options="article" }}</loc>
      <lastmod>{{ $gimme->article->publish_date|camp_date_format:"%Y-%m-%d" }}</lastmod>
      <changefreq>daily</changefreq>
      <priority>0.6</priority>
   </url>
{{ /list_articles }}{{ set_current_issue }}{{ list_sections }}
   <url>
      <loc>http://tageswoche.ch/{{ $gimme->language->code }}/{{ $gimme->issue->url_name }}/{{ $gimme->section->url_name }}/</loc>
      <changefreq>weekly</changefreq>
      <priority>0.3</priority>
   </url>{{ /list_sections }}
</urlset> 