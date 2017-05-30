// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap.min
//= require jquery.raty
//= require ratyrate
//= require turbolinks
//= require_tree .


//products index 分类浏览
$(document).ready(function(){
// Initialize Tooltip
$('[product-toggle="tooltip"]').tooltip();

// Add smooth scrolling to all links in navbar + footer link
$(".nav-product a, ").on('click', function(event) {

  // Make sure this.hash has a value before overriding default behavior
  if (this.hash !== "") {

    // Prevent default anchor click behavior
    event.preventDefault();

    // Store hash
    var hash = this.hash;

    // Using jQuery's animate() method to add smooth page scroll
    // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
    $('html, body').animate({
      scrollTop: $(hash).offset().top
    }, 900, function(){

      // Add hash (#) to URL when done scrolling (default click behavior)
      window.location.hash = hash;
    });
  } // End if
});
})

//flashes自动消失
$(document).on('turbolinks:load', function() {

  slideUpAlert();

})

function slideUpAlert() {
  $(".alert").delay(2000).slideUp(250, function() {
    $(this).remove();
  });
}

//回到顶部
$(document).on('click', '#gotop', function () {
  $('body').animate({'scrollTop': 0}, 500) //在500ms的时间内，慢慢地回到顶部
})

$(window).scroll(function () {
  if ($(this).scrollTop() > 500) {
    $('#gotop').fadeIn() // 当页面向下滚动的距离大于500px时，慢慢地显示「回到顶部按钮」
  } else {
    $('#gotop').fadeOut() // 否则慢慢地隐藏「回到顶部按钮」
  }
})
