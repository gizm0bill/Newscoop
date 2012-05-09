$(document).ready(function() {
	
// this makes problems for js-based select/options manipulations
//	$('select').dropdownized({fixed:true});
    $('select').not('#mobile-nav-box').each(function(ind_elm, elm) {
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

	// Mobile slider
	if ( $(window).width() < 768) {
		$('.mobile-slider').each(function() {
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
	}


	// Tabs
	$('.tabs').tabs();
    $(".tabs").bind("tabsselect", function(e, tab) {
        if (tab.panel.id == 'mein-abo') {
            $('#manage_subscription_box').show();
        }
    });
	
// Carousel
$('.carousel').jcarousel({visible: 6});
 
if ( $(window).width() < 768) {$('.mobile-carousel').jcarousel({visible: 3, scroll: 1});}
if ( $(window).width() < 641) {$('.mobile-carousel').jcarousel({visible: 1, scroll: 1});}	
	
	// Omni box and calendar slider
	$('#omnibox, #top-calendar').after('<div class="overlay"></div>');
	$('#omnibox a.trigger, a.omni-box-trigger').click(
		function(){
			if (omnibox) {
                omnibox.toggle();
            }
		}
	);
	
	$('#omnibox a.comm-trigger').click(
		function(){
			if (omnibox) {
                omnibox.toggle();
            }
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
            omnibox.show();
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
        document.location.hash = '';
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
    
    $('#article-recommend-button').fancybox({type: 'iframe', width: 600, height: 500, padding: 4, margin: 0, scrolling: 0});
	
	
	
	// Mobile nav
	$('#mobile-nav li a').click(function() {
        if (!$(this).parent().hasClass('login') && !$(this).parent().hasClass('settings')) {
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
	$('.top-filter li a.info, .movie-table table a.info').hover(
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

    $('#mobile-nav-box').change(function(e) {
        window.location = $(e.target).val();
    });
});
