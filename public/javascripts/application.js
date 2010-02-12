(function() {
  window.Hymir = {}

  Hymir.App = {
    init: function() {
      this.setupTipsy();
      this.setupFlashFade();
      this.setupActionHover();
    },

    setupTipsy: function() {
      $('a[rel*=tipsy]').tipsy({gravity: $.fn.tipsy.autoNS});
    },

    setupFlashFade: function() {
      flash_div = $('#flash_notice, #flash_error');
      flash_div.hide();
      flash_div.slideDown(350);
      flash_div.delay(5000).slideUp(700);
    },

    setupActionHover: function() {
      $('.actions').hide();
      $('.content, .post_comment').hover(
        function() { $(this).find('.actions').fadeIn(100); },
        function() { $(this).find('.actions').fadeOut(100); }
      );
    }
  }
})();

$(function() {
  Hymir.App.init();
});
