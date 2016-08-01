'use strict';

$(function(){
	$("#xAxis").chosen({width: '90%'});
	$("#yAxis").chosen({width: '90%'});
	
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
	
	
	/**
	 * 生成报表
	 */
	$("#createReport").click(function() {
		
			$("#chartFrom").ajaxSubmit({
					url : _path + "/chart/buildChart",
					type : "POST",
					dataType : "json",
					success : function(data) {
						initChart();
						myChart.showLoading({
							text : '正在努力的读取数据中...',
						});
						if (data.status == "S") {
							if (data.list && data.list.length > 0) {
								var chartFactor = data.chartFactor;
								option_scatter.title.text = chartFactor.xAxis + " & " + chartFactor.yAxis;
								option_scatter.xAxis[0].axisLabel.formatter = "{value}" + chartFactor.xAxisUnit;
								option_scatter.yAxis[0].axisLabel.formatter = "{value}" + chartFactor.yAxisUnit;
								option_scatter.tooltip.formatter = function(params) {
									if (params.value.length > 1) {
										return params.seriesName + ' <br>'
												+ chartFactor.xAxis + ":  " + params.value[0] + chartFactor.xAxisUnit + "<br>"
												+ chartFactor.yAxis + ":  " + params.value[1] + chartFactor.yAxisUnit;
									}
								};
								var legend = {
									x: 80,
									y : 60,
									data : []
								};
								for (var i = 0; i < data.list.length; i++) {
									var item = data.list[i];
									var itemArray = [];
									if (item.length > 0) {
										for (var j = 0; j < item.length; j++) {
											var record = item[j];
											itemArray.push( [record[chartFactor.xAxis], record[chartFactor.yAxis] ] );
										}
										option_scatter.series.push({
											name : data.conditionList[i] + "(" + i + ")",
											type : 'scatter',
											data : itemArray
										});
										legend.data.push(data.conditionList[i]+ "("+ i + ")");
									}
								}
								option_scatter.legend = legend;
								myChart.clear();
								myChart.setOption(option_scatter);
								myChart.hideLoading();
							} else {
								myChart.setOption(option_scatter);
							}
						}  else {
							bravoui.ui.msg.alert("Internal Server Error!");
						}
					},
					error : function(xhr, msg, error) {
						if ("timeout" == msg || "parsererror" == msg) {
							bravoui.ui.msg.alert({
								msg : "对不起，session过期，请重新登录!",
								ok : function() {
									//window.location.reload();
								}
							});
						} else {
							bravoui.ui.msg.alert("Internal Server Error!");
						}
					}
				});
		});
	
});


//if (data.columnList && data.columnList.length > 0 ) {
//	var columnContent = "<thead><tr><th style='width:250px;'>属性名</th><th>筛选条件</th></tr></thead><tbody>";
//	var reportContent = "<thead><tr><th style='width: 250px;'>报表要素</th><th>条件</th></tr></thead>";
//	var reportOptions = "";
//	for (var i = 0; i < data.columnList.length; i++) {
//		var citem = data.columnList[i];
//		columnContent = columnContent + "<tr><td>" +citem + "</td>"
//		+"<td><input type='hidden' name='queryAttribute' value='"+citem+"' >"
//		+"<select  class='condition' name='"+citem+"_rule' ><option value='1'>等于</option><option value='2'>介于</option></select>"
//		+"<input type='text' name='"+citem+"_eq'  id='"+citem+"_eq' /><input style='display:none;' type='text' name='"+citem+"_gt'  id='"+citem+"_gt' />"
//		+"<input style='display:none;'  type='text' name='"+citem+"_lt' id='"+citem+"_lt'></td></tr>";
//		
//		reportOptions = reportOptions + "<option>" + citem + "</option>";
//	}
//	
//	columnContent += "<tbody>"; 
//	$("#column_data").html(columnContent);
//	
//	reportContent = reportContent + "<tbody><tr><td>报表类型</td><td><select name='chartType'><option value='SCATTER'>散点图</option><option value='BAR'>柱状图</option></select></td></tr>";
//	reportContent = reportContent + "<tr><td>X轴</td><td><select name='xAxis' id='xAxis'>"+reportOptions+"</select></td></tr>";
//	reportContent = reportContent + "<tr><td>Y轴</td><td><select name='yAxis' id='yAxis' >"+reportOptions+"</select></td></tr></tbody>";
//	$("#report_data").html(reportContent);
//	$("#report_btn").show();
//	
//	initSelectOpt();
//}