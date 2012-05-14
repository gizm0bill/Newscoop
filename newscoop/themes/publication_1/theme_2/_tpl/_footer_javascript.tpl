<!-- _tpl/_footer_javascript.tpl -->   

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

    <script type="text/javascript" src="{{ url static_file='_js/init.js' }}?v=1"></script>
    
    <script type="text/javascript"> Cufon.now(); </script>
    
    <script type="text/javascript" src="http://imagesrv.adition.com/js/secure_tag_before_body_end.js"></script>  
    
<!-- / _tpl/_footer_javascript.tpl -->
