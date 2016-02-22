$(function(){

	var prefix = "cfp_tenant_deal_";
	customPlugin.loadchartModel(prefix + "chart", prefix, 500);
	$("#"+prefix+"timeForm").hide();
	//$("#"+prefix+"chart").html("<div id='"+prefix+"report' class=\"report\" style=\" width:100%;height:480px;\"></div>");
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
            now.setTime(now.getTime() - 29* 24 * 3600 * 1000);
            var start = customPlugin.getDateString(now);
            var subText = start + "至" + end;
              
    var option = {
            title : {
                text: '近30天租户理财师成交情况分布图',
                subtext:subText,
                x : 'center',
		        textStyle : {
                    color : '#259BD4',
                    fontFamily : "Helvetica Neue,Helvetica,Arial,sans-serif",
                    fontSize : 25,
                    fontWeight : 'bolder'
                }
            },
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['成交理财师', '未成交理财师'],
                x : 80,
		        y : 35
            },
            calculable : false,
            xAxis : [
                {
                    type : 'value',
                    boundaryGap : [0, 0.01]
                }
            ],
            yAxis : [
                {
                    type : 'category',
                    data : []
                }
            ],
            series : [
                {
                    name:'成交理财师',
                    type:'bar',
                    itemStyle: {
                        normal: {
	                        label: {
	                           show: true,
	                           position: 'right',
	                           formatter: '{c} 位'
	                          }
                         }
                     },
                    data:[]
                },
                {
                    name:'未成交理财师',
                    type:'bar',
                    itemStyle: {
                        normal: {
	                        label: {
	                           show: true,
	                           position: 'right',
	                           formatter: '{c} 位'
	                          }
                         }
                     },
                    data:[]
                }
            ]
        };
        // send request data.
        $.ajax({
            type : 'POST',
            contentType : 'application/json;charset=utf-8',
            url : _path+"/report/cfp/finPlanner_tenant_deal/data",
            data : JSON.stringify({start:0,end:5,orderBy:0}),
            dataType : 'json',
            success : function(data) {
                var totalCfps = data.totalCfps;
                var totalDealDoneCpfs = data.totalDealDoneCpfs;
                var cfps_done = data.cfps_done;
                var cfps_undo = data.cfps_undo;
                var labels = data.labels;
                for(var i =0; i<labels.length;i++) {
                			labels[i]=labels[i].replace(/(.{4})/g,'$1\n')
                }
                var top5cfps = data.top5cfps;
                if(labels&&labels.length>1) {
                    option.yAxis[0].data=labels;
                    option.series[0].data = cfps_done;
                    option.series[1].data = cfps_undo;
                    report.setOption(option);
                    report.hideLoading();
                    if(totalCfps>0) {
                        labels.splice(labels.length-1,1);
                        var cfpsDonePercent = Math.round(parseInt(totalDealDoneCpfs)/parseInt(totalCfps)*10000)/10000;
                        var htmlStr=
        	                "<div><p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>"+
        	                "<span>在租户理财师中，已完成成交的理财师占总理财师数的</span><span class=\"sum-important\">"+(cfpsDonePercent*100).toFixed(2)+"%</span>，为"+
        	                "<span class=\"sum-important\">"+totalDealDoneCpfs+"</span>位，<span>未成交的理财师数占总理财师数的</span>"+
        	                "<span class=\"sum-important\">"+((1-cfpsDonePercent)*100).toFixed(2)+"%</span>，为"+
        	                "<span class=\"sum-important\">"+(totalCfps-totalDealDoneCpfs)+"</span>位<span>；</span>"+
        	                "<p><img class=\"sum-head\" src=\""+_path+"/resources/images/sum_head.png\"><span class=\"sum-space\"></span>"+
        	                "<span>理财师成交数Top</span><span class=\"sum-important\">"+(labels.length<5?labels.length:5)+"</span>的租户"+(labels.length>1?"依次":"")+"是：<span class=\"sum-important\">"+labels.toString()+"</span>，"+
        	                "<span>该</span><span class=\"sum-important\">"+(labels.length<5?labels.length:5)+"</span>家成交理财师数为<span class=\"sum-important\">"+top5cfps+"</span><span>位，占总理财师的</span><span class=\"sum-important\">"+(parseInt(top5cfps)/parseInt(totalCfps)*100).toFixed(2)+"%。</span></p></div>";
                           $("#"+prefix+"sum").html(htmlStr);
                    }
                    $("#"+prefix+"title").html("");
                } else {
                	report.showLoading({
                	    text : '暂无数据',
                	    effect : 'bubble',
                	    textStyle : {
                	        fontSize : 30
                	    }
                	});
                
                	$("#"+prefix+"title").html("<div style='text-align:center;min-width:100%;color:#259BD4;font-family :Helvetica Neue,Helvetica,Arial,sans-serif;font-size : 25px;font-weight : bold'>近30天租户理财师成交情况分布图</div>"
                	    +"<div style='margin-bottom:10px;text-align:center;min-width:100%;color:#ccc;font-size : 13px;font-weight : bold'>"+subText+"</div>"
                	);
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
                report.setOption(option);
                report.hideLoading();
            }
        });
        
        //var url1 = _path + "/report/cfp/cfp_active_sum_subitem";
        //$('#'+prefix+'sum').load(url1, configdata);
       
    });
     
});
