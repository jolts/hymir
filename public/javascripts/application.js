(function() {
  window.Hymir = {}

  var setupHandlers = function() {
    $('a[rel*=tipsy]').tipsy({gravity: $.fn.tipsy.autoNS})
  }

  Hymir.App = {
    init: function() {
      setupHandlers()
    }
  }
})();

$(function() {
  Hymir.App.init()
});
