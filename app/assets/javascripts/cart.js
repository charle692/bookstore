//Stuff for the cart display and hide
var Cart = {};

Cart.isVisible = false;

Cart.ready = function() {
  var cart = $("#cart");
  var cartButton = $("#cart_link");
  var cartExitButton = $("#cart_exit_button");
  cartButton.on("click", function() {
    if(Cart.isVisible) Cart.hide();
    else Cart.show();
  });

  cartExitButton.on("click", function() {
    if(Cart.isVisible) Cart.hide();
  });
};

Cart.hide = function() {
  var cart = $("#cart");
  console.log("hiding");
  Cart.isVisible = false;
  cart.css("visibility", "hidden");
};

Cart.show = function() {
  var cart = $("#cart");
  console.log("showing");
  Cart.isVisible = true;
  cart.css("visibility", "visible");
};

//Needed for when turbolinks isn't doing it's magic
$(document).ready(Cart.ready);

//Needed for when turbolinks is doing it's magic 
$(document).on('page:load', Cart.ready);