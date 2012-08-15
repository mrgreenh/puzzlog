$(function(){
  //Popover
  $(".user_partial").each(function(){
      $(this).popover({
      placement:'left',
      animation:false,
      trigger: 'manual',
      content: $(this).find(".tooltip_content").html()
    }).click(function(){
    	
	      $(".user_partial").each(function(){
	        $(this).popover('hide');
	      });
	      $(this).popover('toggle');
	      $(".popover-inner a").click(function(){
	        $(this).parents(".popover").hide();
	      });
	      
    });
  });
  //Bio accorciata
  $(".user-bio p").dotdotdot();

});