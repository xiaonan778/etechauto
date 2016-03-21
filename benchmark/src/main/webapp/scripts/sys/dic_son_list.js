$().ready(function() {
	
	$(".add-data").click(function() {
		window.location = _path + "/dic/"+$("#father").val()+"/soncreate";
	});
	
	$("#tp").datatable({
		data : {
			url : _path + "/dic/son/search/"+$("#father").val(),
			method : "POST",
			params : {
				
			}
		},
		columns : [ {
			title : "ID",
//			hidden : true,
			dataAttribute : "id",
			dataType : "long",
			width : "15%"
				
		}, {
			title : "名称",
			dataAttribute : "name",
			width : "15%"
		}, {
			title : "对应",
			dataAttribute : "memo",
			width : "10%"
		}, {
			title : "表名",
			dataAttribute : "rule",
			width : "35%"
		}, {
			title : "排序",
			dataAttribute : "sort",
			width : "5%"
		}, {
			title : "状态",
			dataAttribute : "status",
			width : "10%"
		}, {
			title : "操作",
			width : "10%",
			style : "operation-column",
			renderer : operation
		} ],
		remoteSort : true,
		pagination : true,
		paginationParam : {
			pageSize : 10,
			pagerLength : 5
		},
		emptyMsg : "查无结果"
	});

});