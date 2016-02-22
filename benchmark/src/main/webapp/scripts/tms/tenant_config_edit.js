
var validator = null;
$().ready(function() { 
	
	validator= $('#tenant_config_form').validate({
    errorElement : 'span',  
        errorClass : 'help-block',  
        focusInvalid : false,  
        rules : {  
        	name : {  
                required : true,
                //isLowercaseNum:true,
                rangelength:[0,50]
            },  
            account : {  
                required : true,
                //isLowercaseNum:true,
                rangelength:[0,50]
            },  
            password : {  
                required : true,
                isEnglishNum:true,
                rangelength:[0,50]
            }
        },  
        messages : {    
        	name : {  
                required : "必须填写数据库名"
            },  
            account : {  
                required : "必须填写帐号"
            },  
            password : {  
                required : "必须填写密码"
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


 function editConfig(){
	    var extra = "";
	    var i = 0;
		$('input[type="checkbox"][name="glmk"]:checked').each(function() {
			if(i==0){
				extra=$(this).val();
			}else extra = extra + "," + $(this).val();	
			i++;
		});
		var tenantFk = $('#tenantFk').val();
		var name = $('#name').val();
		var account = $('#account').val();
		var password = $('#password').val();
		var memo = $('#memo').val();
		var url =_path+"/tms/tenantConfigEdit";
		var configdata = {tenantFk:tenantFk,name:name,account:account,password:password,memo:memo,extra:extra};
		if(validator.form()){
			$("#myModalLabel").html("正在配置租户");
			$("#modalBody").html("请稍后...");
			$("#openModal").click();
			tenant_Controller(configdata,"POST",url);
		}
	}

	 function tenant_Controller(configdata,subType,url) {
		 $.ajax({
	    	 type : subType,  
	         contentType : 'application/json;charset=utf-8',  
	         url : url,  
	         data : JSON.stringify(configdata),  
	         dataType : 'json',  
	         cache : false,
	         success : function(data) {   
	        	 var msg = data["message"];
	             var status = data["status"];
	             if(status=='S'){
	            	 $("#modal").hide();
	            	 alert(msg);
	            	 location.href=_path+"/tms/list"; 
	             }else{
	            	 $("#modal").hide();
	                 alert(msg);
	                 location.href=_path+"/tms/"+configdata.tenantFk+"/toTenantConfig"; 
	             }
	         },  
	         error : function(data) {  
	        	$("#modal").hide();
	        	alert("对不起,租户配置失败")  ;
	        	location.href=_path+"/tms/"+configdata.tenantFk+"/toTenantConfig"; 
	         }  
	    });  
	 }
 