
$(function() {
	
	$(document).on("click", "#sidebar-collapse", function(){
		if(!$("#sidebar").hasClass("menu-min")){
			$.cookie("menumin", "1", { expires: 7, path: '/benchmark/' });  
		}else{
			 $.cookie("menumin", "0", { expires: 7, path: '/benchmark/' });  
		}
    });
	
	var menuflag = $.cookie("menumin");
	if(menuflag == "1"){
		$("#sidebar").addClass("menu-min");
		$("#sidebararrow").removeClass().addClass("icon-double-angle-right");
	}else{
		$("#sidebar").removeClass("menu-min");
		$("#sidebararrow").removeClass().addClass("icon-double-angle-left");
	}
});

