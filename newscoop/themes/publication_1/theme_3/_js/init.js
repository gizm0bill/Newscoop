$(document).ready(function() {
	
// this makes problems for js-based select/options manipulations
//	$('select').dropdownized({fixed:true});
    $('select').each(function(ind_elm, elm) {
        var jq_elm = $(elm);
        if (!jq_elm.hasClass('omit_dropdown')) {
            jq_elm.dropdownized({fixed:true});
        }
    });
	
	// Datepicker
	$( ".datepicker" ).datepicker({
		showOn: "button",
		buttonImage: "_css/tw2011/img/calendar.png",
		buttonImageOnly: true,
		nextText: '&raquo;',
		prevText: '&laquo;'
	});
/*  is defined inside agenda's subnav.tpl
	$( "#agenda-datepicker" ).datepicker({
		dayNamesMin: ['M', 'D', 'M', 'D', 'F', 'S', 'S'],
		monthNames: ['Januar','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
		nextText: '&raquo;',
		prevText: '&laquo;',
		numberOfMonths: 3
	});
*/
	$( "#agenda-mobile-datepicker" ).datepicker({
		dayNamesMin: ['M', 'D', 'M', 'D', 'F', 'S', 'S'],
		monthNames: ['Januar','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
		nextText: '&raquo;',
		prevText: '&laquo;',
		numberOfMonths: 1
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
 $('.carousel').jcarousel();	
	
	// Omni box and calendar slider
	$('#omnibox, #top-calendar').after('<div class="overlay"></div>');
	$('#omnibox a.trigger, a.omni-box-trigger').toggle(
		function(){
			$('#omnibox').animate({
				width: omnibox.openWidth,
				height: omnibox.openHeight
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
				width: omnibox.openWidth,
				height: omnibox.openHeight
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
	
/*  is defined inside agenda's subnav.tpl
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
*/
	
	$('#jetzt').click(function() {
			omnibox.showHide();
	});
	
	$('.agenda-mobile-top ul li a').click(function() {
		if ($(this).hasClass('active')) {
			$('.agenda-mobile-top ul li a').removeClass('active');
			$('.agenda-mobile-top ul li ul').slideUp();
			$('.agenda-mobile-top ul li div.calendar').slideUp();
			$(this).next().slideUp();
		} else {
			$('.agenda-mobile-top ul li a').removeClass('active');
			$(this).addClass('active');
			$('.agenda-mobile-top ul li ul').slideUp();
			$('.agenda-mobile-top ul li div.calendar').slideUp();
			$(this).next().slideDown();
		}
		return false;
	});
	
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
    };
    
    $('#article-recommend-button').fancybox({height: 460, padding: 4, margin: 0, scrolling: 0});
	
	
	
	// Mobile nav
	$('#mobile-nav li a').click(function() {
		if ($(this).parent().hasClass('active')) {
			$('#mobile-nav li').removeClass('active');
			$('#main-nav .start').removeClass('active');
			$('#mobile-nav li ul').slideUp();
			$('#main-nav nav').slideUp();
		} else {
			$('#mobile-nav li').removeClass('active');
			$('#main-nav .start').removeClass('active');
			$(this).parent().addClass('active');
			$('#mobile-nav li ul').slideUp();
			$(this).next('ul').slideDown();
			$('#main-nav nav').slideUp();
		}
		return false;
	});
	
	$('#main-nav .start').click(function() {
		if ($(this).hasClass('active')) {
			$('#mobile-nav li').removeClass('active');
			$(this).removeClass('active');
			$('#mobile-nav li ul').slideUp();
			$('#main-nav nav').slideUp();
		} else {
			$(this).addClass('active');
			$('#mobile-nav li').removeClass('active');
			$('#main-nav nav').slideDown();
		}
		return false;
	});
	
	// Info icon hover
	$('.top-filter li a.info').hover(
		function(){
			$(this).children('span').fadeIn('fast');
		},
		function(){
			$(this).children('span').fadeOut('fast');
		}
	);
	
	// Fancybox
	$('.email-trigger').fancybox({
		helpers : {
        	overlay : {
            	opacity : 0.3
        	}
    	}
	});
	
$(".fancybox-thumb").fancybox({
		prevEffect	: 'none',
		nextEffect	: 'none',
		helpers	: {
			title	: {
				type: 'outside'
			},
			overlay	: {
				opacity : 0.6,
				css : {
					'background-color' : '#000'
				}
			},
			thumbs	: {
				width	: 100,
				height	: 75
			}
		}
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
