$(function() {
  $("input#warehouse_code").select();
});

$("form#warehouse_form").live('submit', function() {
  $(this).find('button[type=submit]')
  .replaceWith("<p><img src='/images/ui-anim.basic.16x16.gif' alt=''/> <span>Saving... please wait</span></p>");
});

$(".new_edit_warehouse").live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: this.title,
    closeText: "<img src='/images/icons/cross.png' alt='close'/>",
    afterShow: function() {
      $('.firerift-style-checkbox').each(function() {
        thisID    = $(this).attr('id');
        thisClass = $(this).attr('class');
        setClass = "firerift-style";
        $(this).addClass('hidden');
        if($(this)[0].checked == true)
          $(this).after('<div class="'+ setClass +' on" rel="'+ thisID +'">&nbsp;</div>');
        else
          $(this).after('<div class="'+ setClass +' off" rel="'+ thisID +'">&nbsp;</div>');
      });
      $('input#warehouse_code').select();
      $('form#warehouse_form').live('submit', function() {
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
