isScrolledOutOfView = (elem) ->
  docViewTop = $(window).scrollTop()
  docViewBottom = docViewTop + $(window).height()

  elemTop = $(elem).offset().top
  elemBottom = elemTop + $(elem).height()

  return (elemBottom <= docViewTop)

$ ->
  $(window).scroll ->
    if isScrolledOutOfView($('#logo'))
      $('.ref-form').addClass 'sticky'
    else
      $('.ref-form').removeClass 'sticky'