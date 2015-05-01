var Book = {};

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

Book.carousel = function() {
  $(".owl-carousel").owlCarousel({
    rtl: true,
    loop: true,
    lazyLoad: true,
    autoWidth: true,
    margin: 20,
    nav: true,
    items: 7,
    center: true,
  });
};

Book.ready = function() {
  Book.search_summary();
  Book.show_summary();
  Book.carousel();
}

//Needed for when turbolinks isn't doing it's magic
$(document).ready(Book.ready);

//Needed for when turbolinks is doing it's magic 
$(document).on('page:load', Book.ready);
