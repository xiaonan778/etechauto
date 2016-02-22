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
  
  <body id="trade_trend">
    
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="trade_trend" />
    
    <div id="trade_trend_report" style="width: 100%;height: 480px;"></div>
    <script type="text/javascript">
            $(function(){
            	jQuery().reportDate({
            		id : "trade_trend",
            		chartURL:"${path }/report/trade/trend/chart",
                    subitemURL:"${path }/report/trade/trend/subitem"
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
  					'echarts/themes/blue',
  					'echarts/chart/line' 
  				], function(ec, theme) {
  					var trade_trend_report = ec.init(document.getElementById('trade_trend_report'), theme);
  					var titleText = "";
  					if(${showId}>0){
  					   titleText = '近${showId}天产品交易趋势分布图';
				    }else{ 
				       titleText = "${start}至${end} 产品交易趋势分布图";
				    }
				    trade_trend_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
  					trade_trend_option = {
                        title : {
                            text : titleText,
                            subtext : "${subtext}",
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
                            formatter: '{b}<br/> {a}: {c}万元  '
                        },
                        legend : {
                            data : [ '交易金额' ],
                            x : 80,
                            y : 60
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
                            name : '交易金额',
                            smooth : true,
                            type : 'line',
                            data : [ ],
                            markPoint : {
                                data : [ {
                                    type : 'max',
                                    name : '最大值（万元）'
                                }, {
                                    type : 'min',
                                    name : '最小值（万元）'
                                } ]
                            }
                            ,
                            markLine : {
                              data : [ {
                                  type : 'average',
                                  name : '平均值（万元）'
                              } ]
                            }
                         }]
  	                };
  	                var showId = ${showId};
	                var start = "${start}";
	                var end = "${end}";
	                var tenant_fk = "${tenant_fk}" == "" ? null : "${tenant_fk}";
					var configdata = {showId:showId,start:start,end:end,tenant_fk:tenant_fk};
  					// send request data.
  					$.ajax({
  						type : 'POST',
  						contentType : 'application/json;charset=utf-8',
  						url : "${path }/report/trade/trend/data",
  						data : JSON.stringify(configdata),
  						dataType : 'json',
  						success : function(data) {
  							if (data.values.length > 0 ) {
  								trade_trend_option.xAxis[0].data = data.labels;
  	                            trade_trend_option.series[0].data = data.values;
  	                            trade_trend_report.hideLoading();
  							}
    						trade_trend_report.setOption(trade_trend_option);
    						if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	trade_trend_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   trade_trend_report.resize();
                               });
                            }
  						},
  						error : function(data) {
  							trade_trend_report.setOption(trade_trend_option);
  							trade_trend_report.hideLoading();
  						}
  					});

				});

			});
		</script>
  
  </body>
</html>