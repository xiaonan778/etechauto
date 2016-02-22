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
  
  <body id="tenant_trade">
    
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="tenant_trade" />
    
	<div class="container-title">
        <div class="chart-title">
            <c:choose>
                <c:when test="${showId > 0}">近${showId}天租户交易总额分布图</c:when>
                <c:otherwise>${start}至${end} 租户交易总额分布图</c:otherwise>
            </c:choose>
        </div>
        <div class="chart-subtitle">${subtext}</div>
    </div>
    <div id="tenant_trade_report" style="width: 100%;height: 450px;"></div>
    <script type="text/javascript">
            $(function(){
            	jQuery().reportDate({
            		id : "tenant_trade",
            		chartURL : "${path }/report/tenant/trade/chart",
                    subitemURL : "${path }/report/tenant/trade/subitem"
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
  					'echarts/themes/red',
  					'echarts/chart/bar' 
  				], function(ec, theme) {
  					var tenant_trade_report = ec.init(document.getElementById('tenant_trade_report'), theme);
				    tenant_trade_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					    textStyle : {
                          fontSize : 20
                        }
  					});
  					tenant_trade_option = {
                        tooltip : {
                            trigger : 'axis',
                            axisPointer : {            
                                type : 'shadow' 
                            },
                            formatter: '{b}<br/> {a}: {c}万元  '
                        },
                        calculable : false,
                        xAxis : [ {
                            type : 'category',
                            boundaryGap : true,
                            data : []
                        } ],
                        yAxis : [ {
                            type : 'value',
                            axisLabel : {
                                formatter : '{value} 万元'
                            }
                        } ],
                        series : [ {
                            name : '交易总额',
                            smooth : true,
                            type : 'bar',
	                    itemStyle: {
	                        normal: {
		                        label: {
		                           show: true,
		                           position: 'top',
		                           formatter: '{c} 万元'
		                          }
	                         }
	                     },
                            data : [ ]
                         }]
  	                };
  	                var showId = ${showId};
	                var start = "${start}";
	                var end = "${end}";
					var configdata = {showId:showId,start:start,end:end};
  					// send request data.
  					$.ajax({
  						type : 'POST',
  						contentType : 'application/json;charset=utf-8',
  						url : "${path }/report/tenant/trade/data",
  						data : JSON.stringify(configdata),
  						dataType : 'json',
  						success : function(data) {
  							if (data.values.length > 0 ) {
  								tenant_trade_option.xAxis[0].data = data.labels;
  	                            tenant_trade_option.series[0].data = data.values;
  	                            tenant_trade_report.hideLoading();
  	                            tenant_trade_report.setOption(tenant_trade_option);
  							} else {
  								tenant_trade_report.hideLoading();
  								tenant_trade_report.showLoading({
                                    text: '暂无数据', 
                                    effect : 'bubble',
                                    textStyle : {
                                        fontSize : 30
                                    }
                                });
  							} 
    						
    						if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	tenant_trade_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   tenant_trade_report.resize();
                               });
                            }
  						},
  						error : function(data) {
  							tenant_trade_report.setOption(tenant_trade_option);
  							tenant_trade_report.hideLoading();
  						}
  					});

				});

			});
		</script>
  
  </body>
</html>