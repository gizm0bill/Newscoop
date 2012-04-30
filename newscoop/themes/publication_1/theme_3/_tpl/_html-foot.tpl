	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
    <script>window.jQuery || document.write("<script src='{{ uri static_file='_js/libs/jquery.min.js' }}'>\x3C/script>")</script>

    <script type="text/javascript" src="{{ uri static_file='_js/libs/jquery.cycle.all.js' }}"></script>
    <script type="text/javascript" src="{{ uri static_file='_js/libs/fancybox/jquery.fancybox-1.3.4.pack.js' }}"></script>
    
    <script type="text/javascript" src="{{ uri static_file='_js/libs/jquery-ui-1.8.16.custom.min.js' }}"></script>
    <script type="text/javascript" src="{{ uri static_file='_js/libs/jquery.jcarousel.min.js' }}"></script>
    <script type="text/javascript" src="{{ uri static_file='_js/libs/jquery.dropdownized.min.js' }}"></script>
    <script type="text/javascript" src="{{ uri static_file='_js/libs/jquery.address.js' }}"></script>

    <!--[if (gte IE 6)&(lte IE 8)]>
      <script type="text/javascript" src="{{ url static_file="_js/libs/selectivizr-min.js" }}"></script>
    <![endif]--> 
    

    <script type="text/javascript" src="{{ url static_file="_js/libs/jquery.socialshareprivacy.js" }}"></script>
    <script type="text/javascript">
	jQuery(document).ready(function($) {
	    $('#social_bookmarks').each(function() {
            $(this).socialSharePrivacy({
		        services: {
			        facebook: {
                        'app_id': '204329636307540',
			            'dummy_img': '{{ url static_file="_js/libs/socialshareprivacy/images/dummy_facebook.png" }}'
			        }, 
                    twitter: {
                        'dummy_img': '{{ url static_file="_js/libs/socialshareprivacy/images/dummy_twitter.png" }}'
                    },
                    gplus: {
                        'display_name': 'Google Plus',
                        'dummy_img': '{{ url static_file="_js/libs/socialshareprivacy/images/dummy_gplus.png" }}'
                    }
		        },
                'cookie_path': '/',
                'cookie_domain': document.location.host,
                'cookie_expires': 365,
                'css_path' : '{{ url static_file="_js/libs/socialshareprivacy/socialshareprivacy.css" }}'
            });
        });
        
        $( ".datepicker" ).datepicker({
    		showOn: "button",
    		buttonImage: "{{ url static_file='_css/tw2011/img/calendar.png' }}",
    		buttonImageOnly: true,
    		nextText: '&raquo;',
    		prevText: '&laquo;'
    	});
    });
	</script>
    
    <script type="text/javascript" src="{{ url static_file="_js/init.js" }}"></script>

</body>
</html>
