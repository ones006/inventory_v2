$(function() {
  set_autocomplete();
  $('.plu_source').change(function() {
    $.getJSON('/warehouses/' + $(this).val() + '/plu_available',
      function(json) {
        window.plu = eval('('+json.plus+')');
        set_autocomplete();
      });
  });
});

