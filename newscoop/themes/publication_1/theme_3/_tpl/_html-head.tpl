<!doctype html>
{{*
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
*}}
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>{{ strip }}
        {{ if $gimme->article->defined }}
          {{ if $gimme->article->SEO_title|trim !== "" }}
              {{ $gimme->article->SEO_title|escape:'html'|trim }} |
          {{ else }}
              {{ $gimme->article->name|escape:'html'|trim }} |
          {{ /if }}&nbsp;
        {{ elseif $gimme->section->defined }}
        		  {{ $gimme->section->name|escape:'html'|trim }} |
        {{ elseif !($gimme->publication->identifier == "1") }}
        		  {{ $gimme->publication->name }} |&nbsp;
        {{ /if }}&nbsp;
        {{ if $smarty.get.topic != "" }}
             {{ $smarty.get.topic }} |&nbsp;
        {{ /if }}
        TagesWoche&nbsp;
        {{ if $gimme->template->name == "front.tpl" }}
             | Die Wochenzeitung, die täglich erscheint
          {{ /if }}
        {{ /strip }}</title>
        
    {{ include file="_tpl/_meta-description.tpl" }}
    
    {{* include file="_tpl/_meta-keywords.tpl" *}}
    
    <meta name="author" content="Ljuba Rankovic" >
    
    {{ if $gimme->article->defined }}
    <link rel="canonical" href="{{ url options="root_level" }}{{ $gimme->language->code }}/{{ $gimme->issue->url_name }}/{{ $gimme->section->url_name }}/{{ $gimme->article->number }}/" />
    {{ elseif $gimme->section->defined }}
    <link rel="canonical" href="{{ url options="section" }}" />
    {{ /if }}

    <meta name="viewport" content = "user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <link rel="shortcut icon" {{*type="image/x-icon"*}} href="{{ uri static_file="favicon.ico" }}" />
    <link rel="apple-touch-icon" href="touch-icon.png">

{{*  OPEN GRAPH TAGS FOR FACEBOOK  *}}
{{ if $gimme->article->defined }}
  {{*<meta property="og:locale" content="de_CH" /> *}}
  <meta property="og:title" content="{{$gimme->article->name|html_entity_decode|regex_replace:'/&(.*?)quo;/':'&quot;'}}" />
  <meta property="og:type" content="article" />
  <meta property="og:url" content="http://{{ $gimme->publication->site }}/{{ $gimme->language->code }}/{{ $gimme->issue->url_name }}/{{ $gimme->section->url_name }}/{{ $gimme->article->number }}/" />
  <meta property="og:site_name" content="{{ $gimme->publication->name }}" />
  <meta property="og:description" content="{{ if $gimme->article->type_name == "news" || $gimme->article->type_name == "dossier" || $gimme->article->type_name == "eventnews" }}{{$gimme->article->lede|strip_tags:false|strip|escape:'html':'utf-8' }}{{ elseif $gimme->article->type_name == "newswire" }}{{$gimme->article->DataLead|strip_tags:false|strip|escape:'html':'utf-8' }}{{ elseif $gimme->article->type_name == "static_page" }}{{$gimme->article->body|strip_tags:false|strip|escape:'html':'utf-8'|truncate:200 }}{{ elseif $gimme->article->type_name == "deb_moderator" }}{{$gimme->article->teaser|strip_tags:false|strip|escape:'html':'utf-8' }}{{ elseif $gimme->article->type_name == "event" }}{{$gimme->article->description|strip_tags:false|strip|escape:'html':'utf-8' }}{{ /if }}" />
  {{ for $i=0 to 99 }}
  {{ if $gimme->article->has_image($i) }}
  <meta property="og:image" content="{{ $gimme->article->image($i)->imageurl }}" />
  {{ /if }}
  {{ /for }}
{{ /if }}

    {{*  RSS  *}}
    <link rel="alternate" type="application/rss+xml" title="TagesWoche" href="{{ url options="root_level" }}de/pages/rss_all" />
    <link rel="alternate" type="application/rss+xml" title="TagesWoche Omniticker" href="{{ $view->serverUrl() }}{{ $view->url(['controller' => 'omniticker', 'action' => 'index'], 'default') }}?format=xml" />
    {{ local }}{{ set_publication identifier="1" }}{{ set_current_issue }}{{ list_sections constraints="number smaller 60" }}
    <link rel="alternate" type="application/rss+xml" title="TagesWoche | {{ $gimme->section->name }}" href="{{ url options="root_level" }}de/pages/rss_{{ $gimme->section->url_name }}" />
    {{ /list_sections }}{{ /local }}
    {{ if $gimme->publication->identifier == "5" }}
    {{ if $gimme->section->defined }}
    <link rel="alternate" type="application/rss+xml" title="{{ $gimme->section->name }} | TagesWoche Blogs" href="{{ url options="root_level" }}de/rss/{{ $gimme->section->url_name }}" />
    {{ /if }}
    {{ /if }}

	 {{ dynamic }}
    <link rel="stylesheet" href="{{ url static_file="_css/tw2011/main.css" }}">
    <link rel="stylesheet" href="{{ url static_file="_css/tw2011/skin.css" }}">
    <link rel="stylesheet" href="{{ url static_file="_css/tw2011/fixes.css" }}">
    {{ /dynamic }}
    
    <link rel="stylesheet" href="{{ url static_file="_js/libs/fancybox/jquery.fancybox.css" }}">
    <link rel="stylesheet" href="{{ url static_file="_js/libs/fancybox/helpers/jquery.fancybox-thumbs.css" }}">

	{{* jquery has to go to header because of maps *}}
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
    <script>window.jQuery || document.write("<script src='{{ url static_file="_js/libs/jquery.min.js" }}'>\x3C/script>")</script>     
    <script src="{{ url static_file="_js/libs/modernizr-2.0.6.js" }}"></script>
    
    <script type="text/javascript" src="http://imagesrv.adition.com/js/secure_tag_head_ad1_adfarm1.js"></script>
    
{{* GOOGLE ANALYTICS *}}
  <script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-22593782-4']);
  _gaq.push(['_setDomainName', '.tageswoche.ch']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>     
</head>
