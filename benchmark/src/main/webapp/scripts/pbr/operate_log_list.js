$().ready(function() {
	// ----------------重置搜索条件--------------------------------------------------------
	$('#resetButton').click(function() {
		$('#tenantName').val('');
		$('#domain').val('');
		$('#title').val('');
		$('#content').val('');
	});
	// ----------------条件搜索-----------------------------------------------------------
	$("input[id='searchButton']").click(function() {
		var param = $(".searchform").serialize2Json();
		$("#tp").datatable('load', param);
	});
	// ----------------列表展示-----------------------------------------------------------
	$("#tp").datatable({
		data : {
			url : _path + "/pbr/page",
			method : "POST"
		},
		columns : [ {
			title : "ID",
			hidden : true,
			dataAttribute : "id",
		},{
			title : "租户名称",
			dataAttribute : "tenantName",
			width : "10%"
		},{
			title : "域名",
			dataAttribute : "domain",
			width : "5%"
		},{
			title : "内容",
			dataAttribute : "content",
			width : "15%",
			style : "words-break"
		},{
			title : "备注",
			dataAttribute : "detail",
			width : "10%",
			style : "words-break"
		}, {
			title : "创建时间",
			dataAttribute : "dateCreate",
			width : "5%",
			dataType: "datetime"
		},{
			title : "操作人",
			dataAttribute : "creater",
			width : "5%",
		},{
			title : "操作",
			width : "5%",
			style : "table-operation-column",
			renderer : function(data, el) {
				var editor = "";
					editor= $("<a class=\"edit\" href=\"javascript:void(0);\"><span>备注</span></a>&nbsp;&nbsp;&nbsp;&nbsp;" );
				$(el).append(editor);
				$(el).find(".edit").unbind("click").click(function(){
					window.location = _path + "/pbr/" + data.id+"/toLogEdit";
				});
			}
		} ],
		remoteSort : true,
		pagination : true,
		paginationParam : {
			pageSize : 10,
			pagerLength : 5
		},
		emptyMsg : "根据您输入的搜索条件,没有找到符合条件的日志，请更换搜索条件再次搜索!"
	});
});
