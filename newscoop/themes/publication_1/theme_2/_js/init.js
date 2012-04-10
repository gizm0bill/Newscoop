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
  if (document.location.hash.indexOf("debate_comment_") != -1) {
      $('#tab-1').addClass('ui-tabs-hide');
      $('.comments-box-aside').tabs('select', 'tab-2');
      setTimeout('fixCommentLink();', 3000);
  } else if (document.location.hash.indexOf("comment_") != -1) {
      $('#tab-1').addClass('ui-tabs-hide');
      $('.comments-box').tabs('select', 'tab-2');
      setTimeout('fixCommentLink();', 3000);
  } else {
      $('.comments-box').tabs();
  }
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
  
  // Logo hide on navigation hover
  /*$('#main-nav nav').hover(
    function(){$('#top h1').hide();},
    function(){$('#top h1').show();});*/

  /**
   * Removing loading overlay after setup
   */
  var closeLoader = function(carousel) {
      carousel.container.closest('.loader').find('> .loading').delay(300).fadeOut();
      carousel.container.closest('.loader').css('height', 'auto');
  };
  
  //  Carousels
  $('#quotes-carousel').jcarousel({visible: 1, scroll: 1, setupCallback: closeLoader});
  $('#themes-carousel').jcarousel({visible: 1, scroll: 1, setupCallback: closeLoader});
  $('.article-carousel').jcarousel({visible: 2, scroll: 2, setupCallback: closeLoader});
  $('.photo-blog-list').jcarousel({visible: 3, scroll: 3, setupCallback: closeLoader});
  $('#article-single-carousel').jcarousel({visible: 1, scroll: 1, setupCallback: closeLoader});
  $('.article-triple-carousel').jcarousel({visible: 3, scroll: 3, setupCallback: closeLoader});
  $('.article-quartic-carousel').jcarousel({visible: 4, scroll: 2});
  $('#sequence-list').jcarousel({visible: 1, scroll: 1, setupCallback: closeLoader});
  $('#dossier-list').jcarousel({visible: 1, scroll: 1, setupCallback: closeLoader});
  $('#side-img-carosel').jcarousel({visible: 1, scroll: 1, setupCallback: closeLoader});
  $('.content-carousel').jcarousel({visible: 1, scroll: 1});
  $('#blog-carousel').jcarousel({visible: 1, scroll: 1, setupCallback: closeLoader});
  // to allow the other slide-show images to be invisible meanwhile
  $('.image_carousel').removeClass('image_hidden');
  
  // Title info box
  $('h2').hover(
    function(){
      $(this).children().children('div').delay(500).fadeIn(200);
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
  
  // Fancybox
  $('a.fancybox').fancybox({
    'titlePosition' : 'inside',
    'padding'     :3,
    'overlayColor'    :'#ffffff',
    'overlayOpacity'  :0.3,
    'showCloseButton' :false
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
  // Movie info box
  $('.info-link').hover(
    function(){
      $(this).children().children('div').fadeIn(200);
    },
    function(){
      $(this).children().children('div').fadeOut(200);
    }
  );
