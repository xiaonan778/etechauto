$(document).ready(function() {
	
    $('#bm_data').DataTable({
    	ajax: _path + "/info/list",
    	columns: [
            { "data": "name" },
            { "data": "modal" },
            { "data": "type" },
            { "data": "path" },
            { "data": "condition" },
            { "data": "addtime" }
    	 ],
    	columnDefs: [
           {
        	   targets: [ 0 ],
               render: function ( data, type, row ) {
                   return '<a href="'+row.fileuri+'">' + data + "</a>";
                }
           },
           {
        	   targets: [ 6 ],
               render: function ( data, type, row ) {
            	   var detail = "";
            	   if (row.type.indexOf("xls") != -1) {
            		   detail ='<a  class="opt" href="javascript:void(0);" id="detail_'+row.id+'"  >查看详情</a>';
            		   $(document).off("click", "#detail_" + row.id).on("click", "#detail_" + row.id, function(){
                           window.location.href = _path + "/info/detail/" + row.id;
                       });
            	   }
                   return detail ;
                }
           },
//           {
//               targets: [ 3 ],
//               visible: false,
//               searchable: false
//           },
//           {
//               targets: [3 ],
//               orderable: false
//           }
        ],
        order: [[ 5, 'desc' ]],
        pageLength: 25,
        pagingType: 'full_numbers',
        bStateSave: true //打开cookie
    });
    
});