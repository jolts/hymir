(function() {
  window.Hymir = {}

  var setupHandlers = function() {
    $('a[rel*=tipsy]').tipsy({gravity: $.fn.tipsy.autoNS});
  }
  var setupCufon = function() {
    Cufon.replace('h1, h2, h3, #nav, #footer, #pagination, #locales');
  }

  Hymir.App = {
    init: function() {
      setupHandlers();
      //setupCufon();
    }
  }
})();

$(function() {
  Hymir.App.init();
});
