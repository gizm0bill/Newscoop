<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" href="{{ uri static_file="favicon.ico" }}" />
    <title>Adition Test Page</title>

    <link rel="index" title="{{ $gimme->publication->name }}" href="http://{{ $gimme->publication->site }}">

    <meta name="generator" content="Newscoop">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="robots" content="index, follow">
    <meta name="description=" content="Adition test page" />

  <!-- Load jQuery -->
<!-- Grab Google CDN jQuery, with a protocol relative URL; fall back to local if necessary -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.js"></script>
    <script>window.jQuery || document.write('<script src="{{ uri static_file="_js/libs/jquery-1.5.1.min.js" }}">\x3C/script>')</script>
<!-- Fancybox -->
<script type="text/javascript" src="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.pack.js') }}"></script>
{{ if $gimme->section->number == 72 || $gimme->template->name == "abo.tpl" }}
    <link rel="stylesheet" href="{{ url static_file='_css/tw2011/abo.css' }}">
{{ /if }}

    <link rel="stylesheet" href="{{ url static_file='_css/tw2011/main.css?v=1' }}">
    <link rel="stylesheet" href="{{ url static_file='_css/tw2011/skin.css' }}">
    <link rel="stylesheet" href="{{ url static_file='_css/tw2011/fixes.css' }}">
    <link rel="stylesheet" href="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.css') }}" />
    <script src="{{ url static_file='_js/libs/modernizr-2.0.6.js' }}"></script>
    
    <script type="text/javascript" src="{{ url static_file="_js/cookie.js" }}"></script>

   <script type="text/javascript" src="http://imagesrv.adition.com/js/secure_tag_head_ad1_adfarm1.js"></script>

</head>

<body>

        <div id="wrapper">
        
        <div class="content-box top-content-fix clearfix {{$gimme->section->url_name}}">

            <div class="top-werbung">
                    
<!-- BEGIN ADITIONTAG -->
{{*
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<script type="text/javascript" src="http://ad1.adfarm1.adition.com/js?wp_id=460081"></script>
*}}
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460081"></div>
<!-- END ADITIONTAG -->               

            </div>
                    
{{* include file="_tpl/navigation_top.tpl" *}}
                        
            <section>

<div class="article-list-view padding-fix rubrik-list">
{{ list_playlist_articles length="12" name=Basel }}
{{ include file="_tpl/list-article-teaser-section-big.tpl" }}
{{ if $gimme->current_list->index == 3 }}

<div style="margin-bottom: 15px; display: block">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<script type="text/javascript" src="http://ad1.adfarm1.adition.com/js?wp_id=460081"></script>
<!-- END ADITIONTAG -->               
</div>

{{ /if }}
{{ /list_playlist_articles }}
</div>

            </section>
            
            <aside>
   
            </aside>
        
        </div>

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}

    <!--[if (gte IE 6)&(lte IE 8)]>
      <script type="text/javascript" src="{{ uri static_file="_js/libs/selectivizr-min.js" }}"></script>
    <![endif]--> 

    <script type="text/javascript" src="{{ uri static_file="_js/libs/jquery.socialshareprivacy.js" }}"></script>
    <script type="text/javascript">
    jQuery(document).ready(function($){
    $('#social_bookmarks').socialSharePrivacy({
      services : {
      facebook : {
        'app_id'      : '0123456789', 
        'dummy_img' : '{{ uri static_file="_js/libs/socialshareprivacy/images/dummy_facebook.png" }}'
      }, 
      twitter : {
        'dummy_img' : '{{ uri static_file="_js/libs/socialshareprivacy/images/dummy_twitter.png" }}'
      },
      gplus : {
        'display_name' : 'Google Plus',
        'dummy_img' : '{{ uri static_file="_js/libs/socialshareprivacy/images/dummy_gplus.png" }}'
      }
      },
      'cookie_path'       : '/',
          'cookie_domain'     : document.location.host,
          'cookie_expires'    : '365',
      'css_path' : '{{ uri static_file="_js/libs/socialshareprivacy/socialshareprivacy.css" }}'
    });

    });
  </script>    
    
    <script type="text/javascript" src="{{ url static_file='_js/libs/jquery-ui-1.8.16.custom.min.js' }}"></script>
    <script type="text/javascript" src="{{ url static_file='_js/libs/jquery.easing.1.3.js' }}"></script>
    <script type="text/javascript" src="{{ url static_file='_js/libs/stickysidebar.jquery.js' }}"></script>
    <script type="text/javascript" src="{{ url static_file='_js/libs/jquery.jcarousel.min.js' }}"></script>
    <script type="text/javascript" src="{{ url static_file='_js/libs/custom-form-elements.js' }}"></script>
    <script type="text/javascript" src="{{ url static_file='_js/libs/jquery.simplyscroll-1.0.4.min.js' }}"></script>
    <script type="text/javascript" src="{{ url static_file='_js/libs/jquery.masonry.min.js' }}"></script>
    <script type="text/javascript" src="{{ url static_file='_js/libs/cufon-yui.js' }}"></script>
    <script type="text/javascript" src="{{ url static_file='_js/Founders_Grotesk_Regular_400-Founders_Grotesk_Semibold_600-Founders_Grotesk_Medium_500.font.js' }}"></script>
  
    <script>   
      // Font replacement 
        window.set_cufon_fonts = function() {
            Cufon.replace('aside article section h3, article figure big, ul.two-columns li h4, ul.people-list li h3, .dossier-list-box ul li article h3, dl.profile-details dd h3, dl.profile-details dt h3, .edit-profile-tab h3, .news-tickers article h3',  { fontFamily: 'Founders Grotesk Regular', hover: false }); 
            Cufon.replace('article figure big b, .dossier-list-box ul li article h3 b, .event-search-results h3, .sticker-box h3, .article-list-view article h3, .member-filter a, .event-movies-results table h3, .event-movies-results article h3', { fontFamily: 'Founders Grotesk Medium', hover: true }); 
        }
        window.set_cufon_fonts();
    </script>

    <script type="text/javascript" src="{{ url static_file='_js/init.js' }}"></script>
    
    <script type="text/javascript"> Cufon.now(); </script>
    
    <script type="text/javascript" src="http://imagesrv.adition.com/js/secure_tag_before_body_end.js"></script>
    
<!-- / _tpl/_footer_javascript.tpl -->

</body>
</html>
