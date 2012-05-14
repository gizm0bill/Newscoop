$(document).ready(function() {
    
	// Sticky sidebar for omni box
	/*$("#omnibox").stickySidebar({
		timer: 100,
		speed: 0,
		constrain: true
	});*/
	
	// Datepicker
	$( ".datepicker" ).datepicker({
		showOn: "button",
		buttonImage: "_css/tw2011/img/calendar.png",
		buttonImageOnly: true
	});
	
	// Tabs
	$('.comments-box').tabs();
	$('#edit-profile-holder').tabs();
	
	// Omni box slider
	$('#omnibox a.trigger, a.omni-box-trigger').toggle(
		function(){
			$('#omnibox').animate({
				width: '674px',
				height: '600px'
			},500);
			$('.omnibox-content').show();
		},
		function(){
			$('#omnibox').animate({
				width: '44px',
				height: '54px'
			},500);
			$('.omnibox-content').fadeOut(500);
		}
	);
	
	// Main menu submenues
	$('#main-nav ul li').hover(
		function(){
			$(this).children('ul.sub').show();
		},
		function(){
			$(this).children('ul.sub').hide();
	});
	
	//  Carousels
	$('#quotes-carousel').jcarousel({visible: 1, scroll: 1});
	$('#themes-carousel').jcarousel({visible: 1, scroll: 1});
	$('.article-carousel').jcarousel({visible: 2, scroll: 2});
	$('.photo-blog-list').jcarousel({visible: 3, scroll: 3});
	$('#article-single-carousel').jcarousel({visible: 1, scroll: 1});
	$('.article-triple-carousel').jcarousel({visible: 3, scroll: 3});
	$('.article-quartic-carousel').jcarousel({visible: 4, scroll: 2});
	$('#sequence-list').jcarousel({visible: 1, scroll: 1});
	$('#dossier-list').jcarousel({visible: 1, scroll: 1});
	$('#side-img-carosel').jcarousel({visible: 1, scroll: 1});
	$('.content-carousel').jcarousel({visible: 1, scroll: 1});
	
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
	
	// Article header info box
	$('article header a.trigger').click(function(){
		if ($(this).next('ul.article-header-info').is(':hidden')){
			$(this).next('ul.article-header-info').show();
			$(this).addClass('selected');
			}
		else{
			$(this).removeClass('selected');
			$(this).next('ul.article-header-info').hide();
		}
		return false;
	});
	$('ul.article-header-info').click(function(e) {
		e.stopPropagation();
	});
	$(document).click(function() {
		$('article header a.trigger').removeClass('selected');
		$('ul.article-header-info').hide();
	});
	
	// News ticker
	$(".news-ticker ul").simplyScroll({
		autoMode: 'loop'
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
	$('a#flip-to-rear').click(function(){$('#article-front').hide();$('#article-rear').show();return false;});
	$('a#flip-to-front').click(function(){$('#article-rear').hide();$('#article-front').show();return false;});
	
	$('#pinwand-holder').masonry({
		singleMode: false,
		itemSelector: '.sticker-box',
		columnWidth: 300,
		gutterWidth: 40
	});
	
});
