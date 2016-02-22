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