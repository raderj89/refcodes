$ ->
  $('a.load-more-referrals').on 'inview', (e, visible) ->
    return unless visible
    
    $.getScript $(this).attr('href')


  $(document).click '#error-explanation > button.close', ->
    $('#error-explanation').remove()

  $(document).click '#new_referral #notice', ->
    $('#notice').remove()

  elem = $(".detail-counter")

  $("#referral_details").limiter 140, elem

  window.fbAsyncInit = ->
    FB.init
      appId: "393892517413756"
      xfbml: true
      version: "v2.0"

  $('#referral-deals').on "click", '.fb-share-button', (e) ->
    link = $(this).data('href')
    FB.ui
      method: "share"
      href: link
    , (response) ->

  ((d, s, id) ->
    js = undefined
    fjs = d.getElementsByTagName(s)[0]
    return  if d.getElementById(id)
    js = d.createElement(s)
    js.id = id
    js.src = "//connect.facebook.net/en_US/sdk.js"
    fjs.parentNode.insertBefore js, fjs
  ) document, "script", "facebook-jssdk"

  
window.twttr = ((d, s, id) ->
  t = undefined
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  return  if d.getElementById(id)
  js = d.createElement(s)
  js.id = id
  js.src = "https://platform.twitter.com/widgets.js"
  fjs.parentNode.insertBefore js, fjs
  window.twttr or (t =
    _e: []
    ready: (f) ->
      t._e.push f
      return
  )(document, "script", "twitter-wjs"))
