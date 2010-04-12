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

$('#add_entries').live('click', function(e) {
  var entries_count = $('#transaction_entries tr').length - 1; // 1 is the table header, we're only intersted in rows with input fields in it
  $('#transaction_entries').append(entry_row(entries_count));
  return false;
});

$('input.entries_quantity, input.entries_value').live('keypress', function(e) {
  if(e.keyCode == 13 && $(this).val() != '') {
    $('#add_entries').click();
    $('#transaction_entries tbody tr:last td:first').children()[0].focus();
    set_autocomplete();
    return false;
  }
});

function entry_row(count) {
  var idx = count;
  var html = "<tr><td class=\"td_30\">" +
    "<input type=\"text\" size=\"30\" name=\""+model+"[entries_attributes]["+idx+"][plu_code]\" id=\""+model+"_entries_attributes_"+idx+"_plu_code\" class=\"plu_code ac_input\" autocomplete=\"off\">" +
    "<input type=\"hidden\" name=\""+model+"[entries_attributes]["+idx+"][plu_id]\" id=\""+model+"_entries_attributes_"+idx+"_plu_id\" value=\"\">" +
    "</td> <td></td> <td class=\"actions td_10\">" +
    "<input type=\"text\" size=\"10\" name=\""+model+"[entries_attributes]["+idx+"][quantity]\" id=\""+model+"_entries_attributes_"+idx+"_quantity\" class=\"numbers entries_quantity\">" +
    "<input type=\"hidden\" name=\""+model+"[entries_attributes]["+idx+"][item_id]\" id=\""+model+"_entries_attributes_"+idx+"_item_id\"></td>"; 
  if(window.with_value == true) {
    html += "<td class=\"actions td_30\"><input type=\"text\" size=\"30\" name=\""+model+"[entries_attributes]["+idx+"][value]\" id=\""+model+"_entries_attributes_"+idx+"_value\" class=\"numbers entries_value\"></td>"; 
  }
  html += "</tr>";
  return html;
}

function set_autocomplete() {
  $('.plu_code').autocomplete(plu, {
    formatItem: function(row, i) { return row.plu.code; },
    autoFill: true,
    mustMatch: true }
  )
  .result(function(event, data) {
    var input = $(this);
    if(data) {
      input.next('input[type=hidden]').val(data.plu.id);
      input.parent().next().html(data.plu.item_name_with_code);
      input.parent().next().next().children()[0].focus();
      event.stopImmediatePropagation();
    }
    // else input.next('input[type=hidden]').val('');
  });
}
