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

Book.setup = function() {
  $(".slider-track").each(function() {
    var categoryName = $(this).attr("id").replace(Book.TRACK_PREFIX, "");

    var leftSlider = $("#" + Book.ARROW_LEFT_PREFIX + categoryName);
    var rightSlider = $("#" + Book.ARROW_RIGHT_PREFIX + categoryName);

    var sliderHandler = new SliderHandler(this, leftSlider, rightSlider);
    Book.sliderHandlers[categoryName] = sliderHandler;

    leftSlider.hover(
      sliderHandler.startSlideRight(sliderHandler),
      sliderHandler.stopSlideRight
    );

    rightSlider.hover(
      sliderHandler.startSlideLeft(sliderHandler),
      sliderHandler.stopSlideLeft
    );
  });
};

//SliderHandler object (class)
function SliderHandler(inTrack, inLeftArrow, inRightArrow) {
  this.track = $(inTrack);
  this.leftArrow = inLeftArrow;
  this.rightArrow = inRightArrow;
  this.top;
  this.left;
  this.isSlidingLeft = false;
  this.isSlidingRight = false;
  this.intervalId = null;
}

SliderHandler.prototype.init = function() {
  var positions = track.position();
  this.top = positions[top];
  this.left = position[left];
}

SliderHandler.prototype.slidingRight = function() {
  //this.track.position({top: top, left: left += 5});
  console.log("slidingRight");
}

SliderHandler.prototype.slidingLeft = function() {
  //this.track.position({top: top, left: left -= 5});
  console.log("slidingLeft");
}

SliderHandler.prototype.startSlideLeft = function(handler) {
  this.intervalId = setInterval(function(handler) {console.log(handler)}, 10);
}

SliderHandler.prototype.startSlideRight = function(handler) {
  this.intervalId = setInterval(this.slidingRight, 10);
}

SliderHandler.prototype.stopSlideLeft = function() {
  clearInterval(this.intervalId);
}

SliderHandler.prototype.stopSlideRight = function() {
  clearInterval(this.intervalId);
}

//It starts this stuff up
$(document).ready(function() {
  Book.setup();
});