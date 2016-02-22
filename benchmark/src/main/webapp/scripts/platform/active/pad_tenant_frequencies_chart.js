$(function() {

    var prefix = "pad_tenant_frequencies_";
    
    var htmlStr = 
    	  '<div class="form-group" style="margin-top:20px;margin-left:80%;">'+
	      '<div class="input-group date form_date " data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input1">'+
          ' <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>'+
            '  <input class="form-control" size="16" type="text" value="" id="dateEffect" name="dateEffect" placeholder="today" readonly>'+
        '  </div>'+
			'<input type="hidden" id="dtp_input1" value="" /><br/>'+
 ' </div>'+
 "<div id='"+prefix+"title'></div>"+
       '<div id="'+prefix+'report" style="width:100%;height:500px;"></div>';
    
    $("#"+prefix+"chart").html(htmlStr);
    $('.form_date').datetimepicker({
    	language : 'zh-CN',
		format : 'yyyy-mm-dd',
		autoclose : true,
		todayBtn : true,
		todayHighlight : 1,
		startView : 2,
		minView : 2
    });
    $("#dateEffect").change(function(){
    	var day = $(this).val();
    	showChart(day);
    });

    var now = new Date();
    now.setTime( now.getTime()-24*3600*1000);
    var today = customPlugin.getDateString(now);
    $("#dateEffect").val(today);
    showChart(today);
    
    // 自选时间段渲染chart

    require.config({
        paths : {
            echarts : _path + '/resources/echarts-2.2.1'
        }
    });
    function showChart(someday){
    	require(
                [ "echarts", "echarts/themes/macarons", "echarts/chart/bar" ],
                function(ec, theme) {
                    var report = ec.init(
                            document.getElementById(prefix + 'report'), theme);

                    var titleText = someday+"租户Pad使用频次分布图";
                    var configdata = {
                        day : someday
                    };
                    report.showLoading({
                        text : '正在努力的读取数据中...',
                    });
                    
                   var option = {
                    	    title : {
                    	        text: "租户Pad使用频次分布图",
                    	        x : 'center',
                                textStyle : {
                                    color : '#259BD4',
                                    fontFamily : "Helvetica Neue,Helvetica,Arial,sans-serif",
                                    fontSize : 25,
                                    fontWeight : 'bolder',
                                }
                    	    },
                    	    tooltip : {
                    	        trigger: 'axis'
                    	    },
                    	    legend: {
                    	        data:['平均登录频次(每天)'],
                    	        x : 80,
                                y : 55
                    	    },
                    	    grid : {
                                y : 100
                            },
                    	    calculable : true,
                    	    xAxis : [
                    	        {
                    	            type : 'category',
                    	            data : []
                    	        }
                    	    ],
                    	    yAxis : [
                    	        {
                    	            type : 'value',
                    	            axisLabel : {
                                        formatter: '{value} 次'
                                    }
                    	        }
                    	    ],
                    	    series : [
                    	        {
                    	            name:'平均登录频次(每天)',
                    	            type:'bar',
                    	            data:[],
                    	            itemStyle: {
    	                                normal: {
    		                                label: {
    			                            show: true,
    			                            position: 'top',
    			                            formatter: '{c} '
    		                                }
    	                                 }
    	                            },
                    	            markLine : {
                    	                data : [
                    	                    {type : 'average', name : '平均值'}
                    	                ]
                    	            }
                    	        }
                    	    ]
                    	};
                    	          

                   

                    // send request data.
                    $.ajax({
                                type : 'POST',
                                contentType : 'application/json;charset=utf-8',
                                url : _path+ "/report/pad/cfp_tenant_frequencies_chart/data",
                                data : JSON.stringify(configdata),
                                dataType : 'json',
                                success : function(data) {
                                	var labelsTenant = data.labelsTenant;
                                	var	labelsFrequency = data.labelsFrequency;
                                	
                                	if(labelsTenant && labelsTenant.length>0) {
                                		option.series[0].data = labelsFrequency;
                                    	option.xAxis[0].data = labelsTenant;
                                        report.setOption(option);
                                        report.hideLoading();

                                        var maxIndex = customPlugin.max(labelsFrequency);
                                        var  minIndex = customPlugin.min(labelsFrequency);
                                 	   var htmlStr=
                        	                "<div><p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>"+
                        	                "<span class=\"sum-important\">"+labelsTenant[maxIndex]+"</span><span>在当日</span><span>平均使用频次较高；</span>"+
                        	                "<p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>"+
                        	                "<span class=\"sum-important\">"+labelsTenant[minIndex]+"</span><span>在当日</span><span>平均使用频次较低；</span>"+
                        	                "</p></div>";
                                 	  $("#"+prefix+"title").html("");
                                 	  $("#"+prefix+"sum").html(htmlStr);
                                	}else {
                                		report.showLoading({
                                    	    text : '暂无数据',
                                    	    effect : 'bubble',
                                    	    textStyle : {
                                    	        fontSize : 30
                                    	    }
                                    	});
                                		$("#"+prefix+"title").html("<div style='margin-top:-30px;margin-bottom:20px;text-align:center;min-width:100%;color:#259BD4;font-family :Helvetica Neue,Helvetica,Arial,sans-serif;font-size : 25px;font-weight : bold'>租户Pad使用频次分布图</div>"
                                        	);
//                                	 	var htmlStr= "<div><p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>"+
//                                    	"<span class=\"sum-important\">暂无数据</span></p></div>";
//                                         $("#"+prefix+"sum").html(htmlStr);
                                	}
                                	
                                    if(window.addEventListener){
                                  	  window.addEventListener("resize", function () {
                                   		 report.resize();
                                        });
                                    } else {
                                  	  window.attachEvent('resize', function () {
                                   		 report.resize();
                                        });
                                    }
                                	
                                },
                                error : function(data) {
                                    report.hideLoading();
                                }
                            });
                });
    }

});
