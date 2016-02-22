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
    
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="pad_useInterval" />
    
    <div id="pad_useInterval_report" style="width: 100%;height: 480px;"></div>
    <script type="text/javascript">
            $(function(){
            	jQuery().reportDate({
            		id : "pad_useInterval",
            		chartURL : "${path }/report/pad/useInterval/chart",
                    subitemURL : "${path }/report/pad/useInterval/subitem"
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
  					'echarts/themes/macarons',
  					'echarts/chart/bar' 
  				], function(ec, theme) {
  					var pad_useInterval_report = ec.init(document.getElementById('pad_useInterval_report'), theme);
  					var titleText = "";
  					if(${showId}>0){
  					   titleText = "近${showId}天Pad使用间隔分布图";
				    }else{ 
				       titleText = "${start}至${end} Pad使用间隔分布图";
				    }
				    pad_useInterval_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
  					pad_useInterval_option = {
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
                            formatter: '{c}台 <br/> {a}: {b} '
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
                                formatter : '{value} 台'
                            }
                        } ],
                        series : [ {
                            name : '使用间隔',
                               itemStyle: {
	                                normal: {
		                                label: {
			                            show: true,
			                            position: 'top',
			                            formatter: '{c} 台'
		                                }
	                                 }
	                            },
                            type : 'bar',
                            data : [ ]
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
  						url : "${path }/report/pad/useInterval/data",
  						data : JSON.stringify(configdata),
  						dataType : 'json',
  						success : function(data) {
  							if (data.values.length > 0 ) {
  								pad_useInterval_option.xAxis[0].data = data.labels;
  	                            pad_useInterval_option.series[0].data = data.values;
  	                            pad_useInterval_report.hideLoading();
  							}
    						pad_useInterval_report.setOption(pad_useInterval_option);
    						
    						if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	pad_useInterval_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   pad_useInterval_report.resize();
                               });
                            }
  						},
  						error : function(data) {
  							pad_useInterval_report.setOption(pad_useInterval_option);
  							pad_useInterval_report.hideLoading();
  						}
  					});

				});

			});
		</script>
  
  </body>
</html>