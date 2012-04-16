    <script type="text/javascript" src="{{ url static_file="_js/libs/jquery.cycle.all.js" }}"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
      <script type="text/javascript" src="{{ url static_file="_js/libs/selectivizr-min.js" }}"></script>
    <![endif]--> 
    
    <script type="text/javascript" src="{{ url static_file="_js/libs/jquery.socialshareprivacy.min.js" }}"></script>
    <script type="text/javascript">
	  jQuery(document).ready(function($){
		$('#social_bookmarks').socialSharePrivacy({
		  services : {
			facebook : {
			  'app_id'      : '0123456789',
			  'dummy_img'	: '{{ url static_file="_js/libs/socialshareprivacy/images/dummy_facebook.png" }}'
			}, 
			twitter : {
			  'dummy_img'	: '{{ url static_file="_js/libs/socialshareprivacy/images/dummy_twitter.png" }}'
			},
			gplus : {
			  'display_name' : 'Google Plus',
			  'dummy_img'	: '{{ url static_file="_js/libs/socialshareprivacy/images/dummy_gplus.png" }}'
			}
		  },
		  'cookie_path'       : '/',
          'cookie_domain'     : document.location.host,
          'cookie_expires'    : '365',
		  'css_path' : '{{ url static_file="_js/libs/socialshareprivacy/socialshareprivacy.css" }}'
		});

	  });
	</script>
    
    <script type="text/javascript" src="{{ url static_file="_js/libs/jquery-ui-1.8.16.custom.min.js" }}"></script>
    <script type="text/javascript" src="{{ url static_file="_js/libs/jquery.jcarousel.min.js" }}"></script>
    <script type="text/javascript" src="{{ url static_file="_js/libs/jquery.dropdownized.min.js" }}"></script>
    
    <script type="text/javascript" src="{{ url static_file="_js/init.js" }}"></script>

</body>
</html>