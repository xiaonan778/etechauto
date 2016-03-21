var validator = null;
$().ready(function() {

	validator= $('#dicform').validate({
	    errorElement : 'span',  
	        errorClass : 'help-block',  
	        focusInvalid : false,  
	        rules : {  
	        	id : {  
	        		required : true,
	                rangelength:[0,10],
	                digits: "只能输入整数"
	            },  
	            name : {  
	                required : true,
	                rangelength:[2, 50]
	            },  
	            memo : {  
	            	required : false,
	                rangelength:[0,100]
	            },
	            min: {  
	                required : false,
	                rangelength:[0,10],
	                digits: "只能输入整数"
	            },
	            max : {  
	            	required : false,
	            	rangelength:[0,10],
	                digits: "只能输入整数"
	            },
	            rule : {  
	                required : true,
	                isTableName: true,
	                rangelength:[3, 20]
	            }, 
	            sort : {  
	                required : true,
	                rangelength:[0,10],
	                digits: "只能输入整数"
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


function save(){
	if(validator.form()){
		dicson_Controller();
	}
}

 function dicson_Controller() {
	 $("#dicform").ajaxSubmit({
			type: "POST",
			url:$(".form").attr('action'),
			dataType: "json",
		    success: function(data){
		    	var msg = data["message"];
		    	var flag = data["status"];
		    	if(flag=='S'){
		    		bravoui.ui.msg.alert({
		    			msg:msg,
		    			ok: function(){
		    				window.location = _path + "/dic/" + $("#dataFk").val() +"/sonlist";
		    			}
	    			});
		    	} else{
		    		bravoui.ui.msg.alert(msg);
		    	}
			},  
		    error : function(data) {  
		    	bravoui.ui.msg.alert("对不起数据维护失败")  ;
	        }  
		});
 }
 
