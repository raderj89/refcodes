function isScrolledOutOfView(elem) {
  var docViewTop = $(window).scrollTop();
  var docViewBottom = docViewTop + $(window).height();

  var elemTop = $(elem).offset().top;
  var elemBottom = elemTop + $(elem).height();

  return (elemBottom <= docViewTop);
}

$(function() {
  $(window).scroll(function() {
    if (isScrolledOutOfView($('#logo'))) {
      $('.ref-form').addClass('sticky');
    } else {
      $('.ref-form').removeClass('sticky');
    }
  });
})