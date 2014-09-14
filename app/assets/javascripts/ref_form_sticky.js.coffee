StickyWidget = {}
StickyWidget.ScrollStrategy = ->

StickyWidget.ScrollStrategy:: = isScrolledOutOfView: (elem) ->
  docViewTop = $(window).scrollTop()
  docViewBottom = docViewTop + $(window).height()
  elemTop = $(elem).offset().top
  elemBottom = elemTop + $(elem).height()
  elemBottom <= docViewTop

StickyWidget.View = (selector) ->
  @selector = selector

StickyWidget.Controller = (opts) ->
  @view = opts.view
  @observableSelector = opts.observableSelector
  @actUponSelector = opts.actUponSelector
  @scrollStrategy = StickyWidget.ScrollStrategy
  return

StickyWidget.Controller:: =
  initEvents: ->
    controller = this
    controller.observableSelector.scroll ->
      if controller.isOutOfView(controller.view.selector)
        controller.stickify controller.actUponSelector
      else
        controller.unstickify controller.actUponSelector


  isOutOfView: (el) ->
    (new @scrollStrategy()).isScrolledOutOfView el

  stickify: (el) ->
    $(el).addClass "sticky"

  unstickify: (el) ->
    $(el).removeClass "sticky"

$ ->
  controller = new StickyWidget.Controller(
    view: new StickyWidget.View($("#logo"))
    observableSelector: $(window)
    actUponSelector: ".ref-form"
  ).initEvents()
  return