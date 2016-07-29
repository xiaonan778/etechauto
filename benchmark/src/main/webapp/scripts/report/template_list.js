'use strict';

$(function(){
	
function initSettings(){
		
		var settings = {
			  processing: false,
	          serverSide: true,
	          searching: false,
			  ajax: {
					url: _path + "/template/list",
					type: "POST",
					contentType: "application/json",
					dataType: "json",
					data: function ( d ) {
						var param = $.extend({}, d, $(".searchform").serialize2Json() );
						param.pageSize = param.length;
						param.pageNow = ( param.start / param.length ) + 1;
						var columns = param.columns;
						var order = param.order;
						if (order) {
							var sortField = columns[order[0].column].data;
							if (sortField) {
								var sortString = sortField + "." + order[0].dir;
								param.sortString = sortString;
							}
						}
						delete param.length;
						delete param.start;
						delete param.columns;
						delete param.order;
						delete param.search;
						return  JSON.stringify( param );
					}
			  },
			  columns: [
		    	    { data: "template_name", title: "模板名称"},
			        { data: "description", title: "描述"},
			        { data: "date_update", title: "更新时间"},
			        { data: "date_create", title: "创建时间"},
			        { data: "updater", title: "更新者"},
			        { data: "creator" , title: "创建者"}
				],
		    	columnDefs: [ 		
					{
					    targets: [2, 3],
					    render: function ( data, type, row ) {
					    	return data ? new Date(Number(data)).Format("yyyy-MM-dd HH:mm") : "";
					    }
					},
					{
					    targets: [1, 4, 5],
					    orderable: false
					}
		           
		        ],
		        order: [[ 3, 'desc' ]],
		        pageLength: 10,
		        drawCallback: function (settings) {
		        	
		        	// 详情
					$("#tp").find(".detail").each(function(){
						$(this).unbind("click").click(function() {
							var data = $(this).data();
							
							window.location = _path + "/template/" + data.id;
						});
					});	
					
		        }	
		};
		
		return settings;
	}
	
	var productTable = $('#template').DataTable(initSettings());
	
	$("#searchButton").click(function() {
		if($("#pageNow").length>0){
			$("#pageNow").val(1);
		}
		productTable.ajax.reload();
//		productTable.state.clear(); 
//		productTable.destroy();
//		productTable = $("#tp").DataTable(initSettings());
	});
	
});