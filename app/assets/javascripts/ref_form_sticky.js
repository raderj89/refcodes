StickyWidget = {};

StickyWidget.ScrollStrategy = function() {
};

StickyWidget.ScrollStrategy.prototype = {
  isScrolledOutOfView: function(elem) {
    console.log(elem);
    var docViewTop = $(window).scrollTop();
    var docViewBottom = docViewTop + $(window).height();

    var elemTop = $(elem).offset().top;
    var elemBottom = elemTop + $(elem).height();

    return (elemBottom <= docViewTop);
  }
};

StickyWidget.View = function(selector) {
  this.selector = selector;
};

StickyWidget.Controller = function(opts) {
  this.view = opts.view;
  this.observableSelector = opts.observableSelector;
  this.actUponSelector = opts.actUponSelector;
  this.scrollStrategy = StickyWidget.ScrollStrategy;
};

StickyWidget.Controller.prototype = {
  initEvents: function() {
    var controller = this;

    controller.observableSelector.scroll(function() {
      if (controller.isOutOfView(controller.view.selector)) {
        controller.stickify(controller.actUponSelector);
      } else {
        controller.unstickify(controller.actUponSelector);
      }
    });
  },

  isOutOfView: function(el) {
    return (new this.scrollStrategy()).isScrolledOutOfView(el);
  },

  stickify: function(el) {
    $(el).addClass('sticky');
  },

  unstickify: function(el) {
    $(el).removeClass('sticky');
  }
};

$(function() {
  var controller = new StickyWidget.Controller({
    view: new StickyWidget.View($('#logo')),
    observableSelector: $(window),
    actUponSelector: '.ref-form'
  }).initEvents();
});