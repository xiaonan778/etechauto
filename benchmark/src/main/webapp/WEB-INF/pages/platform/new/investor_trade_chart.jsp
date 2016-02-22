<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
  <head>
    <jsp:include page="../../common/meta.jsp" />
    <title>平台运营数据</title>
    <link rel="stylesheet" type="text/css" href="${path}/css/report/chart.css">
    <script src="${path }/resources/reveal/jquery.reveal.js" ></script>
    <script src="${path}/resources/plugins/datetime/bootstrap-datetimepicker.zh-CN.js"></script>
  </head>
  
  <body>
    
    <div id="investor_trade_report" style="width: 100%;height: 480px;"></div>
    
    <script type="text/javascript">
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
                    var investor_trade_report = ec.init(document.getElementById('investor_trade_report'), theme);
                    investor_trade_report.showLoading({
                        text: '正在努力的读取数据中...', 
                    });
                    
                    investor_trade_option = {
                            title : {
                                text : "近30天投资人交易情况分布图",
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
                                y : 110
                            },
                            tooltip : {
                                trigger : 'axis'
                            },
                            legend : {
                                data : [ '' ],
                                x : 80,
                                y : 55
                            },
                            calculable : false,
                            xAxis : [ {
                                type : 'category',
                                data : [ '' ]
                            } ],
                            yAxis : [ {
                                type : 'value',
                                axisLabel : {
                                    formatter : '{value}单'
                                }
                            } ],
                            series : [ 
                              {
                                name : '',
                                type : 'bar',
                                data : [ ],
                                itemStyle: {
        	                        normal: {
        		                        label: {
        		                           show: true,
        		                           position: 'top',
        		                           formatter: '{c}'
        		                          }
        	                         }
        	                     },
                                markPoint : {}
                              },
                              {
                                 name : '',
                                 type : 'bar',
                                 data : [ ],
                                 itemStyle: {
         	                        normal: {
         		                        label: {
         		                           show: true,
         		                           position: 'top',
         		                           formatter: '{c}'
         		                          }
         	                         }
         	                     },
                                 markPoint : {}
                               } 
                            ]
                    };
                    // send request data.
                    var showId = ${showId};
                    var tenant_fk = "${tenant_fk}" == "" ? null : "${tenant_fk}";
                    var start = "${start}" == "" ? null : "${start}";
                    var end = "${end}" == "" ? null : "${end}";
                    var configdata = {showId:showId,start:start,end:end,tenant_fk:tenant_fk};
                    $.ajax({
                        type : 'POST',
                        contentType : 'application/json;charset=utf-8',
                        url : "${path }/report/investor/trade/data",
                        data : JSON.stringify(configdata),
                        dataType : 'json',
                        success : function(data) {
                            if ( data.values.length > 0 ){
                            	investor_trade_option.legend.data = data.legend;
                                investor_trade_option.xAxis[0].data = data.labels;   
                                investor_trade_option.series[0].data = data.values[0];
                                investor_trade_option.series[0].name = data.legend[0];
                                investor_trade_option.series[0].markPoint = {data : []};
                                investor_trade_option.series[1].data = data.values[1];
                                investor_trade_option.series[1].name = data.legend[1];
                                investor_trade_option.series[1].markPoint = {data : []};
                                investor_trade_report.hideLoading();
                            }
                            investor_trade_report.setOption(investor_trade_option);
                            if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	investor_trade_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   investor_trade_report.resize();
                               });
                            }
                        },
                        error : function(data) {
                            investor_trade_report.setOption(investor_trade_option);
                            investor_trade_report.hideLoading();
                        }
                    });
                });

            });
        </script>
  
  </body>

</html>