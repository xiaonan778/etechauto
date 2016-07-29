$().ready(function() {
	
	$(".add-data").click(function() {
		window.location = _path + "/dic/"+$("#father").val()+"/soncreate";
	});
	
	function initOptions(){
		 var options = {
				processing: false,
		        serverSide: true,
		    	ajax: {
		    		url:_path + "/dic/son/search/"+$("#father").val(),
		    		type: "POST",
		    		contentType: "application/json",
					dataType: "json",
					data: function ( d ) {
						var param = $.extend({}, d );
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
					},
		    		error: function(xhr, msg, error){
		    			alert("数据加载失败！");
		    		}
		    	},
		    	columns: [
		    	    { data: "id"   },
		    	    { data: "name" },
			        { data: "memo" },
			        { data: "min"  },
			        { data: "max"  },
			        { data: "rule"  },
			        { data: "sort"  },
			        { data: "status"  },
			        null
				],
		    	columnDefs: [
					{
						sDefaultContent : '',
						aTargets : [ '_all' ]
					},
					{
		               targets: [8],
		               render: operation
		            },
		            {
		               targets: [3,4,5,8],
		               orderable: false
		            }
		        ],
		        order: [[ 0, 'asc' ]],
		        pageLength: 10

		 };
		 return options;
	 }
	 $("#tp").DataTable(initOptions());

});



