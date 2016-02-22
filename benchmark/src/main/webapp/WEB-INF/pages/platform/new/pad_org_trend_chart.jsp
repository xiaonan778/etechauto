<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="BW" uri="http://benchmark.com/tags"%>
<!DOCTYPE HTML>
<html>
  <head>
    <jsp:include page="../../common/meta.jsp" />
    <title>平台运营数据</title>
    <link rel="stylesheet" type="text/css" href="${path}/css/report/chart.css">
    <script src="${path }/resources/reveal/jquery.reveal.js" ></script>
    <script src='${path}/scripts/common/reportDate.js' type='text/javascript'></script>
  </head>
  
  <body>
    
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="pad_org_trend" />
      
    <div id="pad_org_trend_report" style="width: 100%;height: 480px;"></div>
    <script>
	    $(function(){
	        jQuery().reportDate({
	            id : "pad_org_trend",
	            chartURL : _path + "/report/pad/time_org_trend_chart",
	            subitemURL : _path + "/report/pad/time_org_trend/subitem",
	            show : true
	        });
	    });
    
    	require.config({
			paths : {
				echarts : '${path}/resources/echarts-2.2.1'
			}
		});
		// ------------------------------------------------------------------------------------------------------------------------------------------
		$().ready(function() {
			
			require([ 
				'echarts', 
				'echarts/themes/roma',
				'echarts/chart/bar' 
			], function(ec, theme) {
				var pad_org_trend_report = ec.init(document.getElementById('pad_org_trend_report'), theme);
				var titleText = "";
				if(${showId}>0){
					titleText = '近${showId}天租户Pad激活数量分布图';
				}else{ 
					titleText = "${start}至${end} 租户Pad激活数量分布图";
				}
				var showId = ${showId};
                var start = "${start}";
                var end = "${end}";
				var configdata = {showId:showId,start:start,end:end};
				var serie=[];
				pad_org_trend_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
				// send request data.
				$.ajax({
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					url : "${path }/report/pad/time_org_trend_chart/data",
					data : JSON.stringify(configdata),  
					dataType : 'json',
					success : function(data) {
						console.log(data.labels);
						console.log(data.tenants);
						console.log(data.values);
						pad_org_tent_option.xAxis[0].data = data.labels;
						pad_org_tent_option.legend.data = data.tenants;
						for ( var int = 0; int < data.values.length; int++) {
							var list_0 = data.values[int];
							var size = list_0.length;
							var list_1 = [];
							var tempvalue = 0;
							for (var i = 0; i < size; i++){
								tempvalue = Number(list_0[i]);
								list_1.push(tempvalue);
							}
							var item={
						            name:data.tenants[int],
						            type:'bar',
						            data:list_1,
						            markPoint : {
						                data : [
						                    {type : 'max', name: '最大值'},
						                    {type : 'min', name: '最小值'}
						                ]
						            },
	                                markLine : {
	                                    data : [
	                                        {type : 'average', name: '平均值'}
	                                    ]
	                                }
						    };
						   serie.push(item);
						}
						pad_org_trend_report.setOption(pad_org_tent_option);
						pad_org_trend_report.hideLoading();
						
						if(window.addEventListener){
                            window.addEventListener("resize", function () {
                            	pad_org_trend_report.resize();
                            });
                        } else {
                           window.attachEvent("resize", function () {
                        	   pad_org_trend_report.resize();
                           });
                        }
					},
					error : function(data) {
						pad_org_trend_report.setOption(pad_org_tent_option);
						pad_org_trend_report.hideLoading();
					}
				});
				pad_org_tent_option = {
				    title : {
				        text: titleText,
				        subtext : "${subtext}",
				        x: 'center',
                        itemGap: 10,
                        textStyle : {
                            color : '#259BD4',
                            fontSize : 25,
                            fontWeight : 'bolder'
                        }
				    },
				    grid : {
                        y : 120
                    },
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:[],
				        x: 80,
                        y : 65
				    },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            data : []
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
				            axisLabel : {
                            formatter : '{value} 台'
                        }
				        }
				    ],
				    series:serie
				};
			});

		});
	</script>
  
  </body>

</html>
