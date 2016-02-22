
var validator = null;
$().ready(function() { 
	$("#tms_list").addClass("active");
    $("#tms").addClass("open");
    $("#tms").addClass("active");
    
	validator= $('#tenant_edit_form').validate({
    errorElement : 'span',  
        errorClass : 'help-block',  
        focusInvalid : false,  
        rules : {  
        	name : {  
                required : true,
                rangelength:[0,20]
            }, 
            name_apk : {  
                required : true,
                rangelength:[0,30]
            },  
            ver_apk : {  
                required : true,
                rangelength:[0,30]
            },  
            domain : {  
                required : true,
                isEnglishNum:true,
                rangelength:[0,50]
            },
            pad_count: {  
                required : true,
                rangelength:[0,10],
                digits: "只能输入整数"
            },
            app_key : {  
                required : true,
                rangelength:[0,50]
            },
            secret : {  
                required : true,
                rangelength:[0,50]
            },
            channel: {  
                required : true,
//                isEnglishNum:true,
                rangelength:[0,50]
            }
        },  
        messages : {    
        	name : {  
                required : "必须填写租户名"
            },  
            name_apk : {  
                required : "必须填写应用名"
            },
            ver_apk : {  
                required : "必须填写应用版本"
            },
            domain : {  
                required : "必须填写域名"
            },
            pad_count : {  
                required : "必须填写Pad数"
            },
            app_key : {  
                required : "必须输入友盟Channel"
            },
            secret : {  
                required : "必须输入友盟Secret"
            },
            channel:{
            	required : "必须输入接口频道"
            }
        },
         highlight : function(element) {  
            $(element).closest('.form-group').addClass('has-error');  
        },
        success : function(label) {  
            label.closest('.form-group').removeClass('has-error');  
            label.remove();  
        }, 
        errorPlacement : function(error, element) {  
            element.parent('div').parent('div').append(error);  
        }
        
    }); 
	
});


function editTenant(){
	var url =_path+"/tms/tenantEdit";
	if(validator.form()){
		tenant_Controller("POST",url);
	}
}

 function tenant_Controller(subType,url) {
	 $("#tenant_edit_form").ajaxSubmit({
			type: subType,
			url:url,
			dataType: "json",
		    success: function(data){
		    	var msg = data["message"];
		    	var flag = data["status"];
		    	if(flag=='S'){
	            	 alert(msg);
//	            	 window.location = _path + "/tms/" + $("#id").val() +"/toTenantConfig";
	            	 window.location = _path + "/tms/list";
		    	}
		    	else{
		    		alert(data.msg);
		    	}
			},  
		    error : function(data) {  
	          alert("对不起,修改租户失败")  ;
	        }  
		});
 }
 