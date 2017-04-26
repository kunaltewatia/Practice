$(document).ready(function(){
  $(function() {
    $("#referrer").autocomplete({
      minLength: 3,
      source: function(request, response) {
        $.getJSON("/customers/search?name=" + request.term, {
        }, function(data) {
          // data is an array of objects and must be transformed for autocomplete to use
          var array = data.error ? [] : $.map(data.customers, function(m) {
            return {
              label: m.first_name + ' ' + m.last_name + ' (' + m.mobile_number + ')',
              value: m.id
            };
          });
          response(array);
        });
      },
      select: function(event, ui) {
        // prevent autocomplete from updating the textbox
        $("#referrer").val(ui.item.label);
        $("#referral_mobile_user_id").val(ui.item.value);
        return false;
      }
    });
  });
});