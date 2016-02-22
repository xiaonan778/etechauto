<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="BW" uri="http://bravowhale.com/tags"%>
<!DOCTYPE HTML>
<html>
  <head>
    <jsp:include page="../../common/meta.jsp" />
    <title>平台运营数据</title>
    <link rel="stylesheet" type="text/css" href="${path}/css/report/chart.css">
    <script src="${path }/resources/reveal/jquery.reveal.js" ></script>
	<script src='${path}/scripts/common/reportDate.js' type='text/javascript'></script>
  </head>
  
  <body id="tenant_prodtrade">
    
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="tenant_prodtrade" />
    
	<div class="container-title">
        <div class="chart-title">
            <c:choose>
                <c:when test="${showId > 0}">近${showId}天租户产品交易情况分布图</c:when>
                <c:otherwise>${start}至${end} 租户产品交易情况分布图</c:otherwise>
            </c:choose>
        </div>
        <div class="chart-subtitle">${subtext}</div>
    </div>
    <div id="tenant_prodtrade_report" style="width: 100%;height: 450px;"></div>
    <script type="text/javascript">
            $(function(){
            	jQuery().reportDate({
            		id : "tenant_prodtrade",
            		chartURL:"${path }/report/tenant/prodtrade/chart",
                    subitemURL:"${path }/report/tenant/prodtrade/subitem"
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
  					var tenant_prodtrade_report = ec.init(document.getElementById('tenant_prodtrade_report'), theme);
				    tenant_prodtrade_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
  	                var showId = ${showId};
	                var start = "${start}";
	                var end = "${end}";
	                var serie=[];
					var configdata = {showId:showId,start:start,end:end};
  					// send request data.
  					$.ajax({
  						type : 'POST',
  						contentType : 'application/json;charset=utf-8',
  						url : "${path }/report/tenant/prodtrade/data",
  						data : JSON.stringify(configdata),
  						dataType : 'json',
  						success : function(data) {
  							if (data.tenants.length > 0 ) {
  							    var format = function(params) {
  						           var res = '<strong>' + params[0].name + '</strong>'
  						            for (var i = 0; i< params.length;  i++) {
  						                res += '<br/>' + params[i].seriesName + ' : ' + params[i].value+"（万元）" ;
  						            }
  						            res += '</div>';
  						          return res;
  						        }
  							    tenant_prodtrade_option.legend.data = data.products;
  								tenant_prodtrade_option.xAxis[0].data = data.tenants;
  								tenant_prodtrade_option.tooltip.formatter = format;
  								for ( var int = 0; int < data.values.length; int++) {
									var item={
							            name:data.products[int],
							            type:'bar',
							            itemStyle: {
					                        normal: {
						                        label: {
						                           show: true,
						                           position: 'top',
						                           formatter: '{c} 万元'
						                          }
					                         }
					                     },
							            data:data.values[int],
			                                markLine : {
			                                    data : [
			                                        {type : 'average', name: '平均值'}
			                                    ]
			                                }
							        	};
									   serie.push(item);
  								}
  								tenant_prodtrade_report.hideLoading();
  	                            tenant_prodtrade_report.setOption(tenant_prodtrade_option);
  							}else{
  								tenant_prodtrade_report.hideLoading();
  								tenant_prodtrade_report.showLoading({
                                     text: '暂无数据', 
                                     effect : 'bubble',
                                     textStyle : {
                                         fontSize : 30
                                     }
                                 });
  							}
  							
    						
    						if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	tenant_prodtrade_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   tenant_prodtrade_report.resize();
                               });
                            }
  						},
  						error : function(data) {
  							tenant_prodtrade_report.setOption(tenant_prodtrade_option);
  							tenant_prodtrade_report.hideLoading();
  						}
  					});
  					
  				    tenant_prodtrade_option = {
	                    tooltip : {
                            trigger : 'axis',
                            axisPointer : {            
                                type : 'shadow' 
                            }
                        },
					    legend: {
					        data:[],
					        x: 80,
		        			y : 5
					    },
					    calculable : true,
					    xAxis : [
					        {
					            type : 'category',
					            data :[ ]
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value',
					            axisLabel : {
	                            formatter : '{value} 万元'
	                       		 }
					        }
					    ],
					    series : serie
					};
				});

			});
		</script>
  
  </body>
</html>