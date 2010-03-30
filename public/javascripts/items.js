var unit_length = 0;
var categories;

$(function() {
  unit_length = $('#units ol li').length;
  set_autocomplete();
});

function set_autocomplete() {
  var item_category_code = $('#item_category_code');
  var item_category_id = $('#item_category_id');
  var item_code = $('#item_code');
  item_category_code.select();
  item_category_code.autocomplete(categories, {
    formatItem: function(row, i) { return row.category.formatted_code; },
    mustMatch: true
  })
  .result(function(event, data) {
    if(data) {
      item_category_id.val(data.category.id);
      item_code.val(data.category.code_for_item).focus();
    }
    else item_category_id.val('');
  });
}

$("a#add_unit").live('click', function() {
  $("#units ol").append(new_unit_form(unit_length));
  return false;
});
      
function new_unit_form(n) {
  var html = "<li class=\"additional_units\"><label for=\"item_units_attributes_"+n+"_name\">Name</label> " +
    "<input type=\"text\" name=\"item[units_attributes]["+n+"][name]\" id=\"item_units_attributes_"+n+"_name\" size=\"20\" /> " +
    "<label for=\"item_units_attributes_"+n+"_name\">Conversion rate</label> " +
    "<input type=\"text\" size=\"5\" name=\"item[units_attributes]["+n+"][conversion_rate]\" id=\"item_units_attributes_"+n+"_name\" /> " +
    "<input type=\"hidden\" name=\"_destroy\" id=\"\" />" +
    "<a title=\"remove unit\" href=\"#\" class=\"unit_remover\"><img src=\"/images/icons/silk/cross.png?1260336846\" alt=\"Cross\"></a>" +
    "</li>";
  return html;
}

$("a.unit_remover").live('click', function() {
  $(this).prev('input[type=hidden]').val(1);
  $(this).parents('li').hide();
  return false;
});
$("#item_form").live("submit", function() {
  $(this).find('button[type=submit]')
  .replaceWith("<p><img src='/images/ui-anim.basic.16x16.gif' alt=''/> <span>Saving... please wait</span></p>");
});

$(".item_detail").live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: this.innerHTML,
    closeText: "<img src='images/icons/cross.png' alt='close'/>"
  });
  return false;
});

$('#items tr').live('click', function() {
  $.ajax({
    url: $(this).find('td a.item_detail').attr('href'),
    success: function(respond, status) {
      $('#item_detail').html(respond);
    },
    error: function(xhr, status, e) { alert(status); }
  });
  return false;
});
/*
$(".new_item, .edit_item").live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: this.title,
    closeText: "<img src='/images/icons/cross.png' alt='close'/>",
    afterShow: function() {
      $('input#item_category_name').autocomplete(categories);
      $('input#item_code').select();
      $('form#item_form').live('submit', function() {
        var form = $("div#dialog_form");
        var button = form.find("button[type=submit]");
        button.replaceWith("<p><img src='images/ui-anim.basic.16x16.gif' alt=''/> <span>Saving... please wait</span></p>");
        $.ajax({url: this.action,
          data: $(this).serialize(),
          type: 'post',
          success: function(response, status) {
            if(response.status == 'validation error') {
              form.replaceWith(response.form);
              $('input#item_category_name').autocomplete(categories);
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
*/
