$(function(){
	$("#tms_update").addClass("active");
    $("#tms").addClass("open");
    $("#tms").addClass("active");
    
    /****************************************************************/
    $("#submit").click(function(){
    	var flag = false;
    	var sizeFlag = true;
    	$(".container_size_new").each(function(index){
    		var value = $(this).val();
    		if(!!value){
    			var size = parseInt(value);
    			if (isNaN(size)) {
    				$(this).focus();
    				sizeFlag = false;
    				alert("请填写1到5之间的数字");
    				return false;
    			} else {
    				if (size <= 0 || size > 5) {
    					$(this).focus();
    					sizeFlag = false;
        				alert("请填写1到5之间的数字");
        				return false;
    				} else {
    					sizeFlag = true;
    				}
    			}
    			flag = true;
    		}
    	});
    	if (!sizeFlag) {
    		return false;
    	}
    	if (flag === false) {
    		alert("请至少填写一个新容器数！");
    		return false;
    	}
    	
    	
		$("#myModalLabel").html("正在扩容");
        $("#modalBody").html("请稍后...");
        $("#openModal").click();
        
		$("#mainForm").ajaxSubmit({
            type: "POST",
            url: _path + "/tms/addContainer",
            dataType: "json",
            success: function(data){
            	$("#closeModal").click();
            	if (data.msg == "success") {
            		bravoui.ui.msg.alert("扩容成功！");
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
    /****************************************************************/
    
});