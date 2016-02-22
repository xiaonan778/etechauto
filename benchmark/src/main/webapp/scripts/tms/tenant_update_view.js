$().ready(function() {
	// ----------------重置搜索条件--------------------------------------------------------
	$('#resetButton').click(function() {
		$('#name').val('');
		$('#domain').val('');
		$('#status').val(-1);
		$("#dk_container_status ul li").each(function(){
        	if($(this).find("a").attr("data-dk-dropdown-value") == "-1") {
    	        $("#dk_container_status").find('.dk_option_current').removeClass('dk_option_current');
    	        $(this).addClass('dk_option_current');
    	        $("#dk_container_status .dk_label").html( $("#dk_container_status").find('.dk_option_current a').html());
    	        return false;
        	}
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
			url : _path + "/tms/pageTenantAppDetail",
			method : "POST",
			//params : {sorter:'update'}
		},
		columns : [ 
		{
			title : "ID",
			hidden : true,
			dataAttribute : "id",
		}, {
			title : "租户名称",
			dataAttribute : "name",
			width : "15%"
		}, {
			title : "二级域名",
			dataAttribute : "domain",
			width : "10%"
		}, {
			title : "状态",
			dataAttribute : "statename",
			width : "10%",
		}, {
			title : "祺鲲产品",
			dataAttribute : "qkcp",
			width : "10%",
		},{
			title : "版本号",
			dataAttribute : "version",
			width : "10%",
		}, {
			title : "服务器数",
			dataAttribute : "container_detail",
			width : "15%"
		}, {
			title : "操作",
			width : "15%",
			style : "table-operation-column",
			renderer : operation
		} ],
		remoteSort : true,
		pagination : true,
		paginationParam : {
			pageSize : 10,
			pagerLength : 5
		},
		emptyMsg : "根据您输入的搜索条件，没有找到租户，请更换搜索条件再次搜索!"
	});
});




