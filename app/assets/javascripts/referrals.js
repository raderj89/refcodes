document.addEventListener("turbolinks:load", function() {
  $('a.load-more-referrals').on('inview', function(e, visible) {
    if (!visible) return;

    $.getScript($(this).attr('href'));
  });

  $(document).click('#error-explanation > button.close', function() {
    $('#error-explanation').remove();
  });

  $(document).click('#new_referral #notice', function() {
    $('#notice').remove();
  });

  var elem = $(".detail-counter");

  $("#referral_details").limiter(140, elem);

  window.fbAsyncInit = function() {
    FB.init({
      appId: "393892517413756",
      xfbml: true,
      version: "v2.0"
    });
  };

  $('#referral-deals').on("click", '.fb-share-button', function(e) {
    var link = $(this).data('href');

    FB.ui(
      {
        method: "share",
        href: link,
      },
      function(response) {}
    );
  });

  (function(d, s, id) {
    var js;
    var fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;

    var js = d.createElement(s);
    js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  })(document, "script", "facebook-jssdk");


  window.twttr = (function(d, s, id) {
    var t;
    var js;
    var fjs = d.getElementsByTagName(s)[0];

    if (d.getElementById(id)) return;

    var js = d.createElement(s);
    js.id = id;
    js.src = "https://platform.twitter.com/widgets.js";
    fjs.parentNode.insertBefore(js, fjs);

    var t = {
      _e: [],
      ready: function() {
        t._e.push(f);
        return;
      }
    };

    return window.twttr || t;
  })(document, "script", "twitter-wjs");
});
