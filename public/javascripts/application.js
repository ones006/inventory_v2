$(function() {
  $('input.default').focus();
});

$('#sidemenu li a.revealer').click(function() {
  $(this).next('ul').toggle();
  return false;
});

function boxy_ajaxify(formwrapper) {
  var form = formwrapper;
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
}
