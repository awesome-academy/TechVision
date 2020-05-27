// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
import "bootstrap"


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
(function($) {
  "use strict"

  // Fixed Nav
  var lastScrollTop = 0;
  $(window).on('scroll', function() {
    var wScroll = $(this).scrollTop();
    if ( wScroll > $('#nav').height() ) {
      if ( wScroll < lastScrollTop ) {
        $('#nav-fixed').removeClass('slide-up').addClass('slide-down');
      } else {
        $('#nav-fixed').removeClass('slide-down').addClass('slide-up');
      }
    }
    lastScrollTop = wScroll
  });

  // Search Nav
  $('.search-btn').on('click', function () {
    $('.search-form').addClass('active');
  });

  $('.search-close').on('click', function () {
    $('.search-form').removeClass('active');
  });

  // Aside Nav
  $(document).click(function(event) {
    if (!$(event.target).closest($('#nav-aside')).length) {
      if ( $('#nav-aside').hasClass('active') ) {
        $('#nav-aside').removeClass('active');
        $('#nav').removeClass('shadow-active');
      } else {
        if ($(event.target).closest('.aside-btn').length) {
          $('#nav-aside').addClass('active');
          $('#nav').addClass('shadow-active');
        }
      }
    }
  });

  $('.nav-aside-close').on('click', function () {
    $('#nav-aside').removeClass('active');
    $('#nav').removeClass('shadow-active');
  });

  // Sticky Shares
  var $shares = $('.sticky-container .sticky-shares'),
  $sharesHeight = $shares.height(),
  $sharesTop,
  $sharesCon = $('.sticky-container'),
  $sharesConTop,
  $sharesConleft,
  $sharesConHeight,
  $sharesConBottom,
  $offsetTop = 80;

  function setStickyPos () {
    if ($shares.length > 0) {
      $sharesTop = $shares.offset().top
      $sharesConTop = $sharesCon.offset().top;
      $sharesConleft = $sharesCon.offset().left;
      $sharesConHeight = $sharesCon.height();
      $sharesConBottom = $sharesConHeight + $sharesConTop;
    }
  }

  function stickyShares (wScroll) {
    if ($shares.length > 0) {
      if ( $sharesConBottom - $sharesHeight - $offsetTop < wScroll ) {
        $shares.css({ position: 'absolute', top: $sharesConHeight - $sharesHeight , left:0});
      } else if ( $sharesTop < wScroll + $offsetTop ) {
        $shares.css({ position: 'fixed', top: $offsetTop, left: $sharesConleft });
      } else {
        $shares.css({position: 'absolute', top: 0, left: 0});
      }
    }
  }

  $(window).on('scroll', function() {
    stickyShares($(this).scrollTop());
  });

  $(window).resize(function() {
    setStickyPos();
    stickyShares($(this).scrollTop());
  });

  setStickyPos();

})(jQuery);
