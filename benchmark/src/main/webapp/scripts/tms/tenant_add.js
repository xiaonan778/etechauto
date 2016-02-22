
var validator = null;
var validateName = false;
var validateDomain = false;

$().ready(function() { 
	
	validator = $('#tenant_add_form').validate({
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
//            size_fk: {  
//                required : true,
//                rangelength:[0,1],
//                digits: "只能输入10以下整数"
//            },
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
//            size_fk:{
//            	required : "必须输入服务器数"
//            },
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
	
	$("#domain").blur(function(){
		validateText(2);
	});
	
	$("#domain").keyup(function(){
		if (!$("#domain").val()) {
			var element = $(tenantDomain);
			element.closest('.input-group').removeClass('has-error'); 
			$("#divId2").remove();
		}
	});
	
	$("#addTenant").click(function(){
		//if(!validateName){
		//	if(!validateText(1)) {
		//		return false;
		//	}
		//}
		if (!!$("#domain").val()){
			if(!validateDomain){
				if(!validateText(2)) {
					$("#domain").focus();
					return false;
				}
			}
		}
		
		var url =_path+"/tms/tenantAdd";
		if (validator.form()) {
			if (!$("#version_fk").val()) {
				alert("请先新建一个有效版本！");
				return false;
			}
		    //if($("#logo_l").val()==""||$("#logo_s").val()==""||$("#logo_apk").val()==""||$("#logo_nav").val()==""||$("#logo_start").val()==""){
			if($("#logo_l").val()==""||$("#logo_s").val()==""){
		    	alert("必须上传大，小logo");
		    	return false;
		    }
			tenant_Controller("POST",url);
			
			var loadingStr = '<div class="sk-spinner sk-spinner-fading-circle">'
					+ '<div class="sk-circle1 sk-circle"></div>'
					+ '<div class="sk-circle2 sk-circle"></div>'
					+ '<div class="sk-circle3 sk-circle"></div>'
					+ '<div class="sk-circle4 sk-circle"></div>'
					+ '<div class="sk-circle5 sk-circle"></div>'
					+ '<div class="sk-circle6 sk-circle"></div>'
					+ '<div class="sk-circle7 sk-circle"></div>'
					+ '<div class="sk-circle8 sk-circle"></div>'
					+ '<div class="sk-circle9 sk-circle"></div>'
					+ '<div class="sk-circle10 sk-circle"></div>'
					+ '<div class="sk-circle11 sk-circle"></div>'
					+ '<div class="sk-circle12 sk-circle"></div>'
					+ '</div>';
			$(this).html("请稍等...");
			$(this).append(loadingStr);
			$(this).attr("disabled","disabled");
		} else {
			$("body,html").animate({scrollTop:0}, 500);
		}
	});
	
	
});

function validateText(i){
	
	switch (i) {
	  case 1: var url = _path+"/tms/checkPage";
	          var element = $(tenantName);
	          var divId = "divId"+i;
	          var value = $('#name').val();
	          var configdata = {id:i,value:value};
	          validateName = checkPage_Controller(configdata,"POST",url,element,divId);
	          return validateName;
	          break;
	  case 2: var url = _path+"/tms/checkPage";
		      var element = $(tenantDomain);
		      var divId = "divId"+i;
		      var value = $('#domain').val();
		      var configdata = {id:i,value:value};
		      validateDomain = checkPage_Controller(configdata,"POST",url,element,divId);
		      return validateDomain;
		      break;
	}
}


 function checkPage_Controller(configdata,subType,url,element,divId) {
	 label = $("#"+divId);
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
		          }
	   	          resultFlag = true;
 	        	  if (divId == "divId2") {
 	        		 validateDomain = true;
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

 function tenant_Controller(subType,url) {
	 $("#tenant_add_form").ajaxSubmit({
			type: subType,
			url:url,
			dataType: "json",
		    success: function(data){
		    	var msg = data["message"];
		    	var flag = data["status"];
		    	if(flag=='S'){
	            	 alert(msg);
	            	 window.location = _path + "/tms/" + $("#id").val() +"/toTenantConfig";
		    	}
		    	else{
		    		alert(msg);
		    	}
			},  
		    error : function(data) {  
	          alert("对不起,新增租户失败")  ;
	        }  
		});
 }
 
