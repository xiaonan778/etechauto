'use strict';

$(function(){
	
	$("#reset").click(function(){
		$("#keywords").val("");
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
					var excelContent = "<thead><tr><th>文件名</th><th>文件类目</th></tr></thead><tbody>";
					for (var i = 0; i < data.excelList.length; i++) {
						var eitem = data.excelList[i];
						excelContent = excelContent + "<tr><td>" + eitem.name + "</td><td>" + eitem.condition + "<input type='hidden' name='fileId'  value='"+eitem.id +"' /></td></tr>";
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
				
				if (data.columnList && data.columnList.length > 0 ) {
					var columnContent = "<thead><tr><th style='width:250px;'>属性名</th><th>筛选条件</th></tr></thead><tbody>";
					var reportContent = "<thead><tr><th style='width: 250px;'>报表要素</th><th>条件</th></tr></thead>";
					var reportOptions = "";
					for (var i = 0; i < data.columnList.length; i++) {
						var citem = data.columnList[i];
						columnContent = columnContent + "<tr><td>" +citem + "</td>"
						+"<td><input type='hidden' name='queryAttribute' value='"+citem+"' >"
						+"<select  class='condition' name='"+citem+"_rule' ><option value='1'>等于</option><option value='2'>介于</option></select>"
						+"<input type='text' name='"+citem+"_eq'  id='"+citem+"_eq' /><input style='display:none;' type='text' name='"+citem+"_gt'  id='"+citem+"_gt' />"
						+"<input style='display:none;'  type='text' name='"+citem+"_lt' id='"+citem+"_lt'></td></tr>";
						
						reportOptions = reportOptions + "<option>" + citem + "</option>";
					}
					
					columnContent += "<tbody>"; 
					$("#column_data").html(columnContent);
					
					reportContent = reportContent + "<tbody><tr><td>报表类型</td><td><select name='chartType'><option value='SCATTER'>散点图</option><option value='BAR'>柱状图</option></select></td></tr>";
					reportContent = reportContent + "<tr><td>X轴</td><td><select name='xAxis' id='xAxis'>"+reportOptions+"</select></td></tr>";
					reportContent = reportContent + "<tr><td>Y轴</td><td><select name='yAxis' id='yAxis' >"+reportOptions+"</select></td></tr></tbody>";
					$("#report_data").html(reportContent);
					$("#report_btn").show();
					
					initSelectOpt();
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
	
	
	function initSelectOpt() {
		$(".condition").change(function(){
			var temp = $(this).val();
			var item = $(this).prev().val();
			if ( temp == "1") {
				$("#" + item + "_eq").show();
				$("#" + item + "_gt").hide();
				$("#" + item + "_lt").hide();
			} else if ( temp == "2" ) {
				$("#" + item + "_eq").hide();
				$("#" + item + "_gt").show();
				$("#" + item + "_lt").show();
			}
		});
		
		$("#xAxis").chosen({width: '300px'});
		$("#yAxis").chosen({width: '300px'});
	}
	
});