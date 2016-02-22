$(function(){
	$("#tms_update").addClass("active");
    $("#tms").addClass("open");
    $("#tms").addClass("active");
    
    $("#newVersion").select({
        change: function (value, label) {},
	    width:300
    });
    
    $("#submit").click(function(){
    	if ( !$("#newVersion").val() ) {
    		bravoui.ui.msg.alert("新版本无效!");
    		return false;
    	}
		$("#myModalLabel").html("正在升级版本");
        $("#modalBody").html("请稍后...");
        $("#openModal").click();
        
		$("#mainForm").ajaxSubmit({
            type: "POST",
            url: _path + "/tms/appUpdate",
            dataType: "json",
            success: function(data){
            	$("#closeModal").click();
            	if (data.msg == "success") {
            		bravoui.ui.msg.alert("版本升级成功！");
                    $(document).on("click", "#closeModal", function(){
                    	window.location = _path + "/tms/updateView";
                    });
            	} else {
            		bravoui.ui.msg.alert(data.msg );
            	}
            },  
            error : function(xhr, msg, error) {  
            	$("#closeModal").click();
            	if ("timeout" == msg || "parsererror" == msg) {
                    bravoui.ui.msg.alert("对不起，session过期，请重新登录!");
                    $(document).on("click", "#closeModal", function(){
                        window.location.reload();
                    });
                } else {
                    bravoui.ui.msg.alert("Internal Server Error!");
                }
            }  
        });
	});
});