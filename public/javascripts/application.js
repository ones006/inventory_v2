$(function() {
  $('input.default').focus();
  // animate the sidebar links
  $("#sidemenu li a").hover(
    function() { $(this).animate({ 'padding-left': '+=10' }, 100); },
    function() { $(this).animate({ 'padding-left': '-=10' }, 100); }
  );
});

$('#sidemenu li a.revealer').click(function() {
  $(this).next('ul').toggle();
  return false;
});
