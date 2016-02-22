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
    
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="pad_frequency" show="false" />
    
    <div id="pad_frequency_report" style="width: 100%;height: 480px;"></div>
    
    <script type="text/javascript">
		   $(function(){
		       jQuery().reportDate({
		           id : "pad_frequency",
		           chartURL : _path + "/report/pad/frequency/chart",
		           subitemURL : _path + "/report/pad/frequency_sum_subitem",
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
  					'echarts/themes/blue',
  					'echarts/chart/bar' 
  				], function(ec, theme) {
  					var pad_frequency_report = ec.init(document.getElementById('pad_frequency_report'), theme);
  					pad_frequency_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
  					var titleText = "";
                    if(${showId} > 0) {
                        titleText = "近${showId}天Pad使用频次分布图";
                    }else{ 
                        titleText = "${start} 至  ${end} Pad使用频次分布图";
                    }
  					pad_frequency_option = {
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
                                formatter: '{c}台 <br/> {a}: {b} 次'
                            },
                            //legend : {
                            //    data : [ 'Pad使用频次' ]
                            //},
                            calculable : false,
                            xAxis : [ {
                                type : 'category',
                                data : [ '' ],
                                axisLabel : {
                                    formatter : '{value} 次'
                                }
                            } ],
                            yAxis : [ {
                                type : 'value',
                                axisLabel : {
                                    formatter : '{value} 台'
                                }
                            } ],
                            series : [ {
                                name : 'Pad使用频次',
                                smooth: true,
                                type : 'bar',
                                data : [ ],
                                itemStyle: {
                                    normal: {
                                        label: {
                                        show: true,
                                        position: 'top',
                                        formatter: '{c} 台'
                                        }
                                     }
                                },
                            } ]
                    };
  					// send request data.
  					var showId = ${showId};
                    var start = "${start}";
                    var end = "${end}";
                    var tenant_fk = "${tenant_fk}" == "" ? null : "${tenant_fk}";
                    var configdata = {showId:showId,start:start,end:end,tenant_fk:tenant_fk};
  					$.ajax({
  						type : 'POST',
  						contentType : 'application/json;charset=utf-8',
  						url : "${path }/report/pad/frequency/data",
  						data : JSON.stringify(configdata),
  						dataType : 'json',
  						success : function(data) {
  							if ( data.labels.length > 0 ){
  								pad_frequency_option.xAxis[0].data = data.labels;	
  							}
    						var list_0 = data.values;
    						var size = list_0.length;
    						var list_1 = [];
    						var temp = 0;
    						for (var i = 0; i < size; i++){
    							temp = Number(list_0[i]);
    							list_1.push(temp);
    						}
    						pad_frequency_option.series[0].data = list_1;
    						pad_frequency_report.setOption(pad_frequency_option);
    						pad_frequency_report.hideLoading();
    						
    						if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	pad_frequency_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   pad_frequency_report.resize();
                               });
                            }
  						},
  						error : function(data) {
  							pad_frequency_report.setOption(pad_frequency_option);
  							pad_frequency_report.hideLoading();
  						}
  					});
				});

			});
		</script>
  
  </body>

</html>
