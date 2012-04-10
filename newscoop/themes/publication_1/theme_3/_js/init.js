$(document).ready(function() {
    
	// Sticky sidebar for omni box
	/*$("#omnibox").stickySidebar({
		timer: 100,
		speed: 0,
		constrain: true
	});*/
	
	$('select').dropdownized({fixed:true});
	
	// Datepicker
	$( ".datepicker" ).datepicker({
		showOn: "button",
		buttonImage: "_css/tw2011/img/calendar.png",
		buttonImageOnly: true
	});
	$( "#agenda-datepicker" ).datepicker({
		dayNamesMin: ['M', 'D', 'M', 'D', 'F', 'S', 'S'],
		monthNames: ['Januar','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
		nextText: '&raquo;',
		prevText: '&laquo;',
		numberOfMonths: 3
	});
	
	// Tabs
	$('.tabs').tabs();
	
	// Carousel
	$('.carousel').jcarousel({
		scroll : 1
	});
	
	// Omni box and calendar slider
	$('#omnibox, #top-calendar').after('<div class="overlay"></div>');
	$('#omnibox a.trigger, a.omni-box-trigger').toggle(
		function(){
			$('#omnibox').animate({
				width: '319px',
				height: '393px'
			},500);
			$('.omnibox-content').show();
			$('.overlay').fadeIn(500);
			
		},
		function(){
			$('#omnibox').animate({
				width: '44px',
				height: '54px'
			},500);
			$('.omnibox-content').fadeOut(500);
			$('.overlay').fadeOut(500);
		}
	);
	$('.agenda-top a.trigger').toggle(
		function(){
			$(this).addClass('active');
			$('#top-calendar').show();
			$('.agenda-top .overlay').fadeIn(500);
		},
		function(){
			$(this).removeClass('active');
			$('#top-calendar').hide();
			$('.agenda-top .overlay').fadeOut(500);
		}
	);
	
	// Main menu submenues
	$('#main-nav ul li a').hover(
		function(){
			$(this).next('ul.left-items').show();
		},
		function(){
			$(this).next('ul.left-items').hide();
	});
	$('#main-nav ul li').hover(
		function(){
			$(this).children('ul.right-items').show();
		},
		function(){
			$(this).children('ul.right-items').hide();
	});
	
	// Title info box
	$('h2').hover(
		function(){
			$(this).children().children('div').fadeIn(200);
		},
		function(){
			$(this).children().children('div').fadeOut(200);
		}
	);
	
	// Custom FIle Inputs
	$('input[type=file]').change(function(e){
	  $in=$(this);
	  $in.prev().html($in.val());
	});
	
	// Button fixes for article carousels
	$('.jcarousel-skin-article').each(function(){
		var imgHeight = $(this).find('img').height();
		$(this).find('.jcarousel-prev').css('top',imgHeight/2);
		$(this).find('.jcarousel-next').css('top',imgHeight/2);
	});
	$('.jcarousel-skin-article').each(function(){
		var itemWidth = $(this).find('img').width();
		$(this).find('li').css('width',itemWidth);
	});
	
	// Article page side flip
	$('a.article-view-rear').click(function(){$('#article-rear').show();$('#article-front').hide();return false;});
	$('a.article-view-front').click(function(){$('#article-front').show();$('#article-rear').hide();return false;});
	
	
	$('#pinwand-holder').masonry({
		singleMode: false,
		itemSelector: '.sticker-box',
		columnWidth: 300,
		gutterWidth: 40
	});
	
	// Fancybox
	$('a.fancybox').fancybox({
		'titlePosition'	: 'inside',
		'padding'			:3,
		'overlayColor'		:'#ffffff',
		'overlayOpacity'	:0.3,
		'showCloseButton'	:false
	});
	
	//last-child for MSIE
	    if ( $.browser.msie ) {
			$('span.title-box div').append('<div class="ietest"></div>');
			$('span.title-box').prev().hover(
					function(){
						$('.ietest').show();
						},
					function(){
						$('.ietest').hide();
						}
					);
			$('.vote-results a').append('<span class="debatte-after"></span>');
			$('.vote-score li').append('<span class="vote-after"></span>');
		}
		
		if ($.browser.msie  && parseInt($.browser.version) == 7) {
			$('blockquote').prepend('&laquo;');
			$('blockquote').append('&raquo;');	
		}
});
