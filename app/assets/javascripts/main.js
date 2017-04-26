jQuery(document).ready(function(){

    if($("#order_area_id" ).val() != ''){
        $('.hideBeforeSelect').show();
    }else{
        $('.hideBeforeSelect').hide();
    }
    $( "#order_area_id" ).change(function() {
        console.info('hi');
      if($(this).val() != ''){

        console.info('value hi');
        $('.hideBeforeSelect').slideDown(700);
      }else{
        $('.hideBeforeSelect').slideUp(700);
      }
    });
    // This button will increment the value
    $.validate();
    $('.qtyplus').click(function(e){
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        fieldName = $(this).attr('field');
        // Get its current value
        var currentVal = parseInt($('#order_unit').val());
        // If is not undefined
        if (!isNaN(currentVal)) {
            // Increment
            $('#order_unit').val(currentVal + 1);
        } else {
            // Otherwise put a 0 there
            $('#order_unit').val(1);
        }
    });
    // This button will decrement the value till 0
    $(".qtyminus").click(function(e) {
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        fieldName = $(this).attr('field');
        // Get its current value
        var currentVal = parseInt($('#order_unit').val());
        // If it isn't undefined or its greater than 0
        if (!isNaN(currentVal) && currentVal > 1) {
            // Decrement one
            $('#order_unit').val(currentVal - 1);
        } else {
            // Otherwise put a 0 there
            $('#order_unit').val(1);
        }
    });

    $('input, textarea').keyup(function(){
        var iV = $(this).val();
        if(iV == ""){
            $(this).removeClass('show');
        }else{
            $(this).addClass('show');
        }
    })

    $('select').change(function(){
        var iV = $(this).val();
        if(iV == ""){
            $(this).removeClass('show');
        }else{
            $(this).addClass('show');
        }
    })

    function getData(quantity_id, plan_id) {
        $.ajax({
          url : '/home/calc_price.json',
          type: 'POST',
          data : { 'plan_id': plan_id, 'unit': quantity_id },
          success: function(data, textStatus, jqXHR){
            $("#price").html("Rs."+ data['price'] +"/-");
            if(data['discount'] != 0){
              $(".discountWrap").show();
              $(".discountWrap").html(data['text']);
              var price = parseInt(data['price']) + parseInt(data['discount']);
              $("#base_price").html("Rs."+ price +"/-");
              $("#saving").show();
              $("#saving").html("Your Savings: Rs." + data['discount'] + "/-");
              $("#price1").html("Rs."+ data['price'] +"/-");
            }else{
              $(".discountWrap").hide();
              $('#base_price').html("");
              $("#saving").hide();
              $("#price1").html("Rs."+ data['price'] +"/-");
            }
          },
          error: function (jqXHR, textStatus, errorThrown){
            alert(textStatus);
          }
        })
    }
    if($('input').hasClass('moreQuantity')){
        var quantity_id = $('#order_unit').val();
        var plan_id = $("#order_plan_id").val();
        quantity_id = parseInt(quantity_id);
        getData(quantity_id, plan_id);
    }

    $(".qtyplus").click(function(){
        var quantity_id = $('#order_unit').val();
        var plan_id = $("#order_plan_id").val();
        quantity_id = parseInt(quantity_id);
        getData(quantity_id, plan_id);
        $('button.buyNow').addClass('heightChange');
        setTimeout(function(){
            $('button.buyNow').removeClass('heightChange');
        },500)
    });

    $(".qtyminus").click(function(){
        var quantity_id = $('#order_unit').val();
        var plan_id = $("#order_plan_id").val();
        if(parseInt(quantity_id) >= 1){
          quantity_id = parseInt(quantity_id);
          getData(quantity_id, plan_id)
        }
        $('button.buyNow').addClass('heightChange');
        setTimeout(function(){
            $('button.buyNow').removeClass('heightChange');
        },500)
    });

    $('input#order_unit').bind("change",function() {
        var quantity_id = $('#order_unit').val();
        var plan_id = $("#order_plan_id").val();
        getData(quantity_id, plan_id)
    });

    /*$('a.popup').click(function(){
        $('.overlay').css({
            display:'block'
        })
        return false;
    })*/
    $('.overlay .redClose').click(function(){
        $('.overlay').css({
            display:'none'
        })
        return false;
    })
    /*$('.dropdown-toggle').click(function() {
      $(this).next('.dropdown-menu').slideToggle(500);
    });*/
});