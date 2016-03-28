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
				} else {
					$("#file_data").html("");
					bravoui.ui.msg.alert("查无结果");
				}
				
				if (data.columnList && data.columnList.length > 0 ) {
					var columnContent = "<thead><tr><th style='width:35%;'>属性名</th><th>操作</th></tr></thead><tbody>";
					for (var i = 0; i < data.columnList.length; i++) {
						var citem = data.columnList[i];
						columnContent = columnContent + "<tr><td>" +citem + "</td><td></td></tr>";
					}
					columnContent += "<tbody>"; 
					$("#column_data").html(columnContent);
				} else {
					$("#column_data").html("");
				}
				
				
			} else {
				$("#file_data").html("");
				$("#column_data").html("");
				bravoui.ui.msg.alert(data.message);
			}
		}).fail(function(xhr,  msg,  error){
			bravoui.ui.msg.alert("Internal Server Error");
		});
	});
});