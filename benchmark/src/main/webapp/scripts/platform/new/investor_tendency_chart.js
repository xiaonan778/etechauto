$(function() {

    var prefix = "investor_tendency_";
    customPlugin.loadchartModel(prefix + "chart", prefix, 500);

//    $("#" + prefix + "showtime").change(function() {
//        var showId = $(this).children('option:selected').val();
//        if (showId && showId == 0) {
//            $("#" + prefix + "anytime").click();
//        } else if (showId > 0) {
//            var now = new Date();
//            now.setTime(now.getTime() - (showId-1) * 24 * 3600 * 1000);
//            // 更改select 更新chart
//            showChart(showId);
//        }
//
//    });
    var selector =$("#" + prefix + "showtime").children('option:selected').val();
    $("#" + prefix + "showtime").select({
        change: function (value, label) {
            var showId = $(this).children('option:selected').val();
            if(showId!=0) selector = $(this).children('option:selected').val();
            if (showId && showId == 0) {
                $("#" + prefix + "anytime").click();
            } else if (showId > 0) {
                var now = new Date();
                now.setTime(now.getTime() - (showId-1) * 24 * 3600 * 1000);
                // 更改select 更新chart
                showChart(showId);
            }

        },
	       width:200
    });
    
    var validateObj = customPlugin.getValidObj(prefix);
    // 自选时间段渲染chart
    $("#" + prefix + "btnConfirm").click(function() {
        var validator = $("#" + prefix + "datepicker_form").validate(validateObj);
        var start ="",end="";
        if (validator.form()) {
            start =$("#"+prefix+"startTime").val();
            end =$("#"+prefix+"endTime").val();
            var startDate = new Date((start).replace(/-/g, "/"));
            var endDate = new Date((end).replace(/-/g, "/"));
            if (startDate >endDate) {
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
        [ "echarts", "echarts/themes/macarons", "echarts/chart/radar" ],
        function(ec, theme) {
            var report = ec.init(
                    document.getElementById(prefix + 'report'), theme);

            var titleText = "",subText="",start="",end="";
            if (showId > 0) {
                titleText = '近' + showId + '天投资人交易产品偏好分布图';
                var now = new Date();
            	now.setTime( now.getTime() - 24*3600*1000);
                end = customPlugin.getDateString(now);
                now.setTime(now.getTime() - (showId-1) * 24 * 3600 * 1000);
                start = customPlugin.getDateString(now);
                subText = start + "至" + end;

            } else {
                start = $("#"+prefix+"startTime").val(),
                end = $("#"+prefix+"endTime").val();
                titleText = start + "至" + end + "天投资人交易产品偏好分布图";
            }
            var tenant_fk = null;
            if ($("#tenantId").val() != null) {
            	tenant_fk = $("#tenantId").val();
            }
            var configdata = {
                showId : showId,
                start : start,
                end : end,
                tenant_fk : tenant_fk
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
                tooltip : {
                    trigger : 'axis'
                },
                legend : {
                    data : [ '成交单数', '成交金额' ],
                    x : 80,
                    y : 35
                },
                calculable : true,
                polar : [],
                series : []
            };
            // send request data.
            $.ajax({
                type : 'POST',
                contentType : 'application/json;charset=utf-8',
                url : _path+ "/report/investor/investor_tendency_product/data",
                data : JSON.stringify(configdata),
                dataType : 'json',
                success : function(data) {
                    var effectiveAmountSum = data.effectiveAmountSum;
                    var effectiveOrderSum = data.effectiveOrderSum;
                    var labels = data.labels;
                    var payAmountSum = data.payAmountSum;
                    var payOrderSum = data.payOrderSum;
                    if(labels&&labels.length==0){
                    	report.showLoading({
                    	    text : '暂无数据',
                    	    effect : 'bubble',
                    	    textStyle : {
                    	        fontSize : 30
                    	    }
                    	});
                    	$("#"+prefix+"title").html("<div style='text-align:center;min-width:100%;color:#259BD4;font-family :Helvetica Neue,Helvetica,Arial,sans-serif;font-size : 25px;font-weight : bold'>"+titleText+"</div>"
                    	    +"<div style='margin-bottom:10px;text-align:center;min-width:100%;color:#ccc;font-size : 12px;font-weight : bold'>"+subText+"</div>"		
                    	);
                    }else{
                    	$("#"+prefix+"title").html("");
                        var indexTop1Amount = customPlugin.max(effectiveAmountSum);
                        var indexTop1Order = customPlugin.max(effectiveOrderSum);
                        var indexTop1PayOrder = customPlugin.max(payOrderSum);
                        var indexTop1PayAmount = customPlugin.max(payAmountSum);
                        var maxIgnore =[parseInt(effectiveAmountSum[indexTop1Amount]),parseInt(effectiveOrderSum[indexTop1Order]),
                                		parseInt(payOrderSum[indexTop1PayOrder]),parseInt(payAmountSum[indexTop1PayAmount])];
                        var maxIndex = customPlugin.max(maxIgnore);
                        var indicatorText ='  {"indicator" : [ ';
                        for(var i = 0; i<labels.length;i++) {
                            indicatorText+='{"text":"'+labels[i]+'","max":'+maxIgnore[maxIndex]+'},';
                        }
                        indicatorText=indicatorText.substring(0, indicatorText.length-1);
                        indicatorText+='],"radius" : 130} ';
                        var seriesText=' {"name" : "成交单数和金额具体数据","type" : "radar",'+
                            '"itemStyle" : { "normal" : {"areaStyle" : { "type" : "default"}}},'+
                            '"data" : [ {"value" : ['+effectiveOrderSum+'],"name" : "成交单数"}, {'+
                            '"value" : ['+effectiveAmountSum+'], "name" : "成交金额"} ] } ';
                        option.polar.push(JSON.parse(indicatorText));
                        option.series.push(JSON.parse(seriesText));
                        report.setOption(option);
                        report.hideLoading();
                        
                        //  结论
                        var htmlStr = "<div><p><img class=\"sum-head\" src=\""
                            + _path
                            + "/resources/images/sum_head.png\"><span class=\"sum-space\"></span>";
                        if(!effectiveOrderSum[indexTop1Order]&& !effectiveAmountSum[indexTop1Amount]
                            && !effectiveOrderSum[indexTop1PayOrder] && !effectiveOrderSum[indexTop1PayAmount]) {
	                                            htmlStr += "<span>投资人交易产品成交单数和成交金额都为0</span>";
                        } else if(indexTop1Order != indexTop1Amount) {
                            htmlStr += "<span class=\"sum-important\">"
                            + labels[indexTop1Amount]
                            + "</span><span>和</span>"
                            + "<span class=\"sum-important\">"
                            + labels[indexTop1Order]
                            + "</span><span>产品比较受投资人的欢迎；</span>";
                            htmlStr += "</p><p><img class=\"sum-head\" src=\""
                                + _path
                                + "/resources/images/sum_head.png\"><span class=\"sum-space\"></span>";
                            if(indexTop1PayOrder != indexTop1PayAmount) {
                                htmlStr +=  "<span class=\"sum-important\">"
                                + labels[indexTop1PayAmount]
                                + "</span><span>产品投资总额较高,</span>"
                                + "<span class=\"sum-important\">"
                                + labels[indexTop1PayOrder]
                                + "</span><span>产品投资笔数较多；</span>";
                            } else {
                                htmlStr += "<span class=\"sum-important\">"
                                + labels[indexTop1PayAmount]
                                + "</span><span>产品投资总额较高和产品投资笔数都较高；</span>";
                            }
                        } else {
                             htmlStr += "<span class=\"sum-important\">"
                             + labels[indexTop1Amount]
                             + "</span><span>产品比较受投资人的欢迎；</span>";
                             htmlStr += "</p><p><img class=\"sum-head\" src=\""
                                 + _path
                                 + "/resources/images/sum_head.png\"><span class=\"sum-space\"></span>";
                             if((indexTop1PayOrder != indexTop1PayAmount)&&(!labels[indexTop1PayAmount])) {
                                 htmlStr +=  "<span class=\"sum-important\">"
                                 + labels[indexTop1PayAmount]
                                 + "</span><span>产品投资总额较高,</span>"
                                 + "<span class=\"sum-important\">"
                                 + labels[indexTop1PayOrder]
                                 + "</span><span>产品投资笔数较多。</span>";
                             } else if(!!labels[indexTop1PayAmount]){
                                 htmlStr += "<span class=\"sum-important\">"
                                 + labels[indexTop1PayAmount]
                                 + "</span><span>产品投资总额和产品投资笔数都较高。</span>";
                             }
                        }
                        htmlStr += "</p></div>";
                        $("#" + prefix + "sum").html(htmlStr);
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
        });
    }
});
