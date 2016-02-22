$().ready(function() {
	// ----------------重置搜索条件--------------------------------------------------------
	$('#resetButton').click(function() {
		$('#name').val('');
		$('#domain').val('');
		$("#status").val('-1');
		$(".dk_label").html("全部");
		$(".dk_options_inner li a").each(function(){
			if($(this).val()=="全部") $(this).parent().addClass("dk_option_current");
			else $(this).parent().removeClass("dk_option_current");
		});
	});
	// ----------------条件搜索-----------------------------------------------------------
	$("input[id='searchButton']").click(function() {
		var param = $(".searchform").serialize2Json();
		$("#tp").datatable('load', param);
	});
	// ----------------列表展示-----------------------------------------------------------
	$("#tp").datatable({
		data : {
			url : _path + "/tms/page",
			method : "POST",
			params : {sorter:'update'}
		},
		columns : [ {
			title : "ID",
			hidden : true,
			dataAttribute : "id",
		},{
			title : "version",
			hidden : true,
			dataAttribute : "version",
		},{
			title : "租户名称",
			dataAttribute : "name",
			width : "10%"
		},{
			title : "二级域名",
			dataAttribute : "domain",
			width : "10%"
		},{
			title : "LOGO",
//			dataAttribute : "logo",
			width : "15%",
			renderer : function(data, el) {
				var logo = "";
				var bigLogoPath = "/upload"+data.logo;
				var smallLogoPath = "/upload"+data.logo_mini;
				logo= $("<img width=76 height=102 border=0 src='"+bigLogoPath+"'>&nbsp;&nbsp;&nbsp;<img width=35 height=32 border=0 src='"+smallLogoPath+"'>");
				$(el).append(logo);
			}
		},{
			title : "Pad数",
			dataAttribute : "pad_count",
			width : "5%"
		},{
			title : "状态",
			dataAttribute : "statname",
			width : "5%",
		}, {
			title : "创建时间",
			dataAttribute : "dateOfCreate",
			width : "10%",
			dataType: "datetime"
		},{
			title : "备注",
			dataAttribute : "memo",
			width : "15%",
		}, {
			title : "创建者",
			dataAttribute : "creater",
			width : "8%"
		}, {
			title : "操作",
			width : "20%",
			style : "table-operation-column",
			renderer : operation
		} ],
		remoteSort : true,
		pagination : true,
		paginationParam : {
			pageSize : 10,
			pagerLength : 5
		},
		emptyMsg : "根据您输入的搜索条件,没有找到租户，请更换搜索条件再次搜索!"
	});
});

function tenantService(data,status){
	if(status ==1){
		$("#myModalLabel").html("正在开启服务");
		$("#modalBody").html("请稍后...");
		$("#openModal").click();
	}else{
		$("#myModalLabel").html("正在停止服务");
		$("#modalBody").html("请稍后...");
		$("#openModal").click();
	}
	var id = data.id;
	var status = status;
	var name = data.name;
	var domain = data.domain;
	var version = data.version;
	var url = _path + "/tms/tenantService";
	var configdata = {id:id,status:status,name:name,domain:domain,version:version};
	tenant_Controller(configdata,"POST",url);
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
             var flag = data["status"];
//             if(flag=='S'){
//            	 $("#modal").html("<h1>"+msg+"</h1>");
                 $("#modal").hide();
            	 alert(msg);
            	 location.href=_path+"/tms/list"; 
//             }else{
//            	 $("#modal").html("<h1>"+msg+"</h1>");
//            	 alert(msg);
//            	 location.href=_path+"/tms/list"; 
//             }
         },  
         error : function(data) {  
        	 $("#modal").hide();
        	 if(configdata.status==1){
        	    alert("对不起,服务启动失败!")  ;
        	 }else{
        		alert("对不起,服务停止失败!")  ;
        	 }
        	 location.href=_path+"/tms/list"; 
         }  
    });  
 }




