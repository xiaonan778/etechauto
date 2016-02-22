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
    <BW:datePicker flag="${showId }" items="${ dicList}" prefix="product_publish_category" />
    
    <div class="container-title">
        <div class="chart-title">
            <c:choose>
                <c:when test="${showId > 0}">近${showId}天理财产品分类分布图</c:when>
                <c:otherwise>${start}至${end} 理财产品分类分布图</c:otherwise>
            </c:choose>
        </div>
        <div class="chart-subtitle">${subtext}</div>
    </div>
    <div id="product_publish_category_report" style=" width: 100%; height: 450px;"></div>
    <script type="text/javascript">
        $(function(){
            jQuery().reportDate({
                id : "product_publish_category",
                chartURL : _path + "/report/product/publish_category/chart",
                subitemURL : _path + "/report/product/publish_category/subitem"
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
                'echarts/chart/pie' 
            ], function(ec, theme) {
                var product_publish_category_report = ec.init(document.getElementById('product_publish_category_report'), theme);
                
                product_publish_category_report.showLoading({
                    text: '正在努力的读取数据中...', 
                });
                product_publish_category_option = {
                        tooltip : {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c}款 ({d}%)"
                        },
                        legend: {
                            orient : 'vertical',
                            x : 150,
                            y : 100,
                            data:['']
                        },
                        calculable : false,
                        color:['#fd8873','#37bfdf','#fecd5f', '#afdb9d', '#87b87f'],
                        series : [
                            {
                              name:'理财产品发布',
                              type:'pie',
                              radius : ['45%', '65%'],
                              center: ['50%', '45%'],
                              itemStyle : {
                                  normal : {
                                      label : {show : true},
                                      labelLine : {show : true}
                                  },
                                  emphasis : {
                                      label : {
                                          show : true,
                                          position : 'center',
                                          textStyle : {
                                              fontSize : '30',
                                              fontWeight : 'bold'
                                          }
                                      }
                                  }
                              },
                              data:[ ]
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
                    url : "${path }/report/product/publish_category/data",
                    data : JSON.stringify(configdata),
                    dataType : 'json',
                    success : function(data) {
                    	if ( data.values.length > 0 ) {
                    		product_publish_category_option.legend.data = data.labels;
                    		product_publish_category_option.series[0].data = data.values;
                            
                            product_publish_category_report.hideLoading();
                            product_publish_category_report.setOption(product_publish_category_option);
                            
                            if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                    product_publish_category_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                                   product_publish_category_report.resize();
                               });
                            }
                        } else {
                        	product_publish_category_report.hideLoading();
                        	product_publish_category_report.showLoading({
                                text: '暂无数据', 
                                effect : 'bubble',
                                textStyle : {
                                    fontSize : 30
                                }
                            });
                        }
                    	
                    },
                    error : function(data) {
                        product_publish_category_report.setOption(product_publish_category_option);
                        product_publish_category_report.hideLoading();
                    }
                });

            });

        });
    </script>
  
  </body>

</html>