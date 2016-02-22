<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://benchmark.com/tags" prefix="BW" %>
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
  
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="product_category_ratio" />
    
    <div class="container-title">
        <div class="chart-title">
            <c:choose>
                <c:when test="${showId > 0}">近${showId}天产品年化利率分布图</c:when>
                <c:otherwise>${start}至${end} 产品年化利率分布图</c:otherwise>
            </c:choose>
        </div>
        <div class="chart-subtitle">${subtext}</div>
    </div>
    <div id="product_category_ratio_report" style="width: 100%; height: 420px;"></div>
    <script type="text/javascript">
		    $(function(){
		        jQuery().reportDate({
		            id : "product_category_ratio",
		            chartURL : "${path }/report/product/category_ratio/chart",
		            subitemURL : "${path }/report/product/category_ratio/subitem"
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
                    'echarts/themes/roma',
                    'echarts/chart/pie' 
                ], function(ec, theme) {
                    var product_category_ratio_report = ec.init(document.getElementById('product_category_ratio_report'), theme);
                    
                    product_category_ratio_report.showLoading({
                        text: '正在努力的读取数据中...', 
                        textStyle : {
                            fontSize : 20
                        }
                    });
                    var dataStyle = {
                        normal: {
                            label: {show:false},
                            labelLine: {show:false}
                        }
                    };
                    var placeHolderStyle = {
                        normal : {
                            color: 'rgba(0,0,0,0)',
                            label: {show:false},
                            labelLine: {show:false}
                        },
                        emphasis : {
                            color: 'rgba(0,0,0,0)'
                        }
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
                        url : "${path }/report/product/category_ratio/data",
                        data : JSON.stringify(configdata),
                        dataType : 'json',
                        success : function(data) {
                            
                            var datavalues = data.ratioValues;
                            var size = datavalues.length;
                            if (size > 0 ) {
                            	product_category_ratio_option.legend.data = data.ratioLabels;
                                var series = [];
                                var radius = 150;
                                for (var i = 0; i < size; i ++) {
                                    var cate = datavalues[i];
                                    var item = {
                                        name: cate.name,
                                        type:'pie',
                                        clockWise:false,
                                        radius : [radius - 25 * (i + 1), radius - 25 * i],
                                        itemStyle : dataStyle,
                                        data:[
                                            {
                                                value: cate.value,
                                                name: cate.name
                                            },
                                            {
                                                value:cate.others,
                                                name:'Others',
                                                itemStyle : placeHolderStyle
                                            }
                                        ]
                                    };
                                    series.push(item);
                                    product_category_ratio_option.series = series;
                                    product_category_ratio_report.hideLoading();
                                }
                                
                                if(window.addEventListener){
                                    window.addEventListener("resize", function () {
                                    	product_category_ratio_report.resize();
                                    });
                                } else {
                                   window.attachEvent("resize", function () {
                                	   product_category_ratio_report.resize();
                                   });
                                }
                                product_category_ratio_report.setOption(product_category_ratio_option);
                            }else{
                            	product_category_ratio_report.hideLoading();
                            	product_category_ratio_report.showLoading({
                                    text: '暂无数据', 
                                    effect : 'bubble',
                                    textStyle : {
                                        fontSize : 30
                                    }
                                });
                            }
                            
                        },
                        error : function(data) {
                            product_category_ratio_report.setOption(product_category_ratio_option);
                            product_category_ratio_report.hideLoading();
                        }
                    });
                    
                    product_category_ratio_option = {
                         tooltip :{
                             show: true,
                             formatter: "{b} <br/> 数量： {c} (占该类产品总数的{d}%)"
                         },
                         legend: {
                             orient : 'vertical',
                             x : 80,
                             y : 100,
                             itemGap:12,
                             data:['']
                         },
                         calculable : false,
                         series : [
                             {
                               name:'',
                               type:'pie',
                               radius : ['45%', '65%'],
                               data:[ ]
                            }
                         ]
                     };
                });

            });
    </script>
  
  </body>
</html>