$(document).ready(function(){
  $(document).on('change', "#subscription_pack_id", function(){
    $.ajax({
      url: "/plans/list",
      type: 'get',
      data: { pack_id: $(this).val() },
      success: function(data) {
        $('#subscription_plan_id').empty();
        $('#subscription_plan_id')
          .append("<option>Select Plan</option>");
        var options = [];
        $.each(data.plans, function(index, wing) {
          $option = $("<option></option>").attr("value", wing.id)
            .text(wing.name);
          $('#subscription_plan_id').append($option);
        });
      }
    });
  });
});