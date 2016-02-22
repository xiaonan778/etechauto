$(function() {
	var tenant_fk = $("#tenantId").val();
    var prefix = "trade_order_pay_";
    customPlugin.loadchartModel(prefix + "chart", prefix, 500);
    var selector =$("#" + prefix + "showtime").children('option:selected').val();
    $("#" + prefix + "showtime").select({
        change: function (value, label) {
            var showId = $(this).children('option:selected').val();
            if(showId!=0) selector = $(this).children('option:selected').val();
            if (showId && showId == 0) {
                $("#" + prefix + "anytime").click();
            } else if (showId > 0) {
                // 更改select 更新chart
                showChart(showId);
            }

        },width:200
    });
    
//    $("#" + prefix + "showtime").change(function() {
//        var showId = $(this).children('option:selected').val();
//        if (showId && showId == 0) {
//            $("#" + prefix + "anytime").click();
//        } else if (showId > 0) {
//            // 更改select 更新chart
//            showChart(showId);
//        }
//
//    });
    var validateObj = customPlugin.getValidObj(prefix);
    // 自选时间段渲染chart
    $("#" + prefix + "btnConfirm").click(function() {
                        var validator = $("#" + prefix + "datepicker_form")
                                .validate(validateObj);
                        var start ="",end="";
                        if (validator.form()) {
                            start =$("#"+prefix+"startTime").val();
                            end =$("#"+prefix+"endTime").val();
                            var startDate = new Date((start).replace(/-/g, "/"));
                            var endDate = new Date((end).replace(/-/g, "/"));
                            if (startDate > endDate) {
                                alert("开始时间必须小于结束时间!");
                                return false;
                            }
                            // 自选时间段渲染chart
                            $("#" + prefix + "modelCancel").click();
                            showChart(0);
                            $("#"+prefix+"option0").attr("selected",true);
                        }
                        ;
                    });

    $("#" + prefix + "btnCancel").click(function() {
        $("#" + prefix + "modelCancel").click();
        cancelModel();
    });
    
    function cancelModel(){

      	if($(this).find("a").attr("data-dk-dropdown-value")==selector) {
      	        $("#dk_container_"+prefix+"showtime").find('.dk_option_current').removeClass('dk_option_current');
      	        $(this).addClass('dk_option_current');
      	       $("#dk_container_"+prefix+"showtime .dk_label").html( $("#dk_container_"+prefix+"showtime").find('.dk_option_current a').html());
      	       return false;
      	}
      
    	
    }
    $("#" + prefix + "modelCancel").click(function(){ 
    	cancelModel();
    });
    $("#" + prefix + "option0").click(function() {
        $("#" + prefix + "anytime").click();
    });
    require.config({
        paths : {
            echarts : _path + '/resources/echarts-2.2.1'
        }
    });
    showChart(30);
    function showChart(showId){
    	require(
                [ "echarts", "echarts/themes/macarons", "echarts/chart/line" ],
                function(ec, theme) {
                    var report = ec.init(
                            document.getElementById(prefix + 'report'), theme);
                    var titleText = "",subText="",start="",end="";
                    if (showId > 0) {
                        titleText = '近' + showId + '天产品下单及支付分布图';
                        var now = new Date();
                    	now.setTime( now.getTime()-24*3600*1000);
                        var end = customPlugin.getDateString(now);
                        now.setTime(now.getTime() - (showId-1) * 24 * 3600 * 1000);
                        var start = customPlugin.getDateString(now);
                        var subText = start + "至" + end;

                    } else {
                        start =$("#"+prefix+"startTime").val();
                        end =$("#"+prefix+"endTime").val();
                        titleText = start + "至" + end + "产品下单及支付分布图";
                    }
                    var configdata = {
                        start : start,
                        end : end,
                        tenant_fk:tenant_fk
                    };
                    report.showLoading({
                        text : '正在努力的读取数据中...',
                    });

                   

                    // send request data.
                    $.ajax({
                                type : 'POST',
                                contentType : 'application/json;charset=utf-8',
                                url : _path+ "/report/tenant/trade_order_pay_chart/data",
                                data : JSON.stringify(configdata),
                                dataType : 'json',
                                success : function(data) {
                                    var dateLabels = data.dateLabels;
                                    var totalOrder = data.totalOrder;
                                    var payOrder = data.payOrder;
                                    var payAmount = data.payAmount;
                                    	  var option = {
                                    			  title : {
                                                      text : titleText,
                                                      subtext:subText,
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
                                    			    legend: {
                                    			    	 x : 80,
                                                         y : 35,
                                    			        data:['支付单数','下单数量']
                                    			    },
                                    			    calculable : true,
                                    			    xAxis : [
                                    			        {
                                    			            type : 'category',
                                    			            boundaryGap : false,
                                    			            data : dateLabels
                                    			        }
                                    			    ],
                                    			    yAxis : [
                                    			        {
                                    			            type : 'value',
                                    			            axisLabel : {
                                    			                formatter: '{value} 单'
                                    			            }
                                    			        }
                                    			    ],
                                    			    series : [
                                    			        {
                                    			            name:'支付单数',
                                    			            type:'line',
                                    			            data:payOrder,
                                    			            markPoint : {
                                    			                data : [
                                    			                    {type : 'max', name: '最大值'},
                                    			                    {type : 'min', name: '最小值'}
                                    			                ]
                                    			            },
                                    			            markLine : {
                                    			                data : [
                                    			                    {type : 'average', name: '平均值'}
                                    			                ]
                                    			            }
                                    			        },
                                    			        {
                                    			            name:'下单数量',
                                    			            type:'line',
                                    			            data:totalOrder,
                                    			            markPoint : {
                                    			                data : [
                                    			                    {type : 'max', name: '最大值'},
                                    			                    {type : 'min', name: '最小值'}
                                    			                ]
                                    			            },
                                    			            markLine : {
                                    			                data : [
                                    			                    {type : 'average', name : '平均值'}
                                    			                ]
                                    			            }
                                    			        }
                                    			    ]
                                    			};

                                          report.setOption(option);
                                          report.hideLoading();
                                          if(window.addEventListener){
                                        	  window.addEventListener("resize", function () {
                                         		 report.resize();
                                              });
                                          } else {
                                        	  window.attachEvent('resize', function () {
                                         		 report.resize();
                                              });
                                          }
                                         
                                          var indexMax = customPlugin.max(totalOrder);
                                          var indexMin = customPlugin.min(totalOrder);
                                          var payAmountSum = 0;
                                          for(var i = 0; i<payAmount.length; i++) {
                                        	  payAmountSum +=payAmount[i];
                                          }
                                          payAmountSum /=10000;
                                          var totalOrderSum = 0;
                                          for(var j = 0; j<totalOrder.length; j++) {
                                        	  totalOrderSum +=totalOrder[j];
                                          }
                                          delete j;
                                          var payOrderSum = 0;
                                          for(var k = 0; k<payOrder.length; k++) {
                                        	  payOrderSum +=payOrder[k];
                                          }
                                          delete k;
                                          var htmlStr=
                                              "<div><p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>";
                                          	  if(showId>0) {
                                                	htmlStr +=  "<span>近"+showId+"天内</span>";
                                                } else {
                                                	htmlStr +=  "<span>"+start+"至"+end+"内</span>";
                                                }
                                          	   if(totalOrderSum>0) {
                                          		 htmlStr += "<span>共产生</span>";
                                                 htmlStr += "<span class=\"sum-important\">"+totalOrderSum+"</span><span>笔下单，有</span><span class=\"sum-important\">"+payOrderSum+"</span>"+
                                                  "<span>笔完成支付，累计交易金额为</span><span class=\"sum-important\">"+payAmountSum.toFixed(1)+"万元</span>，支付转化率为"+
                                                  "<span class=\"sum-important\">"+(parseInt(payOrderSum)/parseInt(totalOrderSum)*100).toFixed(2)+"</span>%；</p>";
                                                 htmlStr += "<p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>";
                                                 if(showId>0) {
                                                 	htmlStr +=  "<span>近"+showId+"天内</span>";
                                                 } else {
                                                 	htmlStr +=  "<span>"+start+"至"+end+"内</span>";
                                                 }
                                                 htmlStr +=  "<span>下单最高值为</span><span class=\"sum-important\">"+customPlugin.dateTransform(dateLabels[indexMax])+"</span><span>，为</span><span class=\"sum-important\">"+totalOrder[indexMax]+"</span>"+
                                                  "<span>笔，最低值为</span><span class=\"sum-important\">"+customPlugin.dateTransform(dateLabels[indexMin])+"</span>，<span>为</span>"+
                                                  "<span class=\"sum-important\">"+payOrder[indexMin]+"</span>笔。";
                                          	   } else {
                                          		   htmlStr += "暂无数据";
                                          	   }
                                              
                                            htmlStr += "</p></div>";
                                            $("#" + prefix + "conclusion").html(htmlStr);
                                },
                                error : function(data) {
                                    report.hideLoading();
                                }
                            });
                });
    }

});
