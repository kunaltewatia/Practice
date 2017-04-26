$(document).ready(function(){
  $('a[name=localities]').click(function(e){
    var area =  $("#society_area_id").val();
    if (area === null || area === ''){
      alert('Select Area first');
      return false;
     }
  });

  $("#society_area_id").change(function(){
    $.ajax({
      url: "/localities/list",
      type: 'get',
      data: { area_id: $(this).val() },
      success: function(data) {
        $('#society_locality_id').empty();
        $('#society_locality_id').append("<option>Select Locality</option>");
        var options = [];
        $.each(data.localities, function(index, locality) {
          $option = $("<option></option>").attr("value", locality.id)
            .text(locality.name);
          $('#society_locality_id').append($option);
        });
      }
    });
  });
});