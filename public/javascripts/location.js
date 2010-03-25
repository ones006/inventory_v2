if(window.locations) {
  set_autocomplete();
}
$('.new_locationx').click(function() {
  Boxy.load(this.href, {
    modal: true,
    title: this.title,
    closeText: "<img src='/images/icons/silk/cross.png' alt='' />",
    afterShow: function() {
      set_autocomplete();
      $('.default').select();
      $('form#new_location').live('submit', function() {
        var form = $('div#dialog_form');
        var button = form.find("button[type=submit]");
        button.replaceWith("<p><img src='/images/ui-anim.basic.16x16.gif' alt=''/> <span>Saving... please wait</span></p>");
        $.ajax({url: this.action,
          data: $(this).serialize(),
          type: 'post',
          success: function(response, status) {
            if(response.status == 'validation error') {
              form.replaceWith(response.form);
            } else {
              window.location = response.location
            }
          }
        });
      });
    }
  });
  return false;
});

function set_autocomplete() {
  $('#location_parent_code').autocomplete(locations, {
    formatItem: function(row, i) { return row.location.code; },
    mustMatch: true
  });
}
