$(function() {

    var prefix = "pad_tenant_frequency_";
    customPlugin.loadchartModel(prefix + "chart", prefix, 500);

    $("#" + prefix + "showtime").change(function() {
        var showId = $(this).children('option:selected').val();
        if (showId && showId == 0) {
            $("#" + prefix + "anytime").click();
        } else if (showId > 0) {
            var now = new Date();
            var end = customPlugin.getDateString(now);
            now.setTime(now.getTime() - (showId-1) * 24 * 3600 * 1000);
            var start = customPlugin.getDateString(now);
            // 更改select 更新chart
            showChart(showId);
        }

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
                            if (startDate >= endDate) {
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
        $("#"+prefix+"option-1").attr("selected",true);
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
                [ "echarts", "echarts/themes/macarons", "echarts/chart/bar" ],
                function(ec, theme) {
                    var report = ec.init(
                            document.getElementById(prefix + 'report'), theme);

                    var titleText = "",subText="",start="",end="";
                    if (showId > 0) {
                        titleText = '近' + showId + '天租户Pad使用频次分布图';
                        var now = new Date();
                    	now.setTime( now.getTime()-24*3600*1000);
                        var end = customPlugin.getDateString(now);
                        now.setTime(now.getTime() - 29 * 24 * 3600 * 1000);
                        var start = customPlugin.getDateString(now);
                        var subText = start + "至" + end;

                    } else {
                        var start =$("#"+prefix+"startTime").val(),
                        end =$("#"+prefix+"endTime").val();
                        titleText = start + "至" + end + "天租户Pad使用频次分布图";
                    }
                    var configdata = {
                        start : start,
                        end : end
                    };
                    report.showLoading({
                        text : '正在努力的读取数据中...',
                    });

                   

                    // send request data.
                    $.ajax({
                                type : 'POST',
                                contentType : 'application/json;charset=utf-8',
                                url : _path+ "/report/pad/cfp_tenant_frequency_chart/data",
                                data : JSON.stringify(configdata),
                                dataType : 'json',
                                success : function(data) {
                                    var labelsTenant = data.labelsTenant;
                                    var labelsFrequency = data.labelsFrequency;
                                    var total = data.total;
                                    var arr = new Array();
                                    for(var k=0;k<labelsFrequency.length;k++) {
                                    	var array = new Array();
                                    	if(total&&total.length>0) {
                                    		for(var i=0;i<total.length;i++) {
                                    			array.push(total[i][k]);
                                    		}
                                    	}
                                    	arr.push(array);
                                    }
                                    
                                    if(labelsTenant&&labelsTenant.length){
                                    	  var option = {
                                                  title : {
                                                      text : titleText,
                                                      subtext:subText,
                                                      x : 'center',
                                                      textStyle : {
                                                          color : '#259BD4',
                                                          fontFamily : "Helvetica Neue,Helvetica,Arial,sans-serif",
                                                          fontSize : 25,
                                                          fontWeight : 'bolder',
                                                      }
                                                   },
                                                   grid : {
                                                       y : 100
                                                   },
                                                   tooltip: {
                                                       trigger: 'axis',
                                                       backgroundColor: 'rgba(255,255,255,0.7)',
                                                       axisPointer: {
                                                           type: 'shadow'
                                                       },
                                                       formatter: function(params) {
                                                           var res = '<div style="color:white;background:rgba(0,0,0,0.5);border-radius:5px;padding:5px;">';
                                                           res += '<strong>' + params[0].name + ':pad登录数</strong>'
                                                           for (var i = 0, l = params.length; i < l; i++) {
                                                               res += '<br/>' + params[i].seriesName + ' : ' + params[i].value 
                                                           }
                                                           res += '</div>';
                                                           return res;
                                                       }
                                                   },
                                                   legend: {
                                                  	 x : 80,
                                                       y : 55,
                                                       data:labelsFrequency
                                                   },

                                                   calculable: true,
                                                   grid: {
                                                       y: 80,
                                                       y2: 40,
                                                       x2: 40
                                                   },
                                                   xAxis: [
                                                       {
                                                           type: 'category',
                                                           data: labelsTenant
                                                       }
                                                   ],
                                                   yAxis: [
                                                       {
                                                           type: 'value',
                                                           axisLabel : {
                                                               formatter: '{value} 台'
                                                           }
                                                       }
                                                   ],
                                                   series: []
                                               };
                                    	  
                                    	  var seriesStr = "[";
                                    	  for(var i = 0; i< labelsFrequency.length; i++) {
                                    		  seriesStr +="{\"name\":\""+labelsFrequency[i]+"\",\"type\":\"bar\",\"data\":["+arr[i]+"]},";
                                    	  }
                                    	  seriesStr=seriesStr.substring(0,seriesStr.length-1);
                                    	  seriesStr +="]";
                                    	  seriesJSON = JSON.parse(seriesStr);
                                    	  option.series=seriesJSON;

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
                                          /**
                                          var htmlStr=
                                              "<div><p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>";
                                          	  if(showId>0) {
                                                	htmlStr +=  "<span>近"+showId+"天内</span>";
                                                } else {
                                                	htmlStr +=  "<span>"+start+"至"+end+"内</span>";
                                                }
                                               
                                               htmlStr += "<span class=\"sum-important\">"+labelsTenant[indexMax]+"</span><span>在</span><span class=\"sum-important\">"+labelsFrequency[indexMax][0]+"</span>"+
                                                "<span>区间登录频次最高；登录次数为：</span><span class=\"sum-important\">"+maxFrequency[indexMax]+"</span>；</p>"+
                                                "<p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>"+
                                                "<span class=\"sum-important\">"+labelsTenant[indexMin]+"</span><span>在</span><span class=\"sum-important\">"+labelsFrequency[indexMin][1]+"</span>"+
                                                "<span>区间登录频次最低；登录次数为：</span><span class=\"sum-important\">"+maxFrequency[indexMin]+"</span>。";
                                            
                                            htmlStr += "</p></div>";
                                            $("#" + prefix + "sum").html(htmlStr);*/
                                    } else {
                                    	var noDataTip = "<div class='noData-container' ><div class='noData-title'>";
                                    	noDataTip = noDataTip + titleText + "</div><div class='noData-subtitle'>"+subText+"</div><div class='noData-tips' >没有数据</div></div>";
                                    	$("#" + prefix + "report").html(noDataTip);
                                    }
                                },
                                error : function(data) {
                                    report.hideLoading();
                                }
                            });
                });
    }

});
