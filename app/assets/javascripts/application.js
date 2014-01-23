// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require limiter
//= require_tree .

var bindTwitterEventHandlers, renderTweetButtons, twttr_events_bound;

twttr_events_bound = false;

$(function() {
  if (!twttr_events_bound) {
    return bindTwitterEventHandlers();
  }
});

bindTwitterEventHandlers = function() {
  $(document).on('page:load', renderTweetButtons);
  return twttr_events_bound = true;
};

renderTweetButtons = function() {
  $('.twitter-share-button').each(function() {
    var button;
    button = $(this);
    if (button.data('url') == null) {
      button.attr('data-url', document.location.href);
    }
    if (button.data('text') == null) {
      return button.attr('data-text', document.title);
    }
  });
  return twttr.widgets.load();
};

  (function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=393892517413756";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));