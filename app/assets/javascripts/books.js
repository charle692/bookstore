/*
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/

var Book = {};

Book.sliderHandlers = {};

Book.TRACK_PREFIX = "slider-";
Book.ARROW_LEFT_PREFIX = "slider-left-arrow-";
Book.ARROW_RIGHT_PREFIX = "slider-right-arrow-";
Book.TRACK_START = -1000;

Book.setup = function() {
  $(".slider-track").each(function() {
    var categoryName = $(this).attr("id").replace(Book.TRACK_PREFIX, "");

    var leftSlider = $("#" + Book.ARROW_LEFT_PREFIX + categoryName);
    var rightSlider = $("#" + Book.ARROW_RIGHT_PREFIX + categoryName);

    var sliderHandler = new SliderHandler(this, leftSlider, rightSlider);
    Book.sliderHandlers[categoryName] = sliderHandler;

    sliderHandler.init();
  });
};

Book.search_summary = function() {
  $('div.book_summary').each(function() {
    $('#'+ this.id).readmore({
      speed: 400,
      collapsedHeight: 100,
      afterToggle: function(trigger, element, expanded) {
        if(expanded) { // The "Close" link was clicked
          $('html,body').animate({
            scrollTop: $('div#' + event.target.id).offset().top - 350
          })
        }
      }
    });
  })
};

Book.show_summary = function() {
  $('#book_show_summary').readmore({
    speed: 400,
    collapsedHeight: 145
  })
};

//SliderHandler object (class)
function SliderHandler(inTrack, inLeftArrow, inRightArrow) {
  this.track = inTrack;
  this.leftArrow = inLeftArrow;
  this.rightArrow = inRightArrow;
  this.top;
  this.left;
  this.leftEnabled = false;
  this.rightEnabled =  false;
  this.intervalId = null;
}

SliderHandler.prototype.init = function() {
  var positions = $(this.track).position();
  this.top = positions["top"];
  this.left = positions["left"] + Book.TRACK_START;
  $(this.track).css({left: this.left});
  this.enableLeftSlide(this);
  this.enableRightsSlide(this);
}

SliderHandler.prototype.slidingRight = function(handler) {
  if(handler.rightEnabled) {
    handler.showRightSlide(handler);

    handler.left += 2;
    $(handler.track).css({left: handler.left});

    if(handler.left >= 0) {
      handler.hideLeftSlide(handler);
    }
  }
}

SliderHandler.prototype.slidingLeft = function(handler) {
  if(handler.leftEnabled) {
    handler.showLeftSlide(handler);

    handler.left -= 2;
    $(handler.track).css({left: handler.left});

    if(handler.left <= -1780) {
      handler.hideRightSlide(handler);
    }
  }
}

SliderHandler.prototype.startSlideLeft = function(handler) {
  handler.intervalId = setInterval(handler.slidingLeft, 10, handler);
}

SliderHandler.prototype.startSlideRight = function(handler) {
  handler.intervalId = setInterval(handler.slidingRight, 10, handler);
}

SliderHandler.prototype.stopSlideLeft = function(handler) {
  clearInterval(handler.intervalId);
}

SliderHandler.prototype.stopSlideRight = function(handler) {
  clearInterval(handler.intervalId);
}

SliderHandler.prototype.enableLeftSlide = function(handler) {
  var arrow = $(handler.leftArrow);

  arrow.show();

  arrow.hover(
    function() {
      handler.startSlideRight(handler);
    },
    function() {
      handler.stopSlideRight(handler);
    }
  );

  handler.leftEnabled = true;
}

SliderHandler.prototype.enableRightsSlide = function(handler) {
  var arrow = $(handler.rightArrow);

  arrow.show();

  arrow.hover(
    function() {
      handler.startSlideLeft(handler);
    },
    function() {
      handler.stopSlideLeft(handler);
    }
  );

  handler.rightEnabled = true;
}

SliderHandler.prototype.showLeftSlide = function(handler) {
  var arrow = $(handler.leftArrow);
  arrow.show();
  handler.rightEnabled = true;
}

SliderHandler.prototype.showRightSlide = function(handler) {
  var arrow = $(handler.rightArrow);
  arrow.show();
  handler.leftEnabled = true;
}

SliderHandler.prototype.hideLeftSlide = function(handler) {
  var arrow = $(handler.leftArrow);
  arrow.hide();
  handler.rightEnabled = false;
}

SliderHandler.prototype.hideRightSlide = function(handler) {
  var arrow = $(handler.rightArrow);
  arrow.hide();
  handler.leftEnabled = false;
}

Book.ready = function() {
  Book.setup();
  Book.search_summary();
  Book.show_summary();
}

//Needed for when turbolinks isn't doing it's magic
$(document).ready(Book.ready);

//Needed for when turbolinks is doing it's magic 
$(document).on('page:load', Book.ready);
