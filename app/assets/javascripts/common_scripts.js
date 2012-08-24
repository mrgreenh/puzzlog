//Stateful loading buttons: classi .stateful_loading e attributo data-loading-text
function stateful_loading(){
	var bottone = $(".stateful_loading");
	var text = bottone.attr("data-loading-text");
	bottone.val(text);
	bottone.attr("disabled","disabled");
}

$(function(){
	//Popover with partial's controls
  $(".fragment_view,.fragment_summary,.user_partial").each(function(){
      $(this).popover({
      placement:'left',
      animation:false,
      trigger: 'manual',
      content: $(this).find(".tooltip_content").html()
    }).click(function(){
    	
	      $(".fragment_view,.fragment_summary,.user_partial").each(function(){
	        $(this).popover('hide');
	      });
	      $(this).popover('toggle');
	      $(".popover-inner a").click(function(){
	        $(this).parents(".popover").hide();
	      });
	      
    });
  });
  
});
