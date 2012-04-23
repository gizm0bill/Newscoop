$(document).ready(function() {
	
	$('select').dropdownized({fixed:true});
	
	// Datepicker
	$( ".datepicker" ).datepicker({
		showOn: "button",
		buttonImage: "_css/tw2011/img/calendar.png",
		buttonImageOnly: true,
		nextText: '&raquo;',
		prevText: '&laquo;'
	});
	$( "#agenda-datepicker" ).datepicker({
		dayNamesMin: ['M', 'D', 'M', 'D', 'F', 'S', 'S'],
		monthNames: ['Januar','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
		nextText: '&raquo;',
		prevText: '&laquo;',
		numberOfMonths: 3
	});
	
	// Slideshow cycle
	
	$('.slides').each(function() {
        var $this = $(this), $ss = $this.closest('.slideshow');
        var prev = $ss.find('a.prev'), next = $ss.find('a.next'), cap = $ss.find('.caption');
        $this.cycle({
            prev: 		prev,
            next: 		next,
            fx: 		'scrollHorz',
			fit:		true,
			speed:		500,
			timeout:	0,
			rev:		true,
			after:     	onAfter
        });
		function onAfter(curr,next,opts) {
			var caption = (opts.currSlide + 1) + '/' + opts.slideCount;
			$(cap).html(caption);
		}
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
				height: '460px'
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
	
	$('#omnibox a.comm-trigger').toggle(
		function(){
			$('#omnibox.omnibox-comments').animate({
				width: '582px',
				height: '390px'
			},500);
			$('.omnibox-content').show();
			$('.overlay').fadeIn(500);
			
		},
		function(){
			$('#omnibox.omnibox-comments').animate({
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
	
	// Article page side flip
	$('a.article-view-rear').click(function(){
        document.location.hash = 'hintergrund';
        $('#article-rear').show();
        $('#article-front').hide();
        // insert analytics code here
        //document.location = document.location;
        return false;
    });
	$('a.article-view-front').click(function(){
        document.location.hash = '';
        $('#article-front').show();
        $('#article-rear').hide();
        return false;
    });
    
    if (document.location.hash == '#hintergrund') {
        $('a.article-view-rear').trigger('click');
    }	
	
	$('#main-nav .start').click(function(){
		$(this).toggleClass('active');
		$('#main-nav nav').slideToggle();
	});
	$('#mobile-nav li a').click(function(){
		$('#mobile-nav li').removeClass('active');
		$(this).parent().toggleClass('active');
		$(this).next('ul').slideToggle();
	});
	
	// Custom FIle Inputs
	$('input[type=file]').change(function(e){
	  $in=$(this);
	  $in.prev().html($in.val());
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
