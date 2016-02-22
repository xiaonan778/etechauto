<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="BW" uri="http://bravowhale.com/tags"%>
<!DOCTYPE HTML>
<html>
  <head>
    <jsp:include page="../../common/meta.jsp" />
    <link rel="stylesheet" type="text/css" href="${path}/css/report/chart.css">
    <script src="${path }/resources/reveal/jquery.reveal.js" ></script>
    <script src='${path}/scripts/common/reportDate.js' type='text/javascript'></script>
  </head>
  
  <body>
    
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="product_catetenant" />
    
    <div class="container-title">
        <div class="chart-title">
            <c:choose>
                <c:when test="${showId > 0}">近${showId}天租户发布产品分布图</c:when>
                <c:otherwise>${start}至${end} 租户发布产品分布图</c:otherwise>
            </c:choose>
        </div>
        <div class="chart-subtitle">${subtext}</div>
    </div>
    <div id="product_catetenant_report" style="width: 100%;height: 450px;"></div>
    <script type="text/javascript">
    $(function(){
        jQuery().reportDate({
            id : "product_catetenant",
            chartURL : _path + "/report/product/catetenant/chart",
            subitemURL : _path + "/report/product/product_caterenant_subitem"
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
				var product_catetenant_report = ec.init(document.getElementById('product_catetenant_report'), theme);
				var showId = ${showId};
                var start = "${start}";
                var end = "${end}";
				var configdata = {showId:showId,start:start,end:end};
				var serie=[];
				product_catetenant_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
				// send request data.
				$.ajax({
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					url : "${path }/report/product/catetenant/data",
					data : JSON.stringify(configdata),  
					dataType : 'json',
					success : function(data) {
						
						if (data.tenants.length > 1){
						var labels = data.tenants;
						  for(var i =0; i<labels.length;i++) {
	                            labels[i]=labels[i].replace(/(.{6})/g,'$1\n')
	                    }
							product_catetenant_option.yAxis[0].data = labels;
	                        product_catetenant_option.legend.data = data.products;
	                        for ( var int = 0; int < data.values.length; int++) {
	                            var list_0 = data.values[int];
	                            var size = list_0.length;
	                            var list_1 = [];
	                            var tempvalue = 0;
	                            for (var i = 0; i < size; i++){
	                                tempvalue = Number(list_0[i]);
	                                list_1.push(tempvalue);
	                            }
	                            var item={
	                                    name:data.products[int],
	                                    type:'bar',
	                                    itemStyle: {
	                                       normal: {
	                                           label: {
	                                               show: true,
	                                               position: 'right',
	                                               formatter: '{c} 款'
	                                                }
	                                         }
	                                      },
	                                    data:list_1
	                            };
	                           serie.push(item);
	                        }
	                        product_catetenant_report.setOption(product_catetenant_option);
	                        product_catetenant_report.hideLoading();
	                        
	                        if(window.addEventListener){
	                            window.addEventListener("resize", function () {
	                                product_catetenant_report.resize();
	                            });
	                        } else {
	                           window.attachEvent("resize", function () {
	                               product_catetenant_report.resize();
	                           });
	                        }
						} else {
							product_catetenant_report.hideLoading();
							product_catetenant_report.showLoading({
                                text: '暂无数据', 
                                effect : 'bubble',
                                textStyle : {
                                    fontSize : 30
                                }
                            });
						}
						
					},
					error : function(data) {
						product_catetenant_report.setOption(product_catetenant_option);
						product_catetenant_report.hideLoading();
					}
				});
				product_catetenant_option = {
				    grid : {
				    	y : 80
				    },
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:[],
				        x: 80,
				        y : 45
				    },
				    calculable : false,
				    xAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    yAxis : [
				        {
				            type : 'category',
				            data : []
				            
				        }
				    ],
				    series:serie
				};
			});

		});
	</script>
  
  </body>

</html>
