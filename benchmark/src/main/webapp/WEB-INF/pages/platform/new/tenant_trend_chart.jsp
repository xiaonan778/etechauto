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
    
    <BW:datePicker flag="${showId }" items="${dicList }" prefix="tenant_trend" show="false" />
    
    <div id="tenant_trend_report" style="width: 100%;height: 480px;"></div>
    <script type="text/javascript">
		    $(function(){
		        jQuery().reportDate({
		            id : "tenant_trend",
		            chartURL : _path + "/report/tenant/trend/chart",
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
  					'echarts/chart/line' 
  				], function(ec) {
  					var tenant_trend_report = ec.init(document.getElementById('tenant_trend_report'), 'macarons');
  					var titleText = "";
  					if(${showId}>0){
  					   titleText = '近${showId}天新增租户趋势图';
				    }else{ 
				       titleText = "${start}至${end} 新增租户趋势图";
				    }
				    tenant_trend_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
  					tenant_trend_option = {
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
                            trigger : 'axis'
                        },
                        //legend : {
                        //    data : [ '新增租户' ]
                        //},
                        calculable : true,
                        xAxis : [ {
                            type : 'category',
                            boundaryGap : false,
                            data : []
                        } ],
                        yAxis : [ {
                            type : 'value',
                            axisLabel : {
                                formatter : '{value} 位'
                            }
                        } ],
                        series : [ {
                            name : '新增租户',
                            smooth : true,
                            type : 'line',
                            data : [ ],
                            markPoint : {
                                data : [ {
                                    type : 'max',
                                    name : '最大值'
                                }, {
                                    type : 'min',
                                    name : '最小值'
                                } ]
                            }
                            ,
                            markLine : {
                              data : [ {
                                  type : 'average',
                                  name : '平均值'
                              } ]
                            }
                         }]
  	                };
  	                var showId = ${showId};
  	                var start = "${start}" == "" ? null : "${start}";
                    var end = "${end}" == "" ? null : "${end}";
					var configdata = {showId:showId,start:start,end:end};
  					// send request data.
  					$.ajax({
  						type : 'POST',
  						contentType : 'application/json;charset=utf-8',
  						url : "${path }/report/tenant/trend/data",
  						data : JSON.stringify(configdata),
  						dataType : 'json',
  						success : function(data) {
  							var list_0 = data.values;
                            var size = list_0.length;

                            var list_1 = [];
                            var temp = 0;
                            for (var i = 0; i < size; i++){
                                temp = Number(list_0[i].value);
                                list_1.push(temp);
                            }
  							tenant_trend_option.xAxis[0].data = data.labels;
  							tenant_trend_option.series[0].data = list_1;
    						tenant_trend_report.setOption(tenant_trend_option);
    						tenant_trend_report.hideLoading();
    						
    						if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	tenant_trend_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   tenant_trend_report.resize();
                               });
                            }
    						try {
    							if ($("#position").val() == "summary") {
                                    var image = "<img class=\"sum-head\" src=\"${path }/resources/images/sum_head.png\"/><span class=\"sum-space\"></span>";
                                    var subitem = "<div>" + "<p>" + image + "租户总数为<span class=\"sum-important\">" + data.sum_tenant_all + "</span>位，"
                                            + data.datatime + "内新增<span class=\"sum-important\">" + data.sum_tenant_new + "</span>位，"
                                            + "占总量的<span class=\"sum-important\">"+ data.tenant_new_rate + "</span>；</p>"
                                            + "<p>" + image + data.datatime + "内租户增长最高值日期是<span class=\"sum-important\">" + data.maxDate + "</span>"
                                            + "，为<span class=\"sum-important\">" + data.maxValue + "</span>位，"
                                            + "最低值日期是<span class=\"sum-important\">" + data.minDate + "</span>"
                                            + "，为<span class=\"sum-important\">" + data.minValue + "</span>位。</p></div>";
                                    
                                    $("#tenant_trend_subitem").html(subitem);
                                }
    						}catch(e){
    							
    						}
  						},
  						error : function(data) {
  							tenant_trend_report.setOption(tenant_trend_option);
  							tenant_trend_report.hideLoading();
  						}
  					});

				});

			});
		</script>
  
  </body>

</html>
