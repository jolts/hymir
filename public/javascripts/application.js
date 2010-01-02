(function() {
  window.Hymir = {}

  var setupHandlers = function() {
    $('a[rel*=tipsy]').tipsy({gravity: $.fn.tipsy.autoNS})
  }
  var setupPagination = function() {
    $('.pagination a').live('click', function() {
      $('.pagination').html("<img src='/images/ajax-loader.gif' alt='Loading...' />")
      $.getScript(this.href)
      return false
    })
  }

  Hymir.App = {
    init: function() {
      setupHandlers()
      setupPagination()
    }
  }
})();

$(function() {
  Hymir.App.init()
});
