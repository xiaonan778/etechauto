$().ready(function() {
	// ----------------重置搜索条件--------------------------------------------------------
	$('#resetButton').click(function() {
		$('#name').val('');
		$('#valid').val(-1);
		$('#qkcp_fk').val(-1);
		$("#dk_container_valid ul li").each(function(){
        	if($(this).find("a").attr("data-dk-dropdown-value") == "-1") {
    	        $("#dk_container_valid").find('.dk_option_current').removeClass('dk_option_current');
    	        $(this).addClass('dk_option_current');
    	        $("#dk_container_valid .dk_label").html( $("#dk_container_valid").find('.dk_option_current a').html());
    	        return false;
        	}
        });
		$("#dk_container_qkcp_fk ul li").each(function(){
        	if($(this).find("a").attr("data-dk-dropdown-value") == "-1") {
    	        $("#dk_container_qkcp_fk").find('.dk_option_current').removeClass('dk_option_current');
    	        $(this).addClass('dk_option_current');
    	        $("#dk_container_qkcp_fk .dk_label").html( $("#dk_container_valid").find('.dk_option_current a').html());
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
			url : _path + "/tms/pageVersions",
			method : "POST",
			//params : {sorter:'update'}
		},
		columns : [ 
		{
			title : "ID",
			hidden : true,
			dataAttribute : "id",
		}, {
			title : "祺鲲产品",
			dataAttribute : "qkcp",
			width : "10%"
		}, {
			title : "版本名称",
			dataAttribute : "name",
			width : "10%"
		}, {
			title : "状态",
			dataAttribute : "state",
			width : "5%",
		}, {
			title : "初始化脚本文件名",
			dataAttribute : "createFile",
			width : "15%",
		}, {
			title : "增量脚本文件名",
			dataAttribute : "updateFile",
			width : "15%"
		}, {
			title : "更新时间",
			dataAttribute : "date_update",
			width : "15%"
		}, {
			title : "创建时间",
			dataAttribute : "date_create",
			width : "15%"
		}, {
			title : "操作",
			width : "10%",
			style : "table-operation-column",
			renderer : operation
		} ],
		remoteSort : true,
		pagination : true,
		paginationParam : {
			pageSize : 10,
			pagerLength : 5
		},
		emptyMsg : "根据您输入的搜索条件，没有找到结果，请更换搜索条件再次搜索!"
	});
});




