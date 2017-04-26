$(document).ready(function(){
  $(function() {
    $("#autocomplete").autocomplete({
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
        $("#autocomplete").val(ui.item.label);
        $("#complaint_mobile_user_id").val(ui.item.value);
        return false;
      }
    });
  });
});

$(document).on('focus',"#complaint_date", function(){

  function removeDays(theDate, days) {
    return new Date(theDate.getTime() - days*24*60*60*1000);
  }
  var maxdate = new Date();
  if(maxdate.getDay() < 3){
    day = 3;
  }else{
    day = 2;
  }
  var mindate = removeDays(maxdate, day)

  $('#complaint_date').datepicker({
    dateFormat: 'dd M yy',
    changeMonth: true,
    changeYear: true,
    maxDate: maxdate,
    minDate: mindate,
    beforeShowDay: function(date){
      var day = date.getDay();
      return [(day !== 0), ''];
    }
  });
});