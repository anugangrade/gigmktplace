$(document).ready(function(){

  $("#quantity").change(function(){
    var value = ($(this).val() *5 )
    $(".order_link").val('Order Now($'+(value)+')')
    $(".order_link").text('Order Now($'+(value)+')')
  })

  $("#gig_express_boolean").change(function(){
    if ($(this).is(':checked')) {
      $(".delivery_block").hide()
    }
    else{
      $(".delivery_block").show()
    }
  })



  $(".quantity").change(function(){
    extragig_id = this.id.split("_")[1]
    
    $("#checkbox_"+extragig_id).prop('checked', true);

    $.each($('.quantity'), function(index, value){
      var gig_id = $(value).attr("id")
      var gig_value = $(value).val()
      if (gig_id == "quantity") {
        amount = (gig_value*5)
      }
      else{
        if ($("#checkbox_"+gig_id.split("_")[1]).is(':checked')) {
          amount += ((gig_value.split("_")[0]) * (gig_value.split("_")[1]) )
        }
      }
    });
    $(".order_link").val('Order Now($'+(amount)+')')
    $(".order_link").text('Order Now($'+(amount)+')')
  })

  $(".extra_checkbox").change(function(){
    if ($(this).is(':checked')) {
      $.each($('.quantity'), function(index, value){
        var gig_id = $(value).attr("id")
        var gig_value = $(value).val()
        if (gig_id == "quantity") {
          amount = (gig_value*5)
        }
        else{
          if ($("#checkbox_"+gig_id.split("_")[1]).is(':checked')) {
            amount += ((gig_value.split("_")[0]) * (gig_value.split("_")[1]) )
          }
        }
      });
    }
    else{
      $.each($('.quantity'), function(index, value){
        var gig_id = $(value).attr("id")
        var gig_value = $(value).val()
        if (gig_id == "quantity") {
          amount = (gig_value*5)
        }
        else{
          if ($("#checkbox_"+gig_id.split("_")[1]).is(':checked')) {
            amount += ((gig_value.split("_")[0]) * (gig_value.split("_")[1]) )
          }
        }
      });
    }
    $(".order_link").val('Order Now($'+(amount)+')')
    $(".order_link").text('Order Now($'+(amount)+')')
  })

  $("abbr.timeago").timeago();
  $('a').tooltip();
});