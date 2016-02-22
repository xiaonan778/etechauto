$(function(){
	$("#version_control").addClass("active");
    $("#tms").addClass("open");
    $("#tms").addClass("active");
    
    
   // var versionFlag = false;
    
    $("#qkcp_fk").change(function() {
    	getVersionName();
    	// checkVersionName();
    });
    
    function getVersionName() {
    	var qkcp_fk = $("#qkcp_fk").val();
        $.ajax({
            type : "POST",
            data : {qkcp_fk: qkcp_fk},
            url : _path + "/tms/getVersionsFromMesos",
            dataType : "json",
            success : function(data){
               var contents = "";
               if (data.msg == "S") {
            	   $("#version").show();
            	   $("#noVersion").remove();
            	   var versions = data.result;
            	   if (versions.length > 0) {
            		   $.each(versions, function(index, version){
                           contents = contents + "<option value='" + version.toString() + "'>" + version + "</option>";
                       });
                       $("#version").html(contents);
            	   } else {
            		  contents =  "<input id='noVersion' class='form-control' type='text' value='无可用版本'  readonly/>";
                 	  $("#version").after(contents);
                 	  $("#version").html("");
                 	  $("#version").hide();
            	   }
               } else {
            	  contents =  "<input id='noVersion' class='form-control' type='text' value='无可用版本'  readonly/>";
            	  $("#version").after(contents);
            	  $("#version").hide();
               }
            },
            error : function(msg, xhr, thrown) {
                
            }
        });

    }
    
    function checkVersionName(){
    	var version = $("#version").val();
    	var qkcp_fk = $("#qkcp_fk").val();
    	if (!!version) {
    		var valid = "<span id=\"versionValid\" class=\"help-block\">版本号已存在</span>";
    		$.ajax({
        		type : "POST",
        		data : {version: version, qkcp_fk: qkcp_fk},
        		url : _path + "/tms/checkVersionByName",
        		dataType : "json",
        		success : function(data){
        			if(data.msg == "S"){
        				versionFlag = true;
        				$("#versionError").html("");
        				$("#version").closest('.form-group').removeClass("has-error");
        			} else {
        				versionFlag = false;
        				$("#versionError").html(valid);
        				$("#version").closest('.form-group').addClass("has-error");
        			}
        		}
        	});
    	}else {
    		$("#versionError").html("");
    	}
    }
    
    
    $("#submit").click(function(){
    	if (!$("#version").val()) {
			$("#version").focus();
			alert("版本号不可为空！");
            return false;
		}
//    	if (!versionFlag) {
//    		$("#version").focus();
//			alert("版本名称已存在！");
//            return false;
//    	}
		if (!$("#createFile").val()) {
			$("#createFile").focus();
			alert("请选择初始化SQL文件！");
            return false;
		} else {
			var file =  $("#createFile").val();
			var dot = file.lastIndexOf(".");
			var type = file.substring(dot + 1);
			if (type.toUpperCase() != "SQL") {
				$("#createFile").focus();
				alert("请选择SQL脚本");
				return false;
			}
		}
		if (!$("#updateFile").val()) {
			$("#updateFile").focus();
			alert("请选择增量SQL文件！");
            return false;
		} else {
			var file =  $("#updateFile").val();
			var dot = file.lastIndexOf(".");
			var type = file.substring(dot + 1);
			if (type.toUpperCase() != "SQL") {
				$("#updateFile").focus();
				alert("请选择SQL脚本");
				return false;
			}
		}
		$("#myModalLabel").html("正在添加版本");
        $("#modalBody").html("请稍后...");
        $("#openModal").click();
        
		$("#mainForm").ajaxSubmit({
            type: "POST",
            url: _path + "/tms/addVersion",
            dataType: "json",
            success: function(data){
            	$("#closeModal").click();
            	if (data.msg == "success") {
            		bravoui.ui.msg.alert("版本添加成功！");
                    $(document).on("click", "#closeModal", function(){
                    	window.location = _path + "/tms/versionControl";
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