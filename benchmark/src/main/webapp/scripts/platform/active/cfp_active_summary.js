$(function(){
  
    var prefix = "cfp_active_tenant_";
   $("#"+prefix+"chart").append("<div id='"+prefix+"report' class='report' style=' width:100%;height:480px;'></div>");
     require.config({
         paths : {
            echarts : _path+'/resources/echarts-2.2.1'
         }
     });
     require([ 
        "echarts", 
        "echarts/themes/macarons",
        "echarts/chart/bar" 
    ], function(ec, theme) {
        var report = ec.init(document.getElementById(prefix+'report'), theme);
            report.showLoading({
                  text: '正在努力的读取数据中...', 
              });
        	var now = new Date();
        	now.setTime( now.getTime()-24*3600*1000);
            var end = customPlugin.getDateString(now);
            now.setTime(now.getTime() - 29 * 24 * 3600 * 1000);
            var start = customPlugin.getDateString(now);
            var subText = start + "至" + end;
            var option = {
                    title : {
                         text: '近30天活跃理财师租户数量分布图',
                         subtext:subText,
                         x : 'center',
                         textStyle : {
                             color : '#259BD4',
                             fontFamily : "Helvetica Neue,Helvetica,Arial,sans-serif",
                             fontSize : 25,
                             fontWeight : 'bolder'
                         },
                    },
                    grid : {
                        y : 100
                    },
                    tooltip : {
                        trigger: 'axis'
                    },
                    legend: {
                        data:['租户活跃理财师','租户下发pad数'],
                        x : 80,
                        y : 55
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
                            boundaryGap : [0, 0.01],
                            axisLabel : {
                                formatter: '{value} 位'
                            }
                        }
                    ],
                    series : [
                        {
                            name:'租户活跃理财师',
                            type:'bar',
                            data:[], itemStyle: {
    	                        normal: {
    		                        label: {
    		                           show: true,
    		                           position: 'top',
    		                           formatter: '{c} 位'
    		                          }
    	                         }
    	                     },
                            markPoint : {
                                data : [
                                ]
                            },
                            markLine : {
                                data : [
                                    {type : 'average', name: '平均值'}
                                ]
                            }
                        },
                        {
                            name:'租户下发pad数',
                            type:'bar',
                            data:[],
                            markPoint : {
                                 data : [
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
        // send request data.
        $.ajax({
            type : 'POST',
            contentType : 'application/json;charset=utf-8',
            url : _path+"/report/cfp/cfp_active_tenant_chart/data",
            //data : JSON.stringify(configdata),  
            data : JSON.stringify({start:null,end:null,orderBy:1}),
            dataType : 'json',
            success : function(data) {
                var cfpActiveSize = data.cfpActiveSize;
                var allActiveCfps = data.allActiveCfps;
                var padSize = data.padSize;
                var labels = data.labels;
                for(var i =0; i<labels.length;i++) {
                			labels[i]=labels[i].replace(/(.{6})/g,'$1\n')
                }
                if(labels && labels[0]&&labels.length>0) {
                	option.xAxis[0].data=labels;
                    option.series[0].data = cfpActiveSize;
                    option.series[1].data = padSize;
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
                    var top1label='暂无',top1Value=0;
                    if(labels.length>0) top1label=labels[0];
                    if(cfpActiveSize.length>0) top1Value=cfpActiveSize[0];
                    var percentTop1 = (parseInt(top1Value)/parseInt(allActiveCfps)*100).toFixed(2);
                    isNaN(percentTop1)?percentTop1=0:percentTop1;
                    var arr = [];
                    for(var i = 0; i<cfpActiveSize.length; i++){
                        if(i==0)continue;
                        if(i==5) break;
                        var nums = (parseInt(cfpActiveSize[i])/parseInt(allActiveCfps)*100).toFixed(2);
                        arr.push((isNaN(nums)?0:nums)+"%");
                    }
                    if(arr.length==0)arr.push('0%');
                    var htmlStr=
                        "<div><p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>"+
                        "<span>近30天内</span><span class=\"sum-important\">"+top1label+"</span><span>的理财师比较活跃，有</span><span class=\"sum-important\">"+top1Value+"</span>"+
                        "<span>位活跃理财师，占活跃理财师总量的</span><span class=\"sum-important\">"+percentTop1+"%</span>；"+
                        "<p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>"+
                        "<span>其余前</span><span class=\"sum-important\">"+(labels.length<4?labels.length-1:4)+"</span>家租户活跃理财师分别占到活跃理财师总量的<span class=\"sum-important\">"+arr.toString()+"</span>；";
                    $("#active_tenant_chart_sum").html(htmlStr);
                    $("#"+prefix+"title").html("");
                }else {
                	report.showLoading({
                	    text : '暂无数据',
                	    effect : 'bubble',
                	    textStyle : {
                	        fontSize : 30
                	    }
                	});
                	$("#"+prefix+"title").html("<div style='text-align:center;min-width:100%;color:#259BD4;font-family :Helvetica Neue,Helvetica,Arial,sans-serif;font-size : 25px;font-weight : bold'>近30天活跃理财师租户数量分布图</div>"
                			 +"<div style='margin-bottom:10px;text-align:center;min-width:100%;color:#ccc;font-size : 13px;font-weight : bold'>"+subText+"</div>"
                	);
//                	 $("#active_tenant_chart_sum").html("<div><p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span><span>暂无数据</span></p></div>"
//                			 
//                	 );
                }
                
              
                
            },
            error : function(data) {
                report.setOption(option);
                report.hideLoading();
            }
        });
        
    });
     
});
