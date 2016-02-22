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
  
  <body>
    
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="pad_tenant_loginSize" />
    
    <div id="pad_tenant_loginSize_report" style="width: 100%;height: 480px;"></div>
    <script type="text/javascript">
            $(function(){
            	jQuery().reportDate({
            		id : "pad_tenant_loginSize",
            		chartURL : "${path }/report/pad/tenantLoginSize/chart",
                    subitemURL : "${path }/report/pad/tenantLoginSize/subitem"
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
  					var pad_tenant_loginSize_report = ec.init(document.getElementById('pad_tenant_loginSize_report'), theme);
  					var titleText = "";
  					if(${showId}>0){
  					   titleText = "近${showId}天租户Pad登录数量分布图";
				    }else{ 
				       titleText = "${start}至${end} 租户Pad登录数量分布图";
				    }
				    pad_tenant_loginSize_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
  					pad_tenant_loginSize_option = {
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
                        legend: {
                            data:[''],
                            x : 80,
                            y : 65
                        },
                        grid : {
                            y : 120
                        },
                        tooltip : {
                            trigger : 'axis',
                            axisPointer : {            
                                type : 'shadow' 
                            }
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
                        series : [ 
                            {
	                            name : '',
	                            type : 'bar',
	                            itemStyle: {
	                                normal: {
		                                label: {
			                            show: true,
			                            position: 'top',
			                            formatter: '{c} 台'
		                                }
	                                 }
	                            },
	                            data : [ ]
                            },
                            {
                                name : '',
                                type : 'bar',
                                 itemStyle: {
	                                normal: {
		                                label: {
			                            show: true,
			                            position: 'top',
			                            formatter: '{c} 台'
		                                }
	                                 }
	                            },
                                data : [ ]
                            }
                        ]
  	                };
  	                var showId = ${showId};
	                var start = "${start}";
	                var end = "${end}";
					var configdata = {showId:showId,start:start,end:end};
  					// send request data.
  					$.ajax({
  						type : 'POST',
  						contentType : 'application/json;charset=utf-8',
  						url : "${path }/report/pad/tenantLoginSize/data",
  						data : JSON.stringify(configdata),
  						dataType : 'json',
  						success : function(data) {
  							
  							if (data.values.length > 0 ) {
  								var markPoint = {data : [{}]};
  								var markLine = { data : [{type : 'average', name: '平均值'}]};
  								 var labels = data.labels;
  				                for(var i =0; i<labels.length;i++) {
  				                            labels[i]=labels[i].replace(/(.{6})/g,'$1\n')
  				                }
  								pad_tenant_loginSize_option.xAxis[0].data = labels;
  								pad_tenant_loginSize_option.legend.data = data.legend;
  								pad_tenant_loginSize_option.series[0].name = data.legend[0];
  	                            pad_tenant_loginSize_option.series[0].data = data.values[0];
  	                            pad_tenant_loginSize_option.series[0].markPoint = markPoint;
  	                            pad_tenant_loginSize_option.series[0].markLine = markLine;
  	                            pad_tenant_loginSize_option.series[1].name = data.legend[1];
  	                            pad_tenant_loginSize_option.series[1].data = data.values[1];
  	                            pad_tenant_loginSize_option.series[1].markPoint = markPoint;
                                pad_tenant_loginSize_option.series[1].markLine = markLine;
  	                            pad_tenant_loginSize_report.hideLoading();
  							}
    						pad_tenant_loginSize_report.setOption(pad_tenant_loginSize_option);
    						
    						if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	pad_tenant_loginSize_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   pad_tenant_loginSize_report.resize();
                               });
                            }
  						},
  						error : function(data) {
  							pad_tenant_loginSize_report.setOption(pad_tenant_loginSize_option);
  							pad_tenant_loginSize_report.hideLoading();
  						}
  					});

				});

			});
		</script>
  
  </body>
</html>