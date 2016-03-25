'use strict';

$(function(){
	$("#searchBtn").click(function(){
		var queryData = {keywords: $("#keywords").val()};
		$.ajax({
			url: _path + "/report/searchKeywords",
			type: "GET",
			data: queryData,
			dataType: "json"
		}).done(function(data){
			if (data && data.status == "S") {
				
				if (data.excelList && data.excelList.length > 0 ) {
					var excelContent = "<thead><tr><th>文件名</th><th>文件来源</th><th>ID</th></tr></thead><tbody>";
					for (var i = 0; i < data.excelList.length; i++) {
						var eitem = data.excelList[i];
						excelContent = excelContent + "<tr><td>" + eitem.name + "</td><td>" + eitem.condition + "</td><td>" + eitem.id +"</td></tr>";
					}
					excelContent += "<tbody>"; 
					$("#file_data").html(excelContent);
				}
				
				
			} else {
				bravoui.ui.msg.alert(data.message);
			}
		}).fail(function(xhr,  msg,  error){
			bravoui.ui.msg.alert("Internal Server Error");
		});
	});
});