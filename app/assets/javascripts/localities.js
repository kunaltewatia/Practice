
function mark_destroy(index){
  $("#locality_locality_services_attributes_" + index +"_service_id").click(function(){
    if($(this).prop("checked") === true){
      $("#locality_locality_services_attributes_" + index +"__destroy").val(false);
    }
    else if($(this).prop("checked") === false){
      $("#locality_locality_services_attributes_" + index +"__destroy").val(true);
    }
  });
}