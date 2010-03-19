var item_category = $('input#begining_balance_category_name');

$(function() {
  set_autocomplete();
});

function set_autocomplete() {
  item_category.autocomplete(categories, {
    formatItem: function(row, i) { return row.category.name; },
    mustMatch: true
  })
  .result(function(event, data) {
    if(data) {
      $.ajax({
        url: '/categories/' + data.category.id + '/items_for_begining_balance',
        success: function(response, status) {
          $('#items').html(response);
        }
      });
    }
  });
}
