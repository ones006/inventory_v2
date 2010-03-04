$(document).ready(function() {
  $('input.default').focus();
  $('#sidemenu li a').click(function() {
    $(this).next('ul').toggle();
  });
});
