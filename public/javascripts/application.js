(function() {
  window.Hymir = {}

  Hymir.App = {
    init: function() {
      this.setupTipsy();
      this.setupFlashFade();
      this.setupActionHover();
      this.setupAJAXDestroy();
    },

    setupTipsy: function() {
      $('a[rel*=tipsy]').tipsy({gravity: $.fn.tipsy.autoNS});
    },

    setupFlashFade: function() {
      flash_div = $('#flash_notice, #flash_error');
      flash_div.hide().slideDown(350);
      flash_div.delay(5000).slideUp(700);
    },

    setupActionHover: function() {
      $('.actions').hide();
      $('.has-actions').hover(
        function() { $(this).find('.actions').fadeIn(100); },
        function() { $(this).find('.actions').fadeOut(100); }
      );
    },

    setupAJAXDestroy: function() {
      $('a.destroy').live('click', function(event) {
        if (confirm('Are you sure?')) {
          link = $(this)
          parent = link.parents('.has-actions:first');
          $.ajax({
            url: link.attr('href'),
            type: 'DELETE',
            beforeSend: function() {
              link.html("<img src='/images/ajax-loader.gif' alt='Loading' />");
            },
            success: function() {
              parent.fadeOut(500, function() {
                parent.remove();
              });
            }
          });
        }
        return false;
      });
    }
  }
})();

$(function() {
  Hymir.App.init();
});
