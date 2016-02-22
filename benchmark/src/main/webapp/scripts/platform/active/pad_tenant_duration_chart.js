$(function() {

    var prefix = "pad_tenant_duration_";
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

        },
	       width:200
    });
    
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
                        titleText = '近' + showId + '天Pad使用时长租户分布图';
                        var now = new Date();
                    	now.setTime( now.getTime()-24*3600*1000);
                        var end = customPlugin.getDateString(now);
                        now.setTime(now.getTime() - (showId-1) * 24 * 3600 * 1000);
                        var start = customPlugin.getDateString(now);
                        var subText = start + "至" + end;

                    } else {
                        start =$("#"+prefix+"startTime").val();
                        end =$("#"+prefix+"endTime").val();
                        titleText = start + "至" + end + "Pad使用时长租户分布图";
                    }
                    var configdata = {
                        start : start,
                        end : end
                    };
                    report.showLoading({
                        text : '正在努力的读取数据中...',
                    });

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
                                y : 55,
           			        data:[]
           			    },
            			    calculable : true,
            			    xAxis : [
            			        {
            			            type : 'category',
            			            boundaryGap : false,
            			            data : []
            			        }
            			    ],
            			    yAxis : [
            			        {
            			            type : 'value',
            			            axisLabel : {
            			                formatter: '{value} 分钟'
            			            }
            			        }
            			    ],
            			    series : []
            			};
            			   

                    // send request data.
                    $.ajax({
                                type : 'POST',
                                contentType : 'application/json;charset=utf-8',
                                url : _path+ "/report/pad/pad_tenant_duration_chart/data",
                                data : JSON.stringify(configdata),
                                dataType : 'json',
                                success : function(data) {
                                    var dateLabels = data.dateLabels;
                                    var allTotal = data.allTotal;
                                    var labelsTenant = data.labelsTenant;
                                    option.legend.data = labelsTenant;
                                    option.xAxis[0].data = dateLabels;
                                    var series = [];
                                    for(var i = 0 ; i< allTotal.length; i++) {
                                    	 var jsonStr = '{\"name\":\"'+labelsTenant[i]+'\",\"type\":\"line\",\"data\":['+allTotal[i]+'],\"markPoint\" : { \"data\" : [{\"type\" : \"max\", \"name\": \"最大值\"},{\"type\" : \"min\", \"name\": \"最小值\"}'+
                                                  ']}, \"markLine\" : { \"data\" : [{\"type\" : \"average\",\"name\": \"平均值\"}]}}';
                                    	 series.push(JSON.parse(jsonStr));
                                    }
                                      option.series=series;
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
                                     var sum =[];  
                                     var totalSum = 0;
                                     for(i = 0;i<allTotal.length;i++) {
                                    	 var tenantSum = 0;
                                    	 var oneTotal = allTotal[i];
                                    	 for(var j =0 ; j<oneTotal.length; j++) {
                                    		 tenantSum +=  parseInt(oneTotal[j]);
                                    		 totalSum += parseInt(oneTotal[j]);
                                    	 }
                                    	 sum.push(tenantSum);
                                     }
                                     var averageDuration =  (allTotal.length>0?(totalSum /allTotal.length/showId):0).toFixed(0);
                                     var indexMax = customPlugin.max(sum);
                                     var indexMin = customPlugin.max(sum);
                                          var htmlStr=
                                              "<div>"+
                                              "<p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>";
                                          if(showId>0) {
                                          	htmlStr +=  "<span>近"+showId+"天内</span>";
                                          } else {
                                          	htmlStr +=  "<span>"+start+"至"+end+"内</span>";
                                          }
                                             // htmlStr += "<span>租户平均使用时间为</span><span class=\"sum-important\">"+averageDuration+"</span><span>分钟；</span>";
                                          	  if(labelsTenant && labelsTenant.length>0) {
                                          		  htmlStr += "<span>租户平均使用时间为</span><span class=\"sum-important\">"+averageDuration+"</span><span>分钟；</span>";
                                          		  htmlStr +=  "<p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>";
                                          		  if(showId>0) {
                                                  	htmlStr +=  "<span>近"+showId+"天内</span>";
                                                  } else {
                                                  	htmlStr +=  "<span>"+start+"至"+end+"内</span>";
                                                  }
                                          		 htmlStr += "<span class=\"sum-important\">"+labelsTenant[indexMax]+"</span><span>租户的整体使用时长较多，而</span><span class=\"sum-important\">"+labelsTenant[indexMin]+"</span>"+
                                                 "<span>租户整体使用时长较短。</span>";
                                          	  }else{
                                          		htmlStr = "<div><p>";
                                          	  }
                                            htmlStr += "</p></div>";
                                            $("#" + prefix + "conclusion").html(htmlStr);
                                            $("#"+prefix+"title").html("");
                                            if(labelsTenant && labelsTenant.length==0 && sum ==0) {
                                            	report.showLoading({
                                            	    text : '暂无数据',
                                            	    effect : 'bubble',
                                            	    textStyle : {
                                            	        fontSize : 30
                                            	    }
                                            	});
                                            	$("#"+prefix+"title").html("<div style='margin-bottom:10px;text-align:center;min-width:100%;color:#259BD4;font-family :Helvetica Neue,Helvetica,Arial,sans-serif;font-size : 25px;font-weight : bold'>"+titleText+"</div>"
                                            			+"<div style='margin-bottom:10px;text-align:center;min-width:100%;color:#ccc;font-size : 13px;font-weight : bold'>"+subText+"</div>"		
                                            	);
                                            }
                                },
                                error : function(data) {
                                    report.hideLoading();
                                }
                            });
                });
    }

});
