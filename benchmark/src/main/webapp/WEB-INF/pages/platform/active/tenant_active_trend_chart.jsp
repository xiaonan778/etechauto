<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://bravowhale.com/tags" prefix="BW" %>
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
  
    <BW:datePicker flag="${showId }" items="${ dicList}" prefix="tenant_active" show="false" />
    
    <div id="tenant_active_report" style="width: 100%;height: 480px;"></div>
    <script>
	    $(function(){
	        jQuery().reportDate({
	            id : "tenant_active",
	            chartURL : _path + "/report/tenant/active/chart",
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
				'echarts/themes/sakura',
				'echarts/chart/line' 
			], function(ec, theme) {
				var tenant_active_report = ec.init(document.getElementById('tenant_active_report'), theme);
				var titleText = "";
				if(${showId}>0){
					titleText = '近${showId}天活跃租户趋势图';
				}else{ 
					titleText = "${start}至${end} 活跃租户趋势图";
				}
				var showId = ${showId};
				var start = "${start}" == "" ? null : "${start}";
                var end = "${end}" == "" ? null : "${end}";
				var configdata = {showId:showId,start:start,end:end};
				tenant_active_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
				// send request data.
				$.ajax({
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					url : "${path }/report/tenant/active_chart/data",
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
						tenant_active_tent_option.xAxis[0].data = data.labels;
						tenant_active_tent_option.series[0].data = list_1;
						tenant_active_report.setOption(tenant_active_tent_option);
						tenant_active_report.hideLoading();
						
						if(window.addEventListener){
                            window.addEventListener("resize", function () {
                            	tenant_active_report.resize();
                            });
                        } else {
                           window.attachEvent("resize", function () {
                        	   tenant_active_report.resize();
                           });
                        }
						
						try {
                            if ($("#position").val() == "summary") {
                                var image = "<img class=\"sum-head\" src=\"${path }/resources/images/sum_head.png\"/><span class=\"sum-space\"></span>";
                                var subitem = "<div>" + "<p>" + image + "活跃租户总数为<span class=\"sum-important\">" + data.tenant_active_size_all + "</span>位，"
                                       + data.datatime + "内新增<span class=\"sum-important\">" + data.tenant_active_size_days + "</span>"
                                       + "位，占总量的<span class=\"sum-important\">" + data.tenant_active_increasement_rate + "</span>；</p>"
                                       + "<p>" + image + data.datatime + "内活跃租户数最多的日期是<span class=\"sum-important\">" + data.maxDate + "</span>"
                                       + "，为<span class=\"sum-important\">" + data.maxValue + "</span>位，"
                                       + "最少的日期是<span class=\"sum-important\">" + data.minDate + "</span>"
                                       + "，为<span class=\"sum-important\">" + data.minValue + "</span>位。</p></div>";
                                $("#tenant_active_subitem").html(subitem);
                            }
                        }catch(e){} 
					},
					error : function(data) {
						tenant_active_report.setOption(tenant_active_tent_option);
						tenant_active_report.hideLoading();
					}
				});
				tenant_active_tent_option = {
						    title : {
						        text: titleText,
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
						        trigger: 'axis'
						    },
						    //legend: {
						    //    data:['活跃租户数']
						    //},
						    calculable : true,
						    xAxis : [
						        {
						            type : 'category',
						            data : []
						        }
						    ],
						    yAxis : [
						        {
						            type : 'value',
	                                axisLabel : {
	                                    formatter : '{value} 位'
	                                }
						        }
						    ],
						    series : [ {
  	                            name : '活跃租户数',
  	                            smooth : true,
  	                            type : 'line',
  	                            data : [ ],
  	                            markPoint : {
  	                                data : [ 
  	                                    {type : 'max', name : '最大值'}, 
  	                                    {type : 'min', name : '最小值'} 
  	                                 ]
  	                                },
  	                            markLine : {
  	                                  data : [
  	                                    {type : 'average', name: '平均值'}
  	                              ]
  	                             }
  	                        } ]
						};
			});

		});
	</script>
  
  </body>

</html>
