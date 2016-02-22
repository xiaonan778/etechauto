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
    
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="cfp_org_trend" />
    
	<div class="container-title">
        <div class="chart-title">
            <c:choose>
                <c:when test="${showId > 0}">近${showId}天租户理财师增长分布图</c:when>
                <c:otherwise>${start}至${end} 租户理财师增长分布图</c:otherwise>
            </c:choose>
        </div>
        <div class="chart-subtitle">${subtext}</div>
    </div>
    <div id="cfp_org_trend_report" style="width: 100%;height: 450px;"></div>
    <div id="nomessage"></div>
    <script>
	    $(function(){
	        jQuery().reportDate({
	            id : "cfp_org_trend",
	            chartURL : _path + "/report/cfp/cfp_time_org_chart",
	            subitemURL : _path + "/report/cfp/cfp_time_org_subitem"
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
				'echarts/chart/bar' 
			], function(ec, theme) {
				var cfp_org_trend_report = ec.init(document.getElementById('cfp_org_trend_report'), theme);
				var showId = ${showId};
                var start = "${start}";
                var end = "${end}";
				var configdata = {showId:showId,start:start,end:end};
				var serie=[];
				cfp_org_trend_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
				// send request data.
				$.ajax({
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					url : "${path }/report/cfp/cfp_time_org_chart/data",
					data : JSON.stringify(configdata),  
					dataType : 'json',
					success : function(data) {
						cfp_org_tent_option.xAxis[0].data = data.labels;
					    if(data.tenants.length>0){
			    			
							cfp_org_tent_option.legend.data = data.tenants;
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
							            itemStyle: {
					                        normal: {
						                        label: {
						                           show: true,
						                           position: 'top',
						                           formatter: '{c}'
						                          }
					                         }
					                     },
							            markPoint : {
							                data : [
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
							cfp_org_tent_option.series = serie;
							cfp_org_trend_report.hideLoading();
							cfp_org_trend_report.setOption(cfp_org_tent_option);
					    }else{
					    	cfp_org_trend_report.hideLoading();
					    	cfp_org_trend_report.showLoading({
                                text: '暂无数据', 
                                effect : 'bubble',
                                textStyle : {
                                    fontSize : 30
                                }
                            });
					    }
					    
					    if(window.addEventListener){
                            window.addEventListener("resize", function () {
                            	cfp_org_trend_report.resize();
                            });
                        } else {
                           window.attachEvent("resize", function () {
                        	   cfp_org_trend_report.resize();
                           });
                        }
					},
					error : function(data) {
						cfp_org_trend_report.setOption(cfp_org_tent_option);
						cfp_org_trend_report.hideLoading();
					}
				});
				cfp_org_tent_option = {
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:[''],
				        x : 80,
                        y : 10
				    },
				    calculable : false,
				    xAxis : [
				        {
				            type : 'category'
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
                            axisLabel : {
                                formatter : '{value} 位'
                            }
				        },
				    ],
				    series:serie
				};
			});

		});
	</script>
  
  </body>

</html>
