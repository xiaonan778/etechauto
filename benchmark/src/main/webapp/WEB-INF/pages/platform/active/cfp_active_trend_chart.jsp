<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="BW" uri="http://benchmark.com/tags"%>
<!DOCTYPE HTML>
<html>
  <head>
    <jsp:include page="../../common/meta.jsp" />
    <title>平台运营数据</title>
    <link rel="stylesheet" type="text/css" href="${path}/css/report/chart.css">
    <script src="${path }/resources/reveal/jquery.reveal.js" ></script>
    <script src='${path}/scripts/common/reportDate.js' type='text/javascript'></script>
  </head>
  
  <body>
  
	<BW:datePicker flag="${showId }" items="${dicList}" prefix="cfp_active" show="false" />
	
    <div id="cfp_active_report" style="width: 100%;height: 480px;"></div>
    <script>
	    $(function(){
	        jQuery().reportDate({
	            id : "cfp_active",
	            chartURL : _path + "/report/cfp/active/chart",
	            show : true
	        });
	    });
    
    	require.config({
			paths : {
				echarts : '${path}/resources/echarts-2.2.1'
			}
		});
		// ------------------------------------------------------------------------------------------------------------------------------------------
		$().ready(function() {
			
			require([ 
				'echarts', 
				'echarts/themes/macarons',
				'echarts/chart/line' 
			], function(ec, theme) {
				var cfp_active_report = ec.init(document.getElementById('cfp_active_report'), theme);
				var titleText = "";
				if(${showId}>0){
					titleText = '近${showId}天活跃理财师数量趋势图';
				}else{ 
					titleText = "${start}至${end} 活跃理财师数量趋势图";
				}
				var showId = ${showId};
                var tenant_fk = "${tenant_fk}" == "" ? null : "${tenant_fk}";
                var start = "${start}" == "" ? null : "${start}";
                var end = "${end}" == "" ? null : "${end}";
                var configdata = {showId:showId,start:start,end:end,tenant_fk:tenant_fk};
				var serie=[];
				var legen=["Pad下发数","活跃理财师数"];
				cfp_active_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
				// send request data.
				$.ajax({
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					url : "${path }/report/cfp/cfp_active_chart/data",
					data : JSON.stringify(configdata),  
					dataType : 'json',
					success : function(data) {
						cfp_active_tent_option.xAxis[0].data = data.labels;
						cfp_active_tent_option.legend.data = legen;
						for ( var int = 0; int < data.values.length; int++) {
							var list_0 = data.values[int];
							var size = list_0.length;
							var list_1 = [];
							var tempvalue = 0;
							for (var i = 0; i < size; i++){
								tempvalue = Number(list_0[i]);
								list_1.push(tempvalue);
							}
							var item={
						            name:legen[int],
						            smooth:true,
						            type:'line',
						            data:list_1,
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
						     };
						   serie.push(item);
						}
						cfp_active_report.setOption(cfp_active_tent_option);
						cfp_active_report.hideLoading();
						
						if(window.addEventListener){
                            window.addEventListener("resize", function () {
                            	cfp_active_report.resize();
                            });
                        } else {
                           window.attachEvent("resize", function () {
                        	   cfp_active_report.resize();
                           });
                        }
						
						try {
                            if ($("#position").val() == "summary") {
                                var image = "<img class=\"sum-head\" src=\"${path }/resources/images/sum_head.png\"/><span class=\"sum-space\"></span>";
                                var subitem = "<div>" + "<p>" + image + "至昨天，活跃理财师累计为<span class=\"sum-important\">" + data.cfp_active_size_all + "</span>位，"
                                        + data.datatime + "新增活跃理财师<span class=\"sum-important\">" + data.cfp_acitve_size_days + "</span>位，"
                                        + "占总量的<span class=\"sum-important\">"+ data.increasement_rate + "</span>；</p>"
                                        + "<p>" + image + data.datatime + "内活跃理财师最高值日期是<span class=\"sum-important\">" + data.maxDate + "</span>"
                                        + "，为<span class=\"sum-important\">" + data.maxValue + "</span>位，"
                                        + "最低值日期是<span class=\"sum-important\">" + data.minDate + "</span>"
                                        + "，为<span class=\"sum-important\">" + data.minValue + "</span>位。</p></div>";
                                
                                $("#cfp_active_subitem").html(subitem);
                            }
                        }catch(e){}
					},
					error : function(data) {
						cfp_active_report.setOption(cfp_active_tent_option);
						cfp_active_report.hideLoading();
					}
				});
				cfp_active_tent_option = {
				    title : {
				        text: titleText,
				        subtext: "${subtext}",
				        x : 'center',
				        textStyle : {
                            color : '#259BD4',
                            fontFamily : "Helvetica Neue,Helvetica,Arial,sans-serif",
                            fontSize : 25,
                            fontWeight : 'bolder'
                        }
				    },
				    grid : {
                        y : 120
                    },
				    tooltip : {
				        trigger: 'axis',
				        formatter : function(params, ticket, callback){
                            var tooltip = "";
                            for (var i = 0; i < params.length; i++) {
                                var data = params[i];
                                if (i == 0) {
                                    tooltip = data.name + "<br/>";
                                }
                                var seriesIndex = data.seriesIndex;
                                if (seriesIndex == 0) {
                                    tooltip = tooltip + data.seriesName + "：" + data.value + "台<br/>";
                                } else {
                                    tooltip = tooltip + data.seriesName + "：" + data.value + "位<br/>";
                                }
                            }
                            return "<div>" + tooltip + "</div>";
                        },
				    },
				    legend: {
				        data:[],
				        x : 80,
				        y : 65
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
				            type : 'value'
				        }
				    ],
				    series:serie
				};
			});

		});
	</script>
  
  </body>

</html>
