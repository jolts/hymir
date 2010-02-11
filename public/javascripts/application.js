(function() {
  window.Hymir = {}

  Hymir.App = {
    init: function() {
      this.setupTipsy();
    },

    setupTipsy: function() {
      $('a[rel*=tipsy]').tipsy({gravity: $.fn.tipsy.autoNS});
    }
  }
})();

$(function() {
  Hymir.App.init();
});
