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
    <BW:datePicker flag="${showId }" items="${ dicList}" prefix="product_trend" show="false" />
    <div id="product_trend_report" style=" width: 100%; height: 480px;"></div>
    <script type="text/javascript">
	    $(function(){
	        jQuery().reportDate({
	            id : "product_trend",
	            chartURL : _path + "/report/product/trend/chart",
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
  					'echarts/themes/shine',
  					'echarts/chart/line' 
  				], function(ec, theme) {
  					var product_trend_report = ec.init(document.getElementById('product_trend_report'), theme);
  					var titleText = "";
  					if(${showId}>0){
  					   titleText = '近${showId}天新增理财产品趋势图';
				    }else{ 
				       titleText = "${start}至${end} 新增理财产品趋势图";
				    }
				    product_trend_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
  					product_trend_option = {
 	                        title : {
 	                            text : titleText,
 	                            subtext: '${subtext}',
 	                            x:'center',
 	                            itemGap: 10,
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
 	                        calculable : false,
 	                        xAxis : [ {
 	                            type : 'category',
 	                            boundaryGap : false,
 	                            data : []
 	                        } ],
 	                        yAxis : [ {
 	                            type : 'value',
 	                            axisLabel : {
 	                                formatter : '{value} 款'
 	                            }
 	                        } ],
 	                        series : [ {
 	                            name : '新增理财产品',
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
  					var showId = ${showId};
                    var tenant_fk = "${tenant_fk}" == "" ? null : "${tenant_fk}";
                    var start = "${start}" == "" ? null : "${start}";
                    var end = "${end}" == "" ? null : "${end}";
                    var configdata = {showId:showId,start:start,end:end,tenant_fk:tenant_fk};
  					// send request data.
  					$.ajax({
  						type : 'POST',
  						contentType : 'application/json;charset=utf-8',
  						url : "${path }/report/product/trend/data",
  						data : JSON.stringify(configdata),
  						dataType : 'json',
  						success : function(data) {
  							product_trend_option.xAxis[0].data = data.labels;

    						//option.series[0].data = data.values;
    						var list_0 = data.values;
                            var size = list_0.length;
                            var list_1 = [];
                            var temp = 0;
                            for (var i = 0; i < size; i++){
                                temp = Number(list_0[i]);
                                list_1.push(temp);
                            }
                            product_trend_option.series[0].data = list_1;
                            product_trend_report.setOption(product_trend_option);
                            product_trend_report.hideLoading();
                            
                            if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	product_trend_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   product_trend_report.resize();
                               });
                            }
                            
                            try {
                                if ($("#position").val() == "summary") {
                                    var image = "<img class=\"sum-head\" src=\"${path }/resources/images/sum_head.png\"/><span class=\"sum-space\"></span>";
                                    var subitem = "<div>" + "<p>" + image + "至昨天，平台累计发布<span class=\"sum-important\">" + data.sum_product_all + "</span>"
                                           + "款产品，" + data.datatime + "内更新了<span class=\"sum-important\">" + data.sum_product_new + "</span>"
                                           + "款，占总产品的<span class=\"sum-important\">" + data.product_new_rate + "</span>；</p>"
                                           + "<p>" + image + data.datatime + "<span class=\"sum-important\">" + data.product_cate_max_name + "</span>"
                                           + "产品最多，为<span class=\"sum-important\">" + data.product_cate_max + "</span>"
                                           + "款，<span class=\"sum-important\">" + data.product_cate_min_name + "</span>"
                                           + "产品最少，为<span class=\"sum-important\">" + data.product_cate_min + "</span>款；</p>"
                                           + "<p>" + image + data.datatime + "内产品发布量最多的日期是<span class=\"sum-important\">" + data.maxDate + "</span>"
                                           + "，为<span class=\"sum-important\">" + data.maxValue + "</span>款，"
                                           + "最低的日期是<span class=\"sum-important\">" + data.minDate + "</span>"
                                           + "，为<span class=\"sum-important\">" + data.minValue + "</span>款。</p></div>";
                                    $("#product_trend_subitem").html(subitem);
                                }
                            }catch(e){} 
  						},
  						error : function(data) {
  							product_trend_report.setOption(product_trend_option);
  							product_trend_report.hideLoading();
  						}
  					});

				});

			});
	</script>
  
  </body>

</html>
