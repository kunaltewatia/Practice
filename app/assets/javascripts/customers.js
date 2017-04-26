$(document).ready(function(){
  function getData(params, callback){
    $.ajax({
      url: params['url'] ,
      type: 'get',
      data: params['data'],
      success: function(data) {
        callback(data);
      }
    });
  }

  var onChangeCountry = function(data) {
    $('#customer_address_attributes_state_id')
      .html("<option>Select State</option>");
    populateOptions(data.states, $('#customer_address_attributes_state_id'));
  }

  var onChangeState = function(data) {
    $('#customer_address_attributes_city_id')
      .html("<option>Select City</option>");
    populateOptions(data.cities, $('#customer_address_attributes_city_id'));
  }

  var onChangeCity = function(data){
    $('#customer_address_attributes_area_id')
      .html("<option>Select Area</option>");
    populateOptions(data.areas, $('#customer_address_attributes_area_id'));
  }

  var onChangeArea = function(data){
    $('#customer_address_attributes_locality_id')
      .html("<option>Select Locality</option>");
    populateOptions(data.localities, $('#customer_address_attributes_locality_id'));
  }

  var onChangeLocality = function(data){
    $('#customer_address_attributes_society_id')
      .html("<option>Select Society</option>");
    populateOptions(data.societies, $('#customer_address_attributes_society_id'));
  }

  var onChangeSociety = function(data){
    $('#customer_address_attributes_wing_id')
      .html("<option>Select Wing</option>");
    populateOptions(data.wings, $('#customer_address_attributes_wing_id'));
  }

  var populateOptions = function(data, element) {
    var options = [];
    $.each(data, function(index, value) {
      $option = $("<option></option>").attr("value", value.id)
        .text(value.name);
      $(element).append($option);
    });
  }

  $("#customer_address_attributes_country_id").click(function(){
    params = {
      'url' : '/states/list',
      'data' : { country_id: $(this).val() }
    };
    getData(params, onChangeCountry);
  });



  $("#customer_address_attributes_state_id").click(function(){
    params = {
      'url' : '/cities/list',
      'data' : { state_id: $(this).val() }
    };
    getData(params, onChangeState);
  });

  $("#customer_address_attributes_city_id").click(function(){
    params = {
      'url' : '/areas/list',
      'data' : { city_id: $(this).val() }
    };
    getData(params, onChangeCity);
  });

  $("#customer_address_attributes_area_id").click(function(){
    params = {
      'url' : '/localities/list',
      'data' : { area_id: $(this).val() }
    };
    getData(params, onChangeArea);
  });

  $("#customer_address_attributes_locality_id").click(function(){
    params = {
      'url' : '/societies/list',
      'data' : { locality_id: $(this).val() }
    };
    getData(params, onChangeLocality);
  });

  $("#customer_address_attributes_society_id").click(function(){
    params = {
      'url' : '/wings/list',
      'data' : { society_id: $(this).val() }
    };
    getData(params, onChangeSociety);
  });

  // Filter code
  var onFilterArea = function(data){
    $('#f_locality').html("<option value=''>Select Locality</option>");
    populateOptions(data.localities, $('#f_locality'));
  }

  var onFilterLocality = function(data){
    $('#f_society').html("<option value=''>Select Society</option>");
    populateOptions(data.societies, $('#f_society'));
  }

  var onFilterSociety = function(data){
    $('#f_wing')
      .html("<option value=''>Select Wing</option>");
    populateOptions(data.wings, $('#f_wing'));
  }

  $("#f_area").click(function(){
    params = {
      'url' : '/localities/list',
      'data' : { area_id: $(this).val() }
    };
    getData(params, onFilterArea);
  });

  $("#f_locality").click(function(){
    params = {
      'url' : '/societies/list',
      'data' : { locality_id: $(this).val() }
    };
    getData(params, onFilterLocality);
  });

  $("#f_society").click(function(){
    params = {
      'url' : '/wings/list',
      'data' : { society_id: $(this).val() }
    };
    getData(params, onFilterSociety);
  });

  $('.search-reset').click(function(){
    $('#name').val("");
    $('#contact').val("");
    return false;
  });

  //by default set the div hide
 // $('#customer_filter').hide();
  $('#customer_search').hide();

  $('.filter-reset').click(function(){
    $('#f_name').val("");
    $('#f_address').val("");
    $('#type').val("");
    $('#app_status').val("");
    $('#subs_status').val("");
    $('#pay_status').val("");

    $('#f_area').val("");
    $('#f_locality').val("");
    $('#f_society').val("");
    $('#f_wing').val("");
    return false;
  });

  // $('.btn-filter').click(function(){
  //   $('#customer_filter').slideToggle();
  // });
  $('.btn-search').click(function(){
    $('#customer_search').slideToggle();
  });
});
