var categories = [];

$(function() {
    set_autocomplete();
});

function set_autocomplete() {
  var category_parent_code = $('#category_parent_code');
  var category_parent_id = $('#category_parent_id');
  category_parent_code.select();
  category_parent_code.autocomplete(categories, {
    formatItem: function(row, i) { return row.category.fullcode; },
    mustMatch: true
  })
  .result(function(event, data) {
    if(data) category_parent_id.val(data.category.id);
    else category_parent_id.val('');
  });
}

$('a.category_detail').live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: this.innerHTML,
    closeText: "<img src='images/icons/cross.png' alt='close'/>"
  });
  return false;
});

$('a.new_category').click(function() {
  Boxy.load(this.href, {
    modal: true,
    title: "Create New Category",
    closeText: "<img src='images/icons/cross.png' alt='close'/>",
    unloadOnHide: true,
    afterShow: function() {
      set_autocomplete();
      $('form#category_form').live('submit', function() {
        var form = $("div#dialog_form");
        var button = form.find("button[type=submit]");
        button.replaceWith("<p><img src='images/ui-anim.basic.16x16.gif' alt=''/> <span>Saving... please wait</span></p>");
        $.ajax({url: this.action,
          data: $(this).serialize(),
          type: 'post',
          success: function(response, status) {
            if(response.status == 'validation error') {
              form.replaceWith(response.form);
              set_autocomplete();
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

$('a.edit_category').live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: this.title,
    closeText: "<img src='images/icons/cross.png' alt='close'/>",
    unloadOnHide: true,
    afterShow: function() {
      set_autocomplete();
      $('form#category_form').live('submit', function() {
        var form = $("div#dialog_form");
        var button = form.find("button[type=submit]");
        button.replaceWith("<p><img src='images/ui-anim.basic.16x16.gif' alt=''/> <span>Saving... please wait</span></p>");
        $.ajax({url: this.action,
          data: $(this).serialize(),
          type: 'post',
          success: function(response, status) {
            if(response.status == 'validation error') {
              form.replaceWith(response.form);
              set_autocomplete();
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

