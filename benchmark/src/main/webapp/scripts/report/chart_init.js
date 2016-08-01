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
	        data : []
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
