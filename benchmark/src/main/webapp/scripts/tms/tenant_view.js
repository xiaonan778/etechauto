
$().ready(function() {
	tenantView();
	// ----------------重置搜索条件--------------------------------------------------------
	$('#countNum').val('123');
	$('#resetButton').click(function() {
		$('#name').val('');
		$('#domain').val('');
		$('#status').val(-1);
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
			title : "租户名称",
			dataAttribute : "name",
			width : "10%"
		},{
			title : "二级域名",
			dataAttribute : "domain",
			width : "10%"
		},{
				title : "LOGO",
//				dataAttribute : "logo",
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
		}],
		remoteSort : true,
		pagination : true,
		paginationParam : {
			pageSize : 10,
			pagerLength : 5
		}
	});
});


function tenantView(){
	var url =_path+"/tms/tenantView";
	var configdata = {valid:1};
	tenantView_Controller(configdata,"POST",url);
}

 function tenantView_Controller(configdata,subType,url) {
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
            	 var result =  data["result"];
            	 $('#countNum').val(result.countNum);
            	 $('#startNum').val(result.startNum);
            	 $('#shutdownNum').val(result.shutdownNum);
            	 $('#normal').val(result.normal);
            	 $('#abnormalNum').val(result.abnormalNum);
             }else{
            		alert(msg);
             }
         },  
         error : function(data) {  
        	alert("对不起,租户配置失败")  ;
         }  
    });  
 }
