<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="BW" uri="http://benchmark.com/tags"%>
<!DOCTYPE HTML>
<html>
  <head>
    <jsp:include page="../../common/meta.jsp" />
    <link rel="stylesheet" type="text/css" href="${path}/css/report/chart.css">
    <script src="${path }/resources/reveal/jquery.reveal.js" ></script>
    <script src='${path}/scripts/common/reportDate.js' type='text/javascript'></script>
  </head>
  
  <body>
    
    <BW:datePicker flag="${showId }" items="${dicList}" prefix="product_trade_category" />
    
    <div class="container-title">
        <div class="chart-title">
            <c:choose>
                <c:when test="${showId > 0}">近${showId}天新增理财产品交易分布图</c:when>
                <c:otherwise>${start}至 ${end} 新增理财产品交易分布图</c:otherwise>
            </c:choose>
        </div>
        <div class="chart-subtitle">${subtext}</div>
    </div>
    <div id="product_trade_category_report" style="width: 100%; height: 450px;"></div>
    
    <script type="text/javascript">
	    $(function(){
	        jQuery().reportDate({
	            id : "product_trade_category",
	            chartURL : "${path }/report/product/trade_category/chart",
	            subitemURL : "${path }/report/product/trade_category/subitem"
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
				'echarts/chart/pie' 
			], function(ec) {
				var product_trade_category_report = ec.init(document.getElementById('product_trade_category_report'), 'macarons');
				product_trade_category_report.showLoading({
                    text: '正在努力的读取数据中...', 
                    textStyle : {
                        fontSize : 20
                    }
                });
                
				option_product_trade_category = {
					tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c}单 ({d}%)"
				    },
				    legend: {
				        orient : 'vertical',
				        x : 150,
				        y : 100,
				        data:['']
				    },
					calculable : false,
					series : [
			            {
			              name:'理财产品分类',
			              type:'pie',
			              radius : ['45%', '65%'],
			              itemStyle : {
			                  normal : {
			                      label : {
			                          show : true
			                      },
			                      labelLine : {
			                          show : true
			                      }
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
			   // send request data.
               var showId = ${showId};
               var start = "${start}";
               var end = "${end}";
               var configdata = {showId:showId,start:start,end:end};
               $.ajax({
                   type : 'POST',
                   url : "${path }/report/product/trade/data",
                   contentType : 'application/json;charset=utf-8',
                   data: JSON.stringify(configdata),  
                   dataType : 'json',
                   success : function(data) {
                       if (data.values.length > 0 ) {
                           option_product_trade_category.series[0].data = data.values;
                           option_product_trade_category.legend.data = data.labels;
                           product_trade_category_report.hideLoading();
                           
                           if(window.addEventListener){
                              window.addEventListener("resize", function () {
                                   product_trade_category_report.resize();
                               });
                           } else {
                              window.attachEvent("resize", function () {
                                 product_trade_category_report.resize();
                              });
                           }
                          product_trade_category_report.setOption(option_product_trade_category);
                       } else {
                           product_trade_category_report.hideLoading();
                           product_trade_category_report.showLoading({
                               text: '暂无数据', 
                               effect : 'bubble',
                               textStyle : {
                                   fontSize : 30
                               }
                           });
                       }
                       
                   },
                   error : function(data) {
                       product_trade_category_report.setOption(option_product_trade_category);
                       product_trade_category_report.hideLoading();
                   }
               });

		   });

	   });
	</script>
  
  </body>

</html>
