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
  
  <body >
  
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="cfp_active_detail" />
    
    <div id="cfp_active_detail_report" style="width: 100%;height: 480px;"></div>
    <script type="text/javascript">
            $(function(){
            	jQuery().reportDate({
            		id : "cfp_active_detail",
            		chartURL : "${path }/report/cfp/active_detail/chart"
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
  					var cfp_active_detail_report = ec.init(document.getElementById('cfp_active_detail_report'), theme);
  					var titleText = "";
  					if(${showId}>0){
  					   titleText = "近${showId}天活跃理财师构成分布图";
				    }else{ 
				       titleText = "${start}至${end} 活跃理财师构成分布图";
				    }
				    cfp_active_detail_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
  					cfp_active_detail_option = {
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
                            data:['新用户','老用户','新用户占比'],
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
                            },
                            formatter : function(params, ticket, callback){
                            	var tooltip = "";
                            	for (var i = 0; i < params.length; i++) {
                            		var data = params[i];
                            		if (i == 0) {
                            			tooltip = data.name + "<br/>";
                            		}
                            		var seriesIndex = data.seriesIndex;
                            		if (seriesIndex == 2) {
                            			tooltip = tooltip + data.seriesName + "：" + data.value + "%<br/>";
                            		} else {
                            			tooltip = tooltip + data.seriesName + "：" + data.value + "位<br/>";
                            		}
                            	}
                            	return "<div>" + tooltip + "</div>";
                            }
                        },
                        calculable : false,
                        xAxis : [ {
                            type : 'category',
                            boundaryGap : true,
                            data : []
                        } ],
                        yAxis : [ 
                            {
	                            type : 'value',
	                            axisLabel : {
	                                formatter : '{value} 位'
	                            }
                            },
                            {
                                type : 'value',
                                axisLabel : {
                                    formatter: '{value} %'
                                }
                            }
                        ],
                        series : [ 
                          {
                            name : '新用户',
                            type : 'bar',
                            itemStyle: {
    	                        normal: {
    		                        label: {
    		                           show: true,
    		                           position: 'top',
    		                           formatter: '{c} '
    		                          }
    	                         }
    	                     },
                            data : [ ]
                          },
                          {
                            name : '老用户',
                            type : 'bar',
                            itemStyle: {
    	                        normal: {
    		                        label: {
    		                           show: true,
    		                           position: 'top',
    		                           formatter: '{c} '
    		                          }
    	                         }
    	                     },
                            data : [ ]
                          },
                          {
                              name : '新用户占比',
                              type:'line',
                              yAxisIndex: 1,
                              smooth : true,
                              data : [ ]
                            }
                        ]
  	                };
  					var showId = ${showId};
  	                var tenant_fk = "${tenant_fk}" == "" ? null : "${tenant_fk}";
  	                var start = "${start}" == "" ? null : "${start}";
  	                var end = "${end}" == "" ? null : "${end}";
  	                var configdata = {showId:showId,start:start,end:end,tenant_fk:tenant_fk};
  					// send request data.
  					$.ajax({
  						type : 'POST',
  						contentType : 'application/json;charset=utf-8',
  						url : "${path }/report/cfp/active_detail/data",
  						data : JSON.stringify(configdata),
  						dataType : 'json',
  						success : function(data) {
  							if (data.values.length > 0 ) {
  								cfp_active_detail_option.xAxis[0].data = data.labels;
  	                            cfp_active_detail_option.series[0].data = data.values[0];
  	                            cfp_active_detail_option.series[1].data = data.values[1];
  	                            cfp_active_detail_option.series[2].data = data.values[2];
  	                            cfp_active_detail_report.hideLoading();
  							}
    						cfp_active_detail_report.setOption(cfp_active_detail_option);
    						
    						if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	cfp_active_detail_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   cfp_active_detail_report.resize();
                               });
                            }
    						
    						try {
                                if ($("#position").val() == "summary") {
                                    var image = "<img class=\"sum-head\" src=\"${path }/resources/images/sum_head.png\"/><span class=\"sum-space\"></span>";
                                    var subitem = "<div>"
                                            + "<p>" + image + data.datatime + "内新用户活跃峰值为<span class=\"sum-important\">" + data.maxDate_new + "</span>"
                                            + "，达<span class=\"sum-important\">" + data.maxValue_new + "</span>位，"
                                            + "老用户活跃峰值为<span class=\"sum-important\">" + data.maxDate_old + "</span>"
                                            + "，达<span class=\"sum-important\">" + data.maxValue_old + "</span>位；</p>"
                                            + "<p>" + image + data.datatime + "内新用户活跃谷值为<span class=\"sum-important\">" + data.minDate_new + "</span>"
                                            + "，达<span class=\"sum-important\">" + data.minValue_new + "</span>位，"
                                            + "老用户活跃谷值为<span class=\"sum-important\">" + data.minDate_old + "</span>"
                                            + "，达<span class=\"sum-important\">" + data.minValue_old + "</span>位。</p></div>";
                                    
                                    $("#cfp_active_detail_subitem").html(subitem);
                                }
                            }catch(e){}
  						},
  						error : function(data) {
  							cfp_active_detail_report.setOption(cfp_active_detail_option);
  							cfp_active_detail_report.hideLoading();
  						}
  					});

				});

			});
		</script>
  
  </body>
</html>