(function() {
  window.Hymir = {}

  var setupHandlers = function() {
    $('a[rel*=tipsy]').tipsy({gravity: $.fn.tipsy.autoNS});
  }
  var setupCufon = function() {
    Cufon.replace('h1, h2, h3, h4, h5, h6, #nav, #footer');
  }

  Hymir.App = {
    init: function() {
      setupHandlers();
      setupCufon();
    }
  }
})();

$(function() {
  Hymir.App.init();
});
