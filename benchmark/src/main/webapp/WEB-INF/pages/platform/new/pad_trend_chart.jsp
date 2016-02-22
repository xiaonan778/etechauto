<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://benchmark.com/tags" prefix="BW" %>
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
    
    <BW:datePicker flag="${showId }" items="${ dicList}" prefix="pad_trend" show="false" />
    
    <div id="pad_trend_report" style="width: 100%;height: 480px;"></div>
    <script type="text/javascript">
	    $(function(){
	        jQuery().reportDate({
	            id : "pad_trend",
	            chartURL : _path + "/report/pad/trend/chart",
	            subitemURL : _path + "/report/pad/trend/subitem",
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
  					'echarts/themes/green',
  					'echarts/chart/line' 
  				], function(ec, theme) {
  					var pad_trend_report = ec.init(document.getElementById('pad_trend_report'), theme);
  					var titleText = '';
  					if(${showId}>0){
  					   titleText = '近${showId}天Pad激活量变化趋势图';
				    }else{ 
				       titleText = "${start}至${end} Pad激活量变化趋势图";
				    }
  					pad_trend_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
  					pad_trend_option = {
                            title : {
                                text : titleText,
                                subtext : "${subtext}",
                                x: 'center',
                                itemGap: 10,
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
                                trigger : 'axis'
                            },
                            //legend : {
                            //    data : [ '新增激活Pad' ]
                            //},
                            calculable : true,
                            xAxis : [ {
                                type : 'category',
                                boundaryGap : false,
                                data : [ '没有数据' ]
                            } ],
                            yAxis : [ {
                                type : 'value',
                                axisLabel : {
                                    formatter : '{value} 台'
                                }
                            } ],
                            series : [ {
                                name : '新增激活Pad',
                                smooth:true,
                                type : 'line',
                                data : [],
                                markPoint : {
                                    data : [ 
                                       {type : 'max', name : '最大值' }, 
                                       {type : 'min', name : '最小值' } 
                                    ]
                                },
                                markLine : {
                                    data : [
                                        {type : 'average', name: '平均值'}
                                    ]
                                }
                            } ]
                    };
	                var showId = ${showId};
	                var tenant_fk = "${tenant_fk}" == "" ? null : "${tenant_fk}";
	                var start = "${start}" == "" ? null : "${start}";
	                var end = "${end}" == "" ? null : "${end}";
					var configdata = {showId:showId,start:start,end:end,tenant_fk:tenant_fk};
  					// send request data.
  					$.ajax({
  						type : 'POST',
  						contentType : 'application/json;charset=utf-8',
  						url : "${path }/report/pad/trend/data",
  						data : JSON.stringify(configdata), 
  						dataType : 'json',
  						success : function(data) {
  							if (data.labels.length > 0) {
  								pad_trend_option.xAxis[0].data = data.labels;
  							}
    						
    						var list_0 = data.values;
    						var size = list_0.length;
    						var list_1 = [];
    						var temp = 0;
    						for (var i = 0; i < size; i++){
    							temp = Number(list_0[i]);
    							list_1.push(temp);
    						}
    						pad_trend_option.series[0].data = list_1;
    						pad_trend_report.setOption(pad_trend_option);
    						pad_trend_report.hideLoading();
    						
    						if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	pad_trend_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   pad_trend_report.resize();
                               });
                            }
    						
    						try {
                                if ($("#position").val() == "summary") {
                                    var image = "<img class=\"sum-head\" src=\"${path }/resources/images/sum_head.png\"/><span class=\"sum-space\"></span>";
                                    var subitem = "<div>" + "<p>" + image + "至昨天，Pad累计下发<span class=\"sum-important\">" + data.sum_pad_all + "</span>"
                                           + "台，还有<span class=\"sum-important\">" + data.sum_pad_not_active + "</span>"
                                           + "台未激活，激活率为<span class=\"sum-important\">" + data.pad_active_rate + "</span>；</p>"
                                           + "<p>" + image + "Pad总激活数为<span class=\"sum-important\">" + data.sum_pad_active + "</span>"
                                           + "台，"+ data.datatime +"内新增激活<span class=\"sum-important\">" + data.sum_pad_30new + "</span>"
                                           + "台，占总量的<span class=\"sum-important\">" + data.pad_new_rate + "</span>；</p>"
                                           + "<p>" + image + data.datatime + "内Pad激活最高值日期是<span class=\"sum-important\">" + data.maxDate + "</span>"
                                           + "，为<span class=\"sum-important\">" + data.maxValue + "</span>台，"
                                           + "最低值日期是<span class=\"sum-important\">" + data.minDate + "</span>"
                                           + "，为<span class=\"sum-important\">" + data.minValue + "</span>台。</p></div>";
                                    $("#pad_trend_subitem").html(subitem);
                                }
                            }catch(e){}					
  						},
  						error : function(data) {
  							pad_trend_report.setOption(pad_trend_option);
  							pad_trend_report.hideLoading();
  						}
  					});
				});

			});
		</script>
  
  </body>

</html>
