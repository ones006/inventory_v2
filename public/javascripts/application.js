$(function() {
  $('input.default').focus();
});

$('#sidemenu li a.revealer').click(function() {
  $(this).next('ul').toggle();
  return false;
});
