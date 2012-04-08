{{ dynamic }}
{{ if isset($smarty.request.mobile) ||
      isset($smarty.request.tablet) ||
      isset($smarty.request.phone) ||
        $gimme->browser->browser_working == "webkit" && 
        (
          ($gimme->browser->ua_type == 'mobile' && (empty($smarty.cookies.app_mode) || $smarty.cookies.app_mode !== 'off')) || 
          isset($smarty.cookies.app_mode) && $smarty.cookies.app_mode == 'on'
        ) 
}}
  {{ include file="mobile/index.tpl" }}
  {{ php }}
    die();
  {{ /php }}
{{ /if }}
{{ /dynamic }}
<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" {{*type="image/x-icon"*}} href="{{ uri static_file="favicon.ico" }}" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ strip }}
        {{ if $gimme->template->name == 'section_my_topics.tpl' }}
        Meine Themen |&nbsp;
        {{ else if $gimme->article->defined }}
          {{ if $gimme->article->SEO_title|trim !== "" }}
              {{ $gimme->article->SEO_title|escape:'html'|trim }} |
          {{ else }}
              {{ $gimme->article->name|escape:'html'|trim }} |
          {{ /if }}&nbsp;
        {{ /if }}
        {{ $gimme->publication->name }}
        {{ /strip }}</title>
    {{ dynamic }}
    <link rel="stylesheet" href="{{ url static_file='_css/tw2011/main.css?v=1' }}">
    <link rel="stylesheet" href="{{ url static_file='_css/tw2011/skin.css' }}">
    <link rel="stylesheet" href="{{ url static_file='_css/tw2011/fixes.css' }}">
    {{ /dynamic }}
    <!-- RSS -->
    <link rel="alternate" type="application/rss+xml" title="TagesWoche" href="http://tageswoche.ch/de/pages/rss_all" />
    {{ local }}{{ set_publication identifier="1" }}{{ set_current_issue }}{{ list_sections constraints="number smaller 60" }}
    <link rel="alternate" type="application/rss+xml" title="TagesWoche | {{ $gimme->section->name }}" href="http://tageswoche.ch/de/pages/rss_{{ $gimme->section->url_name }}" />
    {{ /list_sections }}{{ /local }}
    {{ if $gimme->publication->identifier == "5" }}
    {{ if $gimme->section->defined }}
    <link rel="alternate" type="application/rss+xml" title="{{ $gimme->section->name }} | TagesWoche Blogs" href="http://blogs.tageswoche.ch/de/rss/{{ $gimme->section->url_name }}" />
    {{ /if }}
    {{ /if }}
    <link rel="index" title="{{ $gimme->publication->name }}" href="http://{{ $gimme->publication->site }}">

    <meta name="generator" content="Newscoop">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="robots" content="index, follow">
    {{ include file="_tpl/_meta-description.tpl" }}
    {{ if $gimme->article->defined }}
        <link rel="canonical" href="http://{{ $gimme->publication->site }}/{{ $gimme->language->code }}/{{ $gimme->issue->url_name }}/{{ $gimme->section->url_name }}/{{ $gimme->article->number }}/" />
    {{ elseif $gimme->section->defined }}
        <link rel="canonical" href="{{ url options="section" }}" />
    {{ /if }}
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
{{ if $gimme->url->get_parameter('logout') == 'true' }}
  <META HTTP-EQUIV="Set-Cookie" CONTENT="LoginUserId=; path=/">
  <META HTTP-EQUIV="Set-Cookie" CONTENT="LoginUserKey=; path=/">
  {{ $gimme->url->reset_parameter('logout') }}
  <META HTTP-EQUIV="Refresh" content="0;url={{ uri }}">
{{ /if }} 

  <!-- Load jQuery -->
<!-- Grab Google CDN's jQuery, with a protocol relative URL; fall back to local if necessary -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.js"></script>
    <script>window.jQuery || document.write('<script src="{{ uri static_file="_js/libs/jquery-1.5.1.min.js" }}">\x3C/script>')</script>
<!-- Fancybox -->
<script type="text/javascript" src="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.pack.js') }}"></script>
{{ if $gimme->section->number == 72 || $gimme->template->name == "abo.tpl" }}
    <link rel="stylesheet" href="{{ url static_file='_css/tw2011/abo.css' }}">
{{ /if }}

    <link rel="stylesheet" href="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.css') }}" />
    <script src="{{ url static_file='_js/libs/modernizr-2.0.6.js' }}"></script>
    
    <script type="text/javascript" src="{{ url static_file="_js/cookie.js" }}"></script>

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
