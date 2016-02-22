$(function(){
	$("#tms_update").addClass("active");
    $("#tms").addClass("open");
    $("#tms").addClass("active");
    
    $("#versionHistory").select({
        change: function (value, label) {
        	var arr = value.split("#");
        	var versionId = arr[0];
        	var historyId = arr[1];;
        	$("#newVersion").val(versionId );
        	$("#historyId").val(historyId );
        },
	    width: 300
    });
    
    $("#submit").click(function(){
    	if ( !$("#newVersion").val() ) {
    		bravoui.ui.msg.alert("历史版本无效!");
    		return false;
    	}
    	bravoui.ui.msg.confirm({ 
    		title : "警告",
    		msg : "本次升级后的新增数据将会丢失，请谨慎操作！ 因本次升级的租户配置信息也将被回退，请在回退成功后对租户重新配置!",
    		ok : function(){
    			bravoui.ui.msg.waiting({
                	title : "正在回退版本",
                	msg : "请稍后..."
                });
    			submitForm();
    		}
    	});
	});
    

    function submitForm() {
		$("#mainForm").ajaxSubmit({
			type : "POST",
			url : _path + "/tms/tenantVersionRollBack",
			dataType : "json",
			success : function(data) {
				bravoui.ui.msg.waiting.remove();
				if (data.msg == "success") {
					bravoui.ui.msg.alert({
						msg : "版本回退成功！",
						ok : function() {
							window.location = _path + "/tms/updateView";
						}
					});
				} else {
					bravoui.ui.msg.alert(data.msg);
				}
			},
			error : function(xhr, msg, error) {
				bravoui.ui.msg.waiting.remove();
				if ("timeout" == msg || "parsererror" == msg) {
					bravoui.ui.msg.alert({
						msg : "对不起，session过期，请重新登录!",
						ok : function() {
							window.location.reload();
						}
					});
				} else {
					bravoui.ui.msg.alert("Internal Server Error!");
				}
			}
		});
	}
    
});