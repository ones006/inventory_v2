$(function() {
  set_autocomplete();
});

function set_autocomplete() {
  $('.plu_code').autocomplete(plu, {
    formatItem: function(row, i) { return row.plu.code; },
    mustMatch: true }
  )
  .result(function(event, data) {
    var input = $(this);
    if(data) {
      input.next('input[type=hidden]').val(data.plu.id);
      input.parent().next().html(data.plu.item_name_with_code);
      input.parent().next().next().children()[0].focus();
    }
    else input.next('input[type=hidden]').val('');
  });
}

$('#add_entries').live('click', function() {
  var entries_count = $('#transaction_entries tr').length - 1; // 1 is the table header, we're only intersted in rows with input fields in it
  $('#transaction_entries').append(entry_row(entries_count));
  return false;
});

$('input.entries_quantity').live('keypress', function(e) {
  if(e.keyCode == 13) {
    $('#add_entries').click();
    $('#transaction_entries tbody tr:last td:first').children()[0].focus();
    set_autocomplete();
    return false;
  }
});

function entry_row(count) {
  var idx = count;
  var html = "<tr><td class=\"td_30\">" +
    "<input type=\"text\" size=\"30\" name=\"item_transfer[entries_attributes]["+idx+"][plu_code]\" id=\"item_transfer_entries_attributes_"+idx+"_plu_code\" class=\"plu_code ac_input\" autocomplete=\"off\">" +
    "<input type=\"hidden\" name=\"item_transfer[entries_attributes]["+idx+"][plu_id]\" id=\"item_transfer_entries_attributes_"+idx+"_plu_id\" value=\"\">" +
    "</td> <td></td> <td class=\"actions td_10\">" +
    "<input type=\"text\" size=\"10\" name=\"item_transfer[entries_attributes]["+idx+"][quantity]\" id=\"item_transfer_entries_attributes_"+idx+"_quantity\" class=\"numbers entries_quantity\">" +
    "<input type=\"hidden\" name=\"item_transfer[entries_attributes]["+idx+"][item_id]\" id=\"item_transfer_entries_attributes_"+idx+"_item_id\">" +
    "</td></tr>";
  return html;
}
