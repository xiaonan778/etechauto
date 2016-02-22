 function editLog(){
		var detail = $('#detail').val();
		var id = $('#id').val();
		var url =_path+"/pbr/operLogEdit";
		var configdata = {detail:detail,id:id};
		log_Controller(configdata,"POST",url);
	}

	 function log_Controller(configdata,subType,url) {
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
	            	 alert(msg);
	            	 location.href=_path+"/pbr/list"; 
	             }else{
	            		alert(msg);
	             }
	         },  
	         error : function(data) {  
	        	alert("对不起,更新日志失败!")  ;
	         }  
	    });  
	 }
 