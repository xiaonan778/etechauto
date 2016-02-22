<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <title>平台运营数据-Dashboard</title> 
    <link rel="stylesheet" type="text/css" href="${path }/css/report/dashboard.css">
    <script src="${path}/resources/jquery/1.11.1/jquery.min.js"></script>
    <script src='${path}/resources/echarts-2.2.1/echarts.js' type='text/javascript'></script>
</head>
<body>
    <div class="box">
        <div class="box_top">
            <div class="top_no1">
                <h1>累计租户</h1>
                <span>(累计: <b>${tenant_sum_all }</b> 家)</span>
                <div id="tenant_sum_chart" style="width:400px;height:200px;padding:10px;"></div>
            </div>
            <script type="text/javascript">
                require.config({
                    paths : {
                        echarts : '${path}/resources/echarts-2.2.1'
                    }
                });
                require(
                    [
                        'echarts',
                        'echarts/chart/line'
                    ],
                    function (echarts){
                        var tenant_sum_chart = echarts.init(document.getElementById('tenant_sum_chart') );                                  
                        
                        option_tenant_sum = {
                            tooltip : {
                                trigger: 'axis'
                            },
                            color:['#71b4fe'],
                            calculable : false,
                            grid : {
                                x : 45,    // 图表在容器内的左边距
                                y : 20,    // 图表在容器内的上边距
                                x2 : 40,   // 图表在容器内的右边距
                                y2 : 23,   // 图表在容器内的下边距
                                backgroundColor : '#01172e',    // 图表背景色
                                borderColor:'#ccc',
                                borderWidth : 0      // 图表边框
                            },
                            xAxis : [
                                {
                                    type : 'category',
                                    boundaryGap : false,
                                    data : [''],
                                    axisLabel : {
                                        textStyle : {
                                            color : '#999' // X轴标签颜色
                                        }
                                    },
                                     axisLine:{
                                        lineStyle:{
                                            color:'#6e7986',
                                            width:2,
                                            type:'solid'
                                        }
                                   },
                                    splitLine : {   // 图表中的分割线
                                        show: false  // 分割线的显示控制， true为显示， false为隐藏
                                        
                                    }
                                }
                            ],
                            yAxis : [
                                {
                                    type : 'value',
                                    boundaryGap: [0, 0.1],
                                    axisLabel : {
                                        textStyle : {
                                            color : '#999'
                                        }
                                    },
                                     axisLine:{
                                        lineStyle:{
                                            color:'#6e7986',
                                            width:2,
                                            type:'solid'
                                        }
                                   },
                                    splitLine : {   // 图表中的分割线
                                        show: true,     // 分割线的显示控制， true为显示， false为隐藏
                                        lineStyle : {
                                            color: '#26394d',   // 图表中的分割线 颜色
                                            width: 1,  
                                            type: 'solid'
                                        }
                                    }
                                }
                            ],
                            series : [
                                {
                                    name:'租户',
                                    type:'line',
                                    itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                    data:[]
                                }
                            ]
                        };                                      
                        //-----------------------------------------  
                        $.ajax({
                            type : 'POST',
                            url : "${path }/report/tenant/tenant_sum/data",
                            dataType : 'json',
                            success : function(data) {
                                if ( data.values.length > 0 ) {
                                	option_tenant_sum.xAxis[0].data = data.labels;  
                                	option_tenant_sum.series[0].data = data.values;
                                }
                                tenant_sum_chart.setOption(option_tenant_sum);
                            },
                            error : function(data) {
                            	tenant_sum_chart.setOption(option_tenant_sum);
                            }
                        });
                        //--------------------------
                    }
                );
            </script>
            <div class="top_no2">
                <h1>累计理财师</h1>
                <span>(累计: <b>${finPlanner_sum_all }</b> 人)</span>
                <div id="finPlanner_all_chart" style="width:400px;height:200px;padding:10px;"></div>
            </div>
            <script type="text/javascript">
              require.config({
                paths : {
                    echarts : '${path}/resources/echarts-2.2.1'
                }
              });
              require(
                [
                    'echarts',
                    'echarts/chart/bar'
                ],
                function (echarts){
                    var finPlanner_all_chart = echarts.init(document.getElementById('finPlanner_all_chart'));              
                    option_finPlanner_all = {
                        tooltip : {
                            trigger: 'axis',
                            axisPointer : {            
                                type : 'shadow' 
                            }
                        },
                        
                        grid : {
                            x : 45,    // 图表在容器内的左边距
                            y : 30,    // 图表在容器内的上边距
                            x2 : 40,   // 图表在容器内的右边距
                            y2 : 23,   // 图表在容器内的下边距
                            backgroundColor : '#01172e',    // 图表背景色
                            borderWidth : 0      // 图表边框
                        },
                        color:['#3f9ddd'],
                        calculable : false,
                        xAxis : [
                            {
                                type : 'category',
                                data : [''],
                                show:false,
                                axisLabel : {
                                    textStyle : {
                                        color : '#999'
                                    }
                                },
                                 axisLine:{
                                        lineStyle:{
                                            color:'#6e7986',
                                            width:2,
                                            type:'solid'
                                        }
                                   },
                                splitLine : {   // 图表中的分割线
                                    show: false  // 分割线的显示控制， true为显示， false为隐藏
                                }
                            }
                        ],
                        yAxis : [
                            {
                                type : 'value',
                                axisLabel : {
                                    textStyle : {
                                        color : '#999'
                                    }
                                },
                                 axisLine:{
                                        lineStyle:{
                                            color:'#6e7986',
                                            width:2,
                                            type:'solid'
                                        }
                                   },
                                splitLine : {   // 图表中的分割线
                                        show: true,  // 分割线的显示控制， true为显示， false为隐藏
                                        lineStyle : {
                                            color: '#26394d',   // 图表中的分割线 颜色
                                            width: 1,  
                                            type: 'solid'
                                        }
                                    }
                            }
                        ],
                        series : [
                            {
                                name:'理财师',
                                type:'bar',
                                stack: 'sum',
                                barCategoryGap: '50%',
                                itemStyle: {
                                    normal: {
                                    	label : {
                                            show: true, 
                                            position: 'top', 
                                            textStyle : {color : '#fff'}
                                        }
                                    }
                                },
                                data:[]
                            }
                        ]
                    };
                    //-----------------------------------------  
                    $.ajax({
                        type : 'POST',
                        url : "${path }/report/cfp/finPlanner_groupByTenant/data",
                        dataType : 'json',
                        success : function(data) {
                            if ( data.values.length > 0 ) {
                            	option_finPlanner_all.xAxis[0].data = data.labels;   
                            	option_finPlanner_all.series[0].data = data.values;
                                
                            }
                            finPlanner_all_chart.setOption(option_finPlanner_all);
                        },
                        error : function(data) {
                        	finPlanner_all_chart.setOption(option_finPlanner_all);
                        }
                    });
                    //--------------------------
                }
            );

            </script>
            <div class="top_no3">
                <h1>累计投资人</h1>
                <span>(累计: <b>${investor_sum_all }</b> 人)</span>
                <div id="investor_all_chart" style="width:400px;height:200px;padding:10px;"></div>
            </div>
            <script type="text/javascript">
            require.config({
                paths : {
                    echarts : '${path}/resources/echarts-2.2.1'
                }
            });
            require(
                [
                    'echarts',
                    'echarts/chart/bar',
                ],
                function (echarts){
                    var investor_all_chart = echarts.init(document.getElementById('investor_all_chart'));              
                    option_investor_all = {
                         tooltip : {
                             trigger: 'axis',
                             axisPointer : {            
                                 type : 'shadow' 
                             }
                         },
                         color:['#e37361'],
                         calculable : false,
                         grid : {
                            x : 45,    // 图表在容器内的左边距
                            y : 30,    // 图表在容器内的上边距
                            x2 : 40,   // 图表在容器内的右边距
                            y2 : 23,   // 图表在容器内的下边距
                            backgroundColor : '#01172e',    // 图表背景色
                            borderWidth : 0      // 图表边框
                         },
                         xAxis : [
                             {
                                type : 'category',
                                data : [''],
                                show:false,
                                axisLabel : {
                                    textStyle : {
                                        color : '#999'
                                    }
                                },
                                 axisLine:{
                                        lineStyle:{
                                            color:'#6e7986',
                                            width:2,
                                            type:'solid'
                                        }
                                   },
                                splitLine : {   // 图表中的分割线
                                        show: false,  // 分割线的显示控制， true为显示， false为隐藏
                                        lineStyle : {
                                            color: '#ccc',   // 图表中的分割线 颜色
                                            width: 1,  
                                            type: 'solid'
                                        }
                                    }
                            }
                         ],
                         yAxis : [
                             {
                                 type : 'value',
                                 axisLabel : {
                                     textStyle : {
                                         color : '#999'
                                     }
                                 },
                                  axisLine:{
                                        lineStyle:{
                                            color:'#6e7986',
                                            width:2,
                                            type:'solid'
                                        }
                                   },
                                 splitLine : {   // 图表中的分割线
                                        show: true,  // 分割线的显示控制， true为显示， false为隐藏
                                        lineStyle : {
                                            color: '#26394d',   // 图表中的分割线 颜色
                                            width: 1,  
                                            type: 'solid'
                                        }
                                    }
                             }
                         ],
                         series : [
                             {
                                 name:'投资人',
                                 type:'bar',
                                 barCategoryGap: '50%',
                                 itemStyle: {
                                     normal: {
                                    	 label : {
                                             show: true, 
                                             position: 'top', 
                                             textStyle : {color : '#fff'}
                                         }
                                     }
                                 },
                                 data:[]
                             }
                         ]
                     };
                  //-----------------------------------------  
                    $.ajax({
                        type : 'POST',
                        url : "${path }/report/investor/investor_groupByTenant/data",
                        dataType : 'json',
                        success : function(data) {
                            if ( data.values.length > 0 ) {
                            	option_investor_all.xAxis[0].data = data.labels;   
                            	option_investor_all.series[0].data = data.values;
                            }
                            investor_all_chart.setOption(option_investor_all);
                        },
                        error : function(data) {
                        	investor_all_chart.setOption(option_investor_all);
                        }
                    });
                    //--------------------------    
                }
            );
            </script>
            <div class="top_no4">
                <h1>累计产品交易金额</h1>
                <h2><b>￥</b> ${trade_amount_all }<span> 万元</span></h2>
                <h3>客单价: <span>${pay_amount_all_avg }<b> 万元</b></span></h3>
                <h4>转化率: <span>${pay_all_rate}<b>%</b></span></h4>
            </div>
            <div class="top_no5">
                <img class="tutu" src="${path}/images/2.png" alt="">
            </div>
            <script type="text/javascript">
	            $(document).ready(
	                function(){
	                    $(".top_no5").mouseover(function(){
	                         $(".tutu").show();
	                    });
	                    $(".top_no5").mouseout(function(){
	                    	 $(".tutu").hide();
	                    });
	                    $(".tutu").click(function(){
	                    	 window.open("${path}/", "_self");
	                    });  
	                }
	            );
            </script>
        </div>
        <div class="box_middle">
        
                 <div class="middle_no1">
                 <h1 style="color:white;">累计Pad下发数和激活数 </h1>
                 <h2>pad下发数: <span>${sum_pad_all }</span> 台</h2>
                <h3>pad激活数: <span>${sum_pad_active }</span> 台</h3>
                <div id="pad_activation_report" style="width:400px;height:200px;padding:10px;"></div>
            </div>
               <script type="text/javascript">
              require.config({
                paths : {
                    echarts : '${path}/resources/echarts-2.2.1'
                }
              });
              require(
                [
                    'echarts',
                    'echarts/chart/bar'
                ],
                function (echarts){
                    var pad_activation_chart = echarts.init(document.getElementById('pad_activation_report'));              
                    pad_activation_report = {
                               legend: {
                                   textStyle : {
                                       color : '#999'
                                   },
                                    data:['pad下发数','pad激活数']
                                },
                                     tooltip : {
                                         trigger: 'axis',
                                         axisPointer : {            
                                             type : 'shadow' 
                                         }
                                     },
                                     
                                     grid : {
                                         x : 45,    // 图表在容器内的左边距
                                         y : 30,    // 图表在容器内的上边距
                                         x2 : 40,   // 图表在容器内的右边距
                                         y2 : 23,   // 图表在容器内的下边距
                                         backgroundColor : '#01172e',    // 图表背景色
                                         borderWidth : 0      // 图表边框
                                     },
                                     color:['#3f9ddd','#E37361'],
                                     calculable : false,
                                     xAxis : [
                                         {
                                             type : 'category',
                                             data : [''],
                                             show:false,
                                             axisLabel : {
                                                 textStyle : {
                                                     color : '#999'
                                                 }
                                             },
                                              axisLine:{
                                                     lineStyle:{
                                                         color:'#6e7986',
                                                         width:2,
                                                         type:'solid'
                                                     }
                                                },
                                             splitLine : {   // 图表中的分割线
                                                 show: false  // 分割线的显示控制， true为显示， false为隐藏
                                             }
                                         }
                                     ],
                            yAxis : [
                                {
                                    type : 'value',
                                    axisLabel : {
                                        formatter : '{value} 台',
                                        textStyle : {
                                            color : '#999'
                                        }
                                    },
                                }
                            ],
                            series : [
                                {
                                    name:'pad下发数',
                                    type:'bar',
                                    data:[]
                                },
                                {
                                    name:'pad激活数',
                                    type:'bar',
                                    data:[]
                                }
                            ]
                        };
                                            
                    //-----------------------------------------  
                    $.ajax({
                        type : 'POST',
                        url : "${path }/report/pad/pad_activation_chart/data",
                        dataType : 'json',
                        success : function(data) {
                            console.log(data);
                            if ( data.labelsTenant.length > 0 ) {
                                pad_activation_report.xAxis[0].data = data.labelsTenant;   
                                pad_activation_report.series[0].data = data.labelsSend;
                                pad_activation_report.series[1].data = data.labelsActivation;
                            }
                            pad_activation_chart.setOption(pad_activation_report);
                        },
                        error : function(data) {
                            pad_activation_chart.setOption(pad_activation_report);
                        }
                    });
                    //--------------------------
                }
            );

            </script>
        
            <div class="middle_no2">
                <h1>近30天理财产品发布</h1>
                <h2>新增产品: <span>${product_sum_new }</span> 款</h2>
                <h3>累计产品: <span>${product_sum_all }</span> 款</h3>
                <div id="report_product_category" style="width:400px;height:200px;padding:10px;"></div>
            </div>
            <script type="text/javascript">
            require.config({
                paths : {
                    echarts : '${path}/resources/echarts-2.2.1'
                }
            });
            require([ 
                     'echarts', 
                     'echarts/chart/pie' 
                 ], function(ec) {
                     var report_product_category = ec.init(document.getElementById('report_product_category'));
                     report_product_category.showLoading({
                         text: '正在努力的读取数据中...', 
                     });
                     var option_product_category = {
                           tooltip : {
                               trigger: 'item',
                               formatter: "{a} <br/>{b} : {c}款 ({d}%)"
                           },
                           legend: {
                               orient : 'vertical',
                               x : 'left',  // 图例名称左边距
                               y : 30,      // 图例名称上边距 
                               itemGap : 20,   // 图例名称之间的间距
                               data : [''],
                               textStyle : {
                            	   color: '#999'
                               }
                           },
                           color:['#fd8873','#37bfdf','#fecd5f', '#afdb9d', '#87b87f'],
                           calculable : false,
                           series : [
                               {
                                 name:'理财产品发布',
                                 type:'pie',
                                 radius : ['45%', '65%'],
                                 center: ['55%', '48%'],
                                 data:[ ]
                              }
                          ]
                     };
                     // send request data.
                     var showId = 30;
                     var configdata = {showId:showId};
                     $.ajax({
                         type : 'POST',
                         url : "${path }/report/product/publish_category/data",
                         contentType : 'application/json;charset=utf-8',
                         data: JSON.stringify(configdata),  
                         dataType : 'json',
                         success : function(data) {
                        	 if ( data.values.length > 0 ) {
	                             option_product_category.legend.data = data.labels;
	                             option_product_category.series[0].data = data.values;
	                             
	                             report_product_category.hideLoading();
                        	 }
                        	 report_product_category.setOption(option_product_category);
                        	 window.onresize = report_product_category.resize;
                         },
                         error : function(data) {
                             report_product_category.setOption(option_product_category);
                             //report_product_category.hideLoading();
                         }
                     });

            });

            </script>
            <div class="middle_no3">
                <h1>近30天理财产品交易</h1>
                <c:if test="${ product_trade_top2 eq '' }"><h2>TOP: <span></span></h2></c:if>
                ${product_trade_top2}
                <div id="product_trade_chart" style="width:400px;height:200px;padding:10px;"></div>
            </div>
            <script type="text/javascript">
            require.config({
                paths : {
                    echarts : '${path}/resources/echarts-2.2.1'
                }
            });
            require(
                [
                    'echarts',
                    'echarts/chart/pie'
                ],
                function (echarts){
                    var product_trade_chart = echarts.init(document.getElementById('product_trade_chart'));  
                    product_trade_chart.showLoading({
                        text: '正在努力的读取数据中...', 
                    });
		            option_product_trade = {
		           	    tooltip : {
		           	        trigger: 'item',
		           	        formatter: "{a} <br/>{b} : {c} ({d}%)"
		           	    },
		           	    legend: {
		           	        orient : 'vertical',
		           	        x : 'left',  // 图例名称左边距
                            y : 30,      // 图例名称上边距 
                            itemGap : 20,   // 图例名称之间的间距
		           	        data:[''],
			           	    textStyle : {
	                            color: '#999'
	                        }
		           	    },
		           	    color:['#fd8873','#37bfdf','#fecd5f', '#afdb9d', '#87b87f'],
		           	    calculable : false,
		           	    series : [
		           	        {
		           	            name:'理财产品交易',
		           	            type:'pie',
		           	            radius : '65%',
                                center: ['55%', '48%'],
		           	            data:[ ]
		           	        }
		           	    ]
		           	};
		            
		            // send request data.
                    var showId = 30;
                    var configdata = {showId:showId};
                    $.ajax({
                        type : 'POST',
                        url : "${path }/report/product/trade/data",
                        contentType : 'application/json;charset=utf-8',
                        data: JSON.stringify(configdata),  
                        dataType : 'json',
                        success : function(data) {
                        	if (data.values.length > 0 ) {
                        		option_product_trade.legend.data = data.labels;
                                option_product_trade.series[0].data = data.values;
                                
                                product_trade_chart.hideLoading();
                        	}
                            product_trade_chart.setOption(option_product_trade);
                            
                            window.onresize = product_trade_chart.resize;
                        },
                        error : function(data) {
                        	product_trade_chart.setOption(option_product_trade);
                            //product_trade_chart.hideLoading();
                        }
                    });
                });
            </script>
            <div class="middle_no4">
                <h1>近30天下单和支付</h1>
                <h2>订单: <span>${order_size }</span> 单</h2>
                <h3>支付: <span>${pay_size }</span> 单</h3>
                <h4>支付转化率: <span>${pay_rate }</span></h4>
                <div id="report_product_pay" style="width:400px;height:200px;padding:10px;"></div>
            </div>
            <script type="text/javascript">
	            require.config({
	                paths : {
	                    echarts : '${path}/resources/echarts-2.2.1'
	                }
	            });
	            require([ 
	                     'echarts', 
	                     'echarts/chart/pie' 
	                 ], function(ec) {
	                     var report_product_pay = ec.init(document.getElementById('report_product_pay'));
	                     report_product_pay.showLoading({
	                         text: '正在努力的读取数据中...', 
	                     });
	                     option__product_pay = {
                             tooltip : {
                                 trigger: 'item',
                                 formatter: "{a} <br/>{b} : {c}笔 ({d}%)"
                             },
                             legend: {
                                 orient : 'vertical',
                                 x : 'left',  // 图例名称左边距
                                 y : 20,      // 图例名称上边距 
                                 itemGap : 20,   // 图例名称之间的间距
                                 textStyle : {
                                    color: '#999'
                                 },
                                 data:['']
                             },
                             calculable : false,
                             color:['#34b3d2','#f77b66'],
                             series : [
                                 {
                                   name:'产品交易',
                                   type:'pie',
                                   radius : ['45%', '65%'],
                                   center: ['55%', '48%'],
                                   data:[ ]
                                }
                             ]
                         };
	                     // send request data.
	                     var showId = 30;
	                     var configdata = {showId:showId};
	                     $.ajax({
	                         type : 'POST',
	                         url : "${path }/report/product/pay/data",
	                         contentType : 'application/json;charset=utf-8',
	                         data: JSON.stringify(configdata),  
	                         dataType : 'json',
	                         success : function(data) {
	                        	 if (data.values.length > 0 && ( data.values[0].value > 0 || data.values[1].value > 0) ) {
		                             option__product_pay.legend.data = data.labels;
		                             option__product_pay.series[0].data = data.values;
		                             
		                             report_product_pay.hideLoading();
	                        	 }
	                             report_product_pay.setOption(option__product_pay);
	                             
	                             window.onresize = report_product_pay.resize;
	                         },
	                         error : function(data) {
	                             report_product_pay.setOption(option__product_pay);
	                             //report_product_pay.hideLoading();
	                         }
	                     });

	               });
            </script>
           
        </div>
        <div class="box_bottom">
         <div class="bottom_no1">
                <h1>近30天产品支付金额和客单价</h1>
                <h2>支付金额: <span>${pay_amount }</span> 万元</h2>
                <h3>客单价: <span>${pay_amount_avg }</span> 万元</h3>
                <div id="product_amount_chart" style="width:400px;height:200px;padding:10px;"></div>
            </div>
            <script type="text/javascript">
            require.config({
                paths : {
                    echarts : '${path}/resources/echarts-2.2.1'
                }
            });
            require([ 
                     'echarts', 
                     'echarts/chart/bar' 
                 ], function(ec) {
                     var product_amount_chart = ec.init(document.getElementById('product_amount_chart'));
                     
                     product_amount_option = {
                         tooltip : {
                             trigger: 'axis',
                             axisPointer : {            
                                 type : 'shadow'        
                             },
                             formatter: function (params) {
                                 var tar = params[0];
                                 return tar.name + '<br/>' + tar.seriesName + ' : ' + tar.value + " 万元";
                             }
                         },
                         color:['#fecd5f'],
                         grid : {
                             x : 80,    // 图表在容器内的左边距
                             y : 30,    // 图表在容器内的上边距
                             x2 : 40,   // 图表在容器内的右边距
                             y2 : 30,   // 图表在容器内的下边距
                             backgroundColor    : '#01172e',    // 图表背景色
                             borderWidth : 0      // 图表边框
                         },
                         xAxis : [
                             {
                                 type : 'category',
                                 data : [''],
                                 axisLabel : {
                                     textStyle : {
                                         color : '#999'
                                     }
                                 },
                                 axisLine:{
                                     lineStyle:{
                                         color:'#6e7986',
                                         width:2,
                                         type:'solid'
                                     }
                                  },
                                  splitLine : {   // 图表中的分割线
                                     show: false,
                                  }
                             }
                         ],
                         yAxis : [
                             {   
                                 type : 'value',
                                 axisLabel : {
                                     show : true,
                                     formatter : '{value} 万元',
                                     textStyle : {
                                         color : '#999'
                                     }
                                 },
                                 axisLine:{
                                      lineStyle:{
                                          color:'#6e7986',
                                          width:2,
                                          type:'solid'
                                      }
                                 },
                                 splitLine : {   // 图表中的分割线
                                     show: true,  // 分割线的显示控制， true为显示， false为隐藏
                                     lineStyle : {
                                         color: '#26394d',   // 图表中的分割线 颜色
                                         width: 1,  
                                         type: 'solid'
                                     }
                                 }
                             }
                         ],
                         series : [
                             {
                                 name:'辅助',
                                 type:'bar',
                                 stack: '总量',
                                 itemStyle:{
                                     normal:{
                                         barBorderColor:'rgba(0,0,0,0)',
                                         color:'rgba(0,0,0,0)'
                                     },
                                     emphasis:{
                                         barBorderColor:'rgba(0,0,0,0)',
                                         color:'rgba(0,0,0,0)'
                                     }
                                 },
                                 barCategoryGap: '50%',
                                 data:[]
                             },
                             {
                                 name:'金额',
                                 type:'bar',
                                 stack: '总量',
                                 itemStyle : { 
                                     normal: {
                                         label : {
                                             show: true, 
                                             position: 'top', 
                                             textStyle : {color : '#fff'}
                                         }
                                     }
                                 },
                                 barCategoryGap: '50%',
                                 data:[]
                             }
                         ]
                     };
                     
                     var showId = 30;
                     var configdata = {showId:showId};
                     $.ajax({
                         type : 'POST',
                         contentType : 'application/json;charset=utf-8',
                         url : "${path }/report/product/order_amount/data",
                         data : JSON.stringify(configdata),
                         dataType : 'json',
                         success : function(data) {
                             if (data.values.length > 0 && data.values[0] > 0) {
                                 product_amount_option.xAxis[0].data = data.labels;
                                 var x = data.values[0];
                                 var y = data.values[1];
                                 product_amount_option.series[0].data = [0, x - y];
                                 product_amount_option.series[1].data = data.values;
                             }
                             product_amount_chart.setOption(product_amount_option);
                         },
                         error : function(data) {
                             product_amount_chart.setOption(product_amount_option);
                         }
                     }); 
                 }
            );
            </script>
            <div class="bottom_no2">
                <h1>近30天活跃租户和理财师</h1>
                <h2>活跃理财师: <span>${cfp_active_size }</span> 人</h2>
                <h3>活跃租户: <span>${tenant_active_size }</span> 家</h3>
                <div id="active_finPlanner_tenant_chart" style="width:400px;height:200px;padding:10px;"></div>
            </div>
            <script type="text/javascript">
	            require.config({
	                paths : {
	                    echarts : '${path}/resources/echarts-2.2.1'
	                }
	            });
                require(
                    [
                        'echarts',
                        'echarts/chart/line'
                    ],
                    function (echarts){
                        var active_finPlanner_tenant_chart = echarts.init(document.getElementById('active_finPlanner_tenant_chart'));                                  
                        active_finPlanner_tenant_chart.showLoading({
                            text: '正在努力的读取数据中...', 
                        });
                        active_finPlanner_tenant_option = {
  
						    tooltip : {
						        trigger: 'axis'
						    },
						    legend: {
						        data:['活跃租户', '活跃理财师'],
						        y : 20,
						        textStyle : {
                                    color : '#999'
                                }
						    },
						    calculable : false,
						    grid : {
                                x : 45,    // 图表在容器内的左边距
                                y : 50,    // 图表在容器内的上边距
                                x2 : 40,   // 图表在容器内的右边距
                                y2 : 30,   // 图表在容器内的下边距
                                backgroundColor : '#01172e',    // 图表背景色
                                borderWidth : 0      // 图表边框
                            },
						    xAxis : [
						        {
						            type : 'category',
						            boundaryGap : false,
						            data : [''],
						            axisLabel : {
                                        textStyle : {
                                            color : '#999'
                                        }
                                    },
                                    axisLine:{
                                       lineStyle:{
                                           color:'#6e7986',
                                           width:2,
                                           type:'solid'
                                       }
                                    },
                                    splitLine : {   // 图表中的分割线
                                       show: false  // 分割线的显示控制， true为显示， false为隐藏
                                    }
						        }
						    ],
						
						    yAxis : [
						        {
						        	type : 'value',
                                    axisLabel : {
                                        formatter: '{value}',
                                        textStyle : {
                                            color : '#999'
                                        }
                                    },
                                    axisLine:{
                                        lineStyle:{
                                            color:'#6e7986',
                                            width:2,
                                            type:'solid'
                                        }
                                    },
                                    splitLine : {   // 图表中的分割线
                                         show: true,  // 分割线的显示控制， true为显示， false为隐藏
                                         lineStyle : {
                                            color: '#26394d',   // 图表中的分割线 颜色
                                            width: 1,  
                                            type: 'solid'
                                         }
                                     }
						        }
						    ],
						    series : [
						        {
						            name:'活跃租户',
						            type:'line',
						            smooth: true,
						            data:[ ]
						        },
						        {
						            name:'活跃理财师',
						            type:'line',
						            smooth: true,
						            data:[ ]
						        }
						    ]
						};                                  
                        //-----------------------替换你需的option【End】--------------------------------
                        var showId = 30;
                        var configdata = {showId:showId};
                        $.ajax({
                            type : 'POST',
                            contentType : 'application/json;charset=utf-8',
                            url : "${path }/report/cfp/active_finPlanner_tenant/data",
                            data : JSON.stringify(configdata),
                            dataType : 'json',
                            success : function(data) {
                                if ( data.values.length > 0 ){
                                   active_finPlanner_tenant_option.xAxis[0].data = data.labels;  
                                   active_finPlanner_tenant_option.series[0].data = data.values[0];
                                   active_finPlanner_tenant_option.series[1].data = data.values[1];
                                   
                                   active_finPlanner_tenant_chart.hideLoading();
                                }
                                active_finPlanner_tenant_chart.setOption(active_finPlanner_tenant_option);
                            },
                            error : function(data) {
                            	active_finPlanner_tenant_chart.setOption(active_finPlanner_tenant_option);
                            	//active_finPlanner_tenant_chart.hideLoading();
                            }
                        });   
                        
                    }
                );
            </script>
            <div class="bottom_no3">
                <h1>近30天Pad使用时长</h1>
                <h2>主要时长: <span>${max_duration_range }</span></h2>
                <div id="pad_duration_report" style="width:400px;height:200px;padding:10px;"></div>
            </div>
            <script type="text/javascript">
            require.config({
                paths : {
                    echarts : '${path}/resources/echarts-2.2.1'
                }
            });
            require([ 
                  'echarts',
                  'echarts/chart/bar' 
              ], function(ec) {
                  var pad_duration_report = ec.init(document.getElementById('pad_duration_report'));
                  pad_duration_report.showLoading({
                      text: '正在努力的读取数据中...'
                  });
                  pad_duration_option = {
                          tooltip : {
                              trigger : 'axis',
                              axisPointer : {            
                                  type : 'shadow' 
                              },
                              formatter: '{c}台 <br/> {a}: {b} '
                          },
                          calculable : false,
                          color:['#2ec7c9'],
                          grid : {
                              x : 45,    // 图表在容器内的左边距
                              y : 50,    // 图表在容器内的上边距
                              x2 : 40,   // 图表在容器内的右边距
                              y2 : 30,   // 图表在容器内的下边距
                              backgroundColor   : '#01172e',    // 图表背景色
                              borderWidth : 0      // 图表边框
                          },
                          xAxis : [ {
                              type : 'category',
                              data : [ '' ],
                              axisLabel : {
                                  textStyle : {
                                      color : '#999'
                                  }
                              },
                              axisLine:{
                                  lineStyle:{
                                      color:'#6e7986',
                                      width:2,
                                      type:'solid'
                                  }
                               },
		                       splitLine : {   // 图表中的分割线
		                          show: false
		                       },
                          } ],
                          yAxis : [ {
                        	  type : 'value',
                              axisLabel : {
                                  formatter : '{value} 台',
                                  textStyle : {
                                      color : '#999'
                                  }
                              },
                              axisLine:{
                                    lineStyle:{
                                        color:'#6e7986',
                                        width:2,
                                        type:'solid'
                                    }
                               },
                               splitLine : {   // 图表中的分割线
                                   show: true,  // 分割线的显示控制， true为显示， false为隐藏
                                   lineStyle : {
                                        color: '#26394d',   // 图表中的分割线 颜色
                                        width: 1,  
                                        type: 'solid'
                                    }
                                }
                          } ],
                          series : [ {
                              name : 'Pad使用时长',
                              smooth: true,
                              type : 'bar',
                              barCategoryGap: '35%',
                              data : [ ]
                          } ]
                  };
                  // send request data.
                  var showId = 30;
                  var configdata = {showId:showId};
                  $.ajax({
                      type : 'POST',
                      contentType : 'application/json;charset=utf-8',
                      url : "${path }/report/pad/duration/data",
                      data : JSON.stringify(configdata),  
                      dataType : 'json',
                      success : function(data) {
                          if ( data.values.length > 0 ){
                             pad_duration_option.xAxis[0].data = data.labels;
                             var list_0 = data.values;
                             var size = list_0.length;
                             var list_1 = [];
                             var temp = 0;
                             for (var i = 0; i < size; i++){
                                 temp = Number(list_0[i]);
                                 list_1.push(temp);
                             }
                             pad_duration_option.series[0].data = list_1;
                             pad_duration_option.series[0].markPoint = {data : [ {type : 'max', name : '最大值' } ] };
                             
                             pad_duration_report.hideLoading();
                          }
                          pad_duration_report.setOption(pad_duration_option);
                          window.onresize = pad_duration_report.resize;
                      },
                      error : function(data) {
                          pad_duration_report.setOption(pad_duration_option);
                          //pad_duration_report.hideLoading();
                      }
                  });
              });
            </script>
            <div class="bottom_no4">
                <h1>近30天Pad使用频次</h1>
                <h2>主要使用频次: <span>${max_frequency_range }</span> 次/天</h2>
                <div id="pad_frequency_report" style="width:400px;height:200px;padding:10px;"></div>
            </div>
            <script type="text/javascript">
            require.config({
                paths : {
                    echarts : '${path}/resources/echarts-2.2.1'
                }
            });
            require([ 
                   'echarts', 
                   'echarts/chart/bar' 
               ], function(ec) {
                   var pad_frequency_report = ec.init(document.getElementById('pad_frequency_report'));
                   pad_frequency_report.showLoading({
                       text: '正在努力的读取数据中...', 
                   });
                   pad_frequency_option = {
                           tooltip : {
                               trigger : 'axis',
                               axisPointer : {            
                                   type : 'shadow' 
                               },
                               formatter: '{c}台 <br/> {a}: {b} '
                           },
                           color:['#71b4fe'],
                           calculable : false,
                           grid : {
                               x : 45,    // 图表在容器内的左边距
                               y : 50,    // 图表在容器内的上边距
                               x2 : 40,   // 图表在容器内的右边距
                               y2 : 30,   // 图表在容器内的下边距
                               backgroundColor  : '#01172e',    // 图表背景色
                               borderWidth : 0   ,   // 图表边框
                           },
                           xAxis : [ 
                              {
	                               type : 'category',
	                               data : [ '没有数据' ],
	                               axisLabel : {
	                                   textStyle : {
	                                       color : '#999'
	                                   }
	                               },
	                               axisLine:{
	                                   lineStyle:{
	                                       color:'#6e7986',
	                                       width:2,
	                                       type:'solid'
	                                   }
	                              },
	                              splitLine : {   // 图表中的分割线
	                            	   show: false
	                              }
                             } 
                           ],
                           yAxis : [ {
                        	   type : 'value',
                               axisLabel : {
                                   formatter : '{value} 台',
                                   textStyle : {
                                       color : '#999'
                                   }
                               },
                               axisLine:{
                                    lineStyle:{
                                        color:'#6e7986',
                                        width:2,
                                        type:'solid'
                                    }
                               },
                               splitLine : {   // 图表中的分割线
                                   show: true,  // 分割线的显示控制， true为显示， false为隐藏
                                   lineStyle : {
                                       color: '#26394d',   // 图表中的分割线 颜色
                                       width: 1,  
                                       type: 'solid'
                                   }
                                  
                               }
                           } ],
                           series : [ {
                               name : 'Pad使用频次',
                               smooth: true,
                               type : 'bar',
                               barCategoryGap: '35%',
                               data : [ ]
                           } ]
                   };
                   // send request data.
                   var showId = 30;
                   var configdata = {showId:showId};
                   $.ajax({
                       type : 'POST',
                       contentType : 'application/json;charset=utf-8',
                       url : "${path }/report/pad/frequency/data",
                       data : JSON.stringify(configdata),
                       dataType : 'json',
                       success : function(data) {
                    	   if ( data.values.length > 0 ){
                               pad_frequency_option.xAxis[0].data = data.labels;   
                               var list_0 = data.values;
                               var size = list_0.length;
                               var list_1 = [];
                               var temp = 0;
                               for (var i = 0; i < size; i++){
                                   temp = Number(list_0[i]);
                                   list_1.push(temp);
                               }
                               pad_frequency_option.series[0].data = list_1;
                               pad_frequency_option.series[0].markPoint = {data : [ {type : 'max', name : '最大值' } ] };
                               
                               pad_frequency_report.hideLoading();
                           }
                           pad_frequency_report.setOption(pad_frequency_option);
                           window.onresize = pad_frequency_report.resize;
                       },
                       error : function(data) {
                           pad_frequency_report.setOption(pad_frequency_option);
                           //pad_frequency_report.hideLoading();
                       }
                   });
               });
            </script>
        </div>
    </div>
</body>
</html>