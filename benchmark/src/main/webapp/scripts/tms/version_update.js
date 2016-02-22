$(function(){
	$("#version_control").addClass("active");
    $("#tms").addClass("open");
    $("#tms").addClass("active");
    
    $("#valid").select({
        change: function (value, label) {},
	    width:200
    });
    
    $("#submit").click(function(){
		if ($("#createFile").val()) {
			var file =  $("#createFile").val();
			var dot = file.lastIndexOf(".");
			var type = file.substring(dot + 1);
			if (type.toUpperCase() != "SQL") {
				$("#createFile").focus();
				alert("请选择SQL脚本");
				return false;
			}
		}
		if ($("#updateFile").val()) {
			var file =  $("#updateFile").val();
			var dot = file.lastIndexOf(".");
			var type = file.substring(dot + 1);
			if (type.toUpperCase() != "SQL") {
				$("#updateFile").focus();
				alert("请选择SQL脚本");
				return false;
			}
		}
		$("#myModalLabel").html("正在更新版本信息");
        $("#modalBody").html("请稍后...");
        $("#openModal").click();
        
		$("#updateForm").ajaxSubmit({
            type: "POST",
            url: _path + "/tms/updateVersion",
            dataType: "json",
            success: function(data){
            	$("#closeModal").click();
            	if (data.msg == "success") {
            		bravoui.ui.msg.alert("版本信息更新成功！");
                    $(document).on("click", "#closeModal", function(){
                    	window.location = _path + "/tms/versionControl";
                    });
            	} else {
            		bravoui.ui.msg.alert(data.msg );
            		$(document).on("click", "#closeModal", function(){
                        window.location.reload();
                    });
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
                    $(document).on("click", "#closeModal", function(){
                        window.location.reload();
                    });
                }
            }  
        });
	});
    
    
});