var StickyWidget;

StickyWidget = {};

StickyWidget.ScrollStrategy = function() {};

StickyWidget.ScrollStrategy.prototype = {
  isScrolledOutOfView: function(elem) {
    var docViewBottom, docViewTop, elemBottom, elemTop;
    docViewTop = $(window).scrollTop();
    docViewBottom = docViewTop + $(window).height();
    elemTop = $(elem).offset().top;
    elemBottom = elemTop + $(elem).height();
    return elemBottom <= docViewTop;
  }
};

StickyWidget.View = function(selector) {
  return this.selector = selector;
};

StickyWidget.Controller = function(opts) {
  this.view = opts.view;
  this.observableSelector = opts.observableSelector;
  this.actUponSelector = opts.actUponSelector;
  this.scrollStrategy = StickyWidget.ScrollStrategy;
};

StickyWidget.Controller.prototype = {
  initEvents: function() {
    var controller;
    controller = this;
    return controller.observableSelector.scroll(function() {
      if (controller.isOutOfView(controller.view.selector)) {
        return controller.stickify(controller.actUponSelector);
      } else {
        return controller.unstickify(controller.actUponSelector);
      }
    });
  },
  isOutOfView: function(el) {
    return (new this.scrollStrategy()).isScrolledOutOfView(el);
  },
  stickify: function(el) {
    return $(el).addClass("sticky");
  },
  unstickify: function(el) {
    return $(el).removeClass("sticky");
  }
};

$(function() {
  var controller;
  controller = new StickyWidget.Controller({
    view: new StickyWidget.View($("#logo")),
    observableSelector: $(window),
    actUponSelector: ".ref-form"
  }).initEvents();
});
