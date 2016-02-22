<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="BW" uri="http://benchmark.com/tags"%>
<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="../../common/meta.jsp" />
    <title>平台运营数据</title>
    <link rel="stylesheet" type="text/css" href="${path}/css/report/chart.css">
    <script src="${path }/resources/reveal/jquery.reveal.js" ></script>
    <script src='${path}/scripts/common/reportDate.js' type='text/javascript'></script>
  </head>
  
  <body>
    
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="product_appointment" />
    
    <div class="container-title">
        <div class="chart-title">
            <c:choose>
                <c:when test="${showId > 0}">近${showId}天产品是否预约情况分布图</c:when>
                <c:otherwise>${start}至${end} 产品是否预约情况分布图</c:otherwise>
            </c:choose>
        </div>
        <div class="chart-subtitle">${subtext}</div>
    </div>
    <div id="product_appointment_report"  style="width: 100%;height: 450px;"></div>
    <script type="text/javascript">
		    $(function(){
		        jQuery().reportDate({
		            id : "product_appointment",
		            chartURL : "${path }/report/product/appointment/chart",
		            subitemURL : "${path }/report/product/appointment/subitem"
		        });
		    });
            require.config({
                paths : {
                    echarts : '${path}/resources/echarts-2.2.1'
                }
            });
            
            // ------------------------------------------------------------------------------------------------------------------------------------------
            $(function() {
                require([ 
                    'echarts', 
                    'echarts/themes/macarons',
                    'echarts/chart/pie' 
                ], function(ec, theme) {
                    var product_appointment_report = ec.init(document.getElementById('product_appointment_report'), theme);
                    
                    product_appointment_report.showLoading({
                        text: '正在努力的读取数据中...', 
                        textStyle : {
                            fontSize : 20
                        }
                    });
                    product_appointment_option = {
                        tooltip : {
                            show: true,
                            formatter: "{b} <br/> {c} ({d}%)"
                        },
                        legend: {
                        	orient : 'vertical',
                            x : 100,
                            y : 100,
                            data:['']
                        },
                        series : [
                              {   name:'是否需要预约',
                                  type:'pie',
                                  selectedMode: 'single',
                                  radius : [0, 40],
                                  
                                  // for funnel
                                  x: '20%',
                                  width: '40%',
                                  funnelAlign: 'right',
                                  max: 1548,
                                  
                                  itemStyle : {
                                      normal : {
                                          label : {
                                              position : 'outer'
                                          }
                                      }
                                  },
                                  data:[]
                              },
                              {
                                  name:'理财产品分类',
                                  type:'pie',
                                  radius : [130, 170],
                                  
                                  // for funnel
                                  x: '60%',
                                  width: '35%',
                                  funnelAlign: 'left',
                                  max: 1048,
                                  
                                  data:[]
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
                        url : "${path }/report/product/appointment/data",
                        data : JSON.stringify(configdata),
                        dataType : 'json',
                        success : function(data) {
                            if ( data.appointment.length == 0) {
                                product_appointment_report.hideLoading();
                                product_appointment_report.showLoading({
                                    text: '暂无数据', 
                                    effect : 'bubble',
                                    textStyle : {
                                        fontSize : 30
                                    }
                                });
                            }else {
                                if (data.cateValues.length != 0){
                                	product_appointment_option.legend.data = data.cateLabels;
                                	product_appointment_option.series[1].data = data.cateValues;
                                }
                                product_appointment_option.series[0].data = data.appointment;
                                
                                product_appointment_report.setOption(product_appointment_option);
                                product_appointment_report.hideLoading();
                                
                                if(window.addEventListener){
                                    window.addEventListener("resize", function () {
                                    	product_appointment_report.resize();
                                    });
                                } else {
                                   window.attachEvent("resize", function () {
                                	   product_appointment_report.resize();
                                   });
                                }
                            }
                        },
                        error : function(data) {
                            product_appointment_report.setOption(product_appointment_option);
                            product_appointment_report.hideLoading();
                        }
                    });

                });

            });
    </script>
  
  </body>
</html>