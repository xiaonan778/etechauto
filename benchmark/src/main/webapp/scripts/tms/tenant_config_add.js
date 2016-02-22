
var validator = null;
var validateName = false;
var validateAccount = false;

$().ready(function() { 
	validator= $('#tenant_config_form').validate({
    errorElement : 'span',  
        errorClass : 'help-block',  
        focusInvalid : false,  
        rules : {  
        	name : {  
                required : true,
                isLowercaseNum:true,
                rangelength:[0,20]
            },  
            account : {  
                required : true,
                isLowercaseNum:true,
                rangelength:[0,15]
            },  
            password : {  
                required : true,
                isEnglishNum : true,
                rangelength:[0,20]
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


function validateText(i){
	
	switch (i) {
	  case 1: var url = _path+"/tms/checkDbConfig";
	          var element = $(dbName);
	          var divId = "divId"+i;
	          var value = $('#name').val();
	          var configdata = {id:i,value:value};
	          validateName = checkDbConfig_Controller(configdata,"POST",url,element,divId);
	          break;
			  case 2: var url = _path+"/tms/checkDbConfig";
		      var element = $(dbAccount);
		      var divId = "divId"+i;
		      var value = $('#account').val();
		      var configdata = {id:i,value:value};
		      validateAccount = checkDbConfig_Controller(configdata,"POST",url,element,divId);
		      break;
	}
}


 function checkDbConfig_Controller(configdata,subType,url,element,divId) {
	 label = $("#"+divId);
	 if(configdata.id == 1){
		 if($.trim(configdata.value).toUpperCase() == "ECPDB" || $.trim(configdata.value).toUpperCase() == "APPSERVERDC"){
			 if(label.length==0){
				 element.closest('.input-group').addClass('has-error');  
		    	 element.parent('div').parent('div').append("<div id='"+divId+"'><font color='#AE0000'>已有数据库名，请修改！</font></div>");
			 }
			 return false;
		 }
	 }
	 if(configdata.id == 2){
		 if($.trim(configdata.value).toUpperCase() == "ROOT"){
			 if(label.length==0){
				 element.closest('.input-group').addClass('has-error');  
		    	 element.parent('div').parent('div').append("<div id='"+divId+"'><font color='#AE0000'>已有数据库帐号，请修改！</font></div>");
			 }
			 return false;
		 }
	 }
	 var resultFlag = false;
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
	   	          if(label.length>0){
	   	        	 element.closest('.input-group').removeClass('has-error'); 
	   	        	 label.remove();  
	   	        	 resultFlag = true;
		          }
             }else{
            	 if(label.length==0){
            		 element.closest('.input-group').addClass('has-error');  
                	 element.parent('div').parent('div').append("<div id='"+divId+"'><font color='#AE0000'>"+msg+"</font></div>");
            	 }
            	 resultFlag =  false;
             }
         },  
         error : function(data) {  
        	alert("对不起,检查重复数据出错")  ;
         }  
    }); 
	return resultFlag;
 }


 function addConfig(){
		if(!validateName){
			validateText(1);
		}
		if(!validateAccount){
			validateText(2);
		}
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
		var url =_path+"/tms/tenantConfigAdd";
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
	            	 location.href=_path+"/tms/"+configdata.tenantFk+"/toTenantDetail"; 
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
 