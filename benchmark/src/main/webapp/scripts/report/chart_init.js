$(function() {
	function initChart() {
		var option_scatter = {
			title : {
				text : "",
				itemGap : 10,
				x : 'center',
				textStyle : {
					color : '#259BD4',
					fontFamily : "Helvetica Neue,Helvetica,Arial,sans-serif",
					fontSize : 25,
					fontWeight : 'bolder'
				}
			},
			grid : {
				y : 100
			},
			tooltip : {
				trigger : 'axis',
				showDelay : 0,
				formatter : function(params) {
					if (params.value.length > 1) {
						return params.seriesName + ' :<br/>' + params.value[0] + '' + params.value[1] + '';
					}
				},
				axisPointer : {
					show : true,
					type : 'cross',
					lineStyle : {
						type : 'dashed',
						width : 1
					}
				}
			},
			xAxis : [ {
				type : 'value',
				scale : true,
				axisLabel : {
					formatter : '{value}'
				}
			} ],
			yAxis : [ {
				type : 'value',
				scale : true,
				axisLabel : {
					formatter : '{value}'
				}
			} ],
			series : [ {
				name : '',
				type : 'scatter',
				data : []
			} ]
		};
		window.option_scatter = option_scatter;
		
		var option_bar = {
		    title : {
		        text : "TORQUE",
		        itemGap : 10,
		        x : 'center',
		        textStyle : {
		            color : '#259BD4',
		            fontFamily : "Helvetica Neue,Helvetica,Arial,sans-serif",
		            fontSize : 25,
		            fontWeight : 'bolder'
		        }
		    },
		    grid : {
		        y : 100
		    },
		    tooltip : {
		        trigger : 'axis',
		        axisPointer : {
		            type : 'shadow'
		        },
		        formatter : '{b}<br/> {a}: {c} '
		    },
		    
		    xAxis : [ {
		        type : 'category',
		        boundaryGap : true,
		        data : ['']
		    } ],
		    yAxis : [ {
		        type : 'value',
		        axisLabel : {
		            formatter : '{value}'
		        }
		    } ],
		    series : [ {
		        name : '',
		        smooth: true,
                type : 'bar',
		        data : []
		    } ]
		};
		window.option_bar = option_bar;
		
		var myChart = echarts.init(document.getElementById('report_chart'), 'echarts/themes/shine');
		window.myChart = myChart;

		if (window.addEventListener) {
			window.addEventListener("resize", function() {
				myChart.resize();
			});
		} else {
			window.attachEvent("resize", function() {
				myChart.resize();
			});
		}
	}

	/**
	 * 生成报表
	 */
	$("#createReport").click(function() {
			$("#reportFrom").ajaxSubmit({
					url : _path + "/report/buildChart",
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
						} 
					},
					error : function(xhr, msg, error) {
						if ("timeout" == msg || "parsererror" == msg) {
							bravoui.ui.msg.alert({
								msg : "对不起，session过期，请重新登录!",
								ok : function() {
									window.location.reload();
								}
							});
						} else {
							bravoui.ui.msg.alert("Internal Server Error!");
						}
					}
				});
		});

});
