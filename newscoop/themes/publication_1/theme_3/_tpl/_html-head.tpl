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

    <title>Tages Woche</title>
    <meta name="description" content="">
    <meta name="author" content="Ljuba Rankovic" >

    <meta name="viewport" content = "user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <link rel="shortcut icon" {{*type="image/x-icon"*}} href="{{ uri static_file="favicon.ico" }}" />
    <link rel="apple-touch-icon" href="touch-icon.png">

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
</head>
