$().ready(function() {
	
	function initOptions(){
		 
		 var options = {
				processing: false,
		        serverSide: true,
		    	ajax: {
		    		url:_path + "/dic/search",
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
					}
		    	},
		    	columns: [
		    	    { data: "id" },
		    	    { data: "code" },
			        { data: "name" },
			        { data: "memo" },
			        { data: "status" },
			        null
				],
		    	columnDefs: [
					{
						sDefaultContent : '',
						aTargets : [ '_all' ]
					},
					{
		               targets: [5],
		               render: operation
		            },
		            {
		               targets: [2,3,5],
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



