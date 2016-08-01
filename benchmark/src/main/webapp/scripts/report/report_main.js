'use strict';

$(function(){
	
	$("#reset").click(function(){
		$("#keywords").val("");
	});
	
	$(document).keydown(function(e){
		if (e && e.keyCode == 13) {
			$("#searchBtn").click();
			return false;
		}
	});
	
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
					var excelContent = "<thead><tr><th>文件</th><th>文件类目</th><th>操作</th></tr></thead><tbody>";
					for (var i = 0; i < data.excelList.length; i++) {
						var eitem = data.excelList[i];
						excelContent = excelContent + "<tr><td><a href='"+data.filepath +"/" + eitem.save_path+"'>" + eitem.name + "</a></td>"
							+"<td>" + eitem.condition + "<input type='hidden' name='fileId'  value='"+eitem.id +"' /></td>";
						if (eitem.type.indexOf("xls") != -1) {
							excelContent = excelContent +"<td><a  class='opt' href='" + _path + "/info/detail/" + eitem.id +"' target='_blank'  >查看详情</a></td></tr>";
						} else {
							excelContent = excelContent + "<td></td></tr>";
						}
							 
					}
					excelContent += "<tbody>"; 
					$("#file_data").html(excelContent);
				} else {
					$("#file_data").html("");
					$("#column_data").html("");
					$("#report_data").html("");
					$("#report_btn").hide();
					alert("查无结果");
					return false;
				}
				
			} else {
				$("#file_data").html("");
				$("#column_data").html("");
				$("#report_data").html("");
				$("#report_btn").hide();
				alert(data.message);
			}
		}).fail(function(xhr,  msg,  error){
			if ("timeout" == msg || "parsererror" == msg) {
                bravoui.ui.msg.alert({
                	msg: "对不起，session过期，请重新登录!",
                	ok: function(){
                		 window.location.reload();
                	}
                });
            } else {
                bravoui.ui.msg.alert("Internal Server Error!");
            }
		});
	});
	
	
});