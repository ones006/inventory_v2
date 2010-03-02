$(document).ready(function() {
  $('#sidemenu li a').click(function() {
    $(this).next('ul').toggle();
  });
});
