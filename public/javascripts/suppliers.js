$(function() {
  $("input#supplier_code").select();
});

$("form#supplier_form").live('submit', function() {
  $(this).find('button[type=submit]')
  .replaceWith("<p><img src='/images/ui-anim.basic.16x16.gif' alt=''/> <span>Saving... please wait</span></p>");
});

$('a.detail').live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: "Detail " + this.innerHTML,
    closeText: "<img src='/images/icons/cross.png' alt='close'/>"
  });
  return false;
});

$(".alter_record").live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: this.title,
    closeText: "<img src='/images/icons/cross.png' alt='close'/>",
    afterShow: function() {
      $('input#supplier_code').select();
      $('form#supplier_form').live('submit', function() {
        var form = $("div#dialog_form");
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
        return false;
      });
    }
  });
  return false;
}); 
