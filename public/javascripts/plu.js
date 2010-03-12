var item_name = $('input#plu_item_name');
var item_id = $('input#plu_item_id');
var supplier_name = $('input#plu_supplier_name');
var supplier_id = $('input#plu_supplier_id');

$(function() {
  item_name.select();
  set_autocomplete();
});

$('form#plu_form').live('submit', function() {
  $(this).find('button[type=submit]')
  .replaceWith('<p><img src="/images/ajax-loader.gif" alt="" /> <span>saving... please wait</span></p>');
  return true;
});

function set_autocomplete() {
  item_name.autocomplete(items, {
    formatItem: function(row, i) { return row.item.name; },
    mustMatch: true
  })
  .result(function(event, data) {
    if(data) item_id.val(data.item.id);
    else item_id.val('');
  });
  supplier_name.autocomplete(suppliers, {
    formatItem: function(row, i) { return row.supplier.name; },
    mustMatch: true
  })
  .result(function(event, data) {
    if(data) supplier_id.val(data.supplier.id);
    else supplier_id.val('');
  });
}
