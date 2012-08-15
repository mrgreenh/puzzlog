//Stateful loading buttons: classi .stateful_loading e attributo data-loading-text
function stateful_loading(){
	var bottone = $(".stateful_loading");
	var text = bottone.attr("data-loading-text");
	bottone.val(text);
	bottone.attr("disabled","disabled");
}
