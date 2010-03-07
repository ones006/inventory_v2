$('a.category_detail').live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: this.innerHTML,
    closeText: "<img src='images/icons/cross.png' alt='close'/>"
  });
  return false;
});

$('a.new_category').live('click', function() {
  Boxy.load(this.href, {
    modal: true,
    title: "Create New Category",
    closeText: "<img src='images/icons/cross.png' alt='close'/>",
    afterShow: function() {
      $('input#category_parent_name').autocomplete(categories).select();
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
              $('input#category_parent_name').autocomplete(categories).select();
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
    afterShow: function() {
      $('input#category_parent_name').autocomplete(categories).select();
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
              $('input#category_parent_name').autocomplete(categories).select();
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

