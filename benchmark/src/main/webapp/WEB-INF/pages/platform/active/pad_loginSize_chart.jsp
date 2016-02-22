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
     
    <BW:datePicker flag="${showId }" items="${dicList }" prefix="pad_loginSize" show="false"/>
    
    <div id="pad_loginSize_report" style="width: 100%;height: 480px;"></div>
    
    <script type="text/javascript">
		    $(function(){
		        jQuery().reportDate({
		            id : "pad_loginSize",
		            chartURL : _path + "/report/pad/loginSize/chart",
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
  					'echarts/themes/shine',
  					'echarts/chart/line' 
  				], function(ec, theme) {
  					var pad_loginSize_report = ec.init(document.getElementById('pad_loginSize_report'), theme);
  					pad_loginSize_report.showLoading({
  					    text: '正在努力的读取数据中...', 
  					});
  					var titleText = "";
                    if(${showId} > 0) {
                        titleText = '近${showId}天Pad登录数趋势图';
                    }else{ 
                        titleText = '${start} 至 ${end} Pad登录数趋势图';
                    }
  					pad_loginSize_option = {
                            title : {
                                text : titleText,
                                subtext : "${subtext}",
                                itemGap : 10,
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
                                trigger : 'axis',
                                formatter : function(params, ticket, callback){
                                    var tooltip = "";
                                    for (var i = 0; i < params.length; i++) {
                                        var data = params[i];
                                        if (i == 0) {
                                            tooltip = data.name + "<br/>";
                                        }
                                        var seriesIndex = data.seriesIndex;
                                        if (seriesIndex == 0) {
                                            tooltip = tooltip + data.seriesName + "：" + data.value + "次<br/>";
                                        } else if (seriesIndex == 1) {
                                            tooltip = tooltip + data.seriesName + "：" + data.value + "位<br/>";
                                        } else if (seriesIndex == 2){
                                        	tooltip = tooltip + data.seriesName + "：" + data.value + "台<br/>";
                                        }
                                    }
                                    return "<div>" + tooltip + "</div>";
                                }
                            },
                            legend : {
                                data : [ 'Pad登录数', '活跃理财师', 'Pad下发数' ],
                                x : 80,
                                y : 65
                            },
                            calculable : true,
                            xAxis : [ {
                                type : 'category',
                                boundaryGap : false,
                                data : [ '没有数据' ]
                            } ],
                            yAxis : [ {
                                type : 'value',
                                axisLabel : {
                                    formatter : '{value}'
                                }
                            } ],
                            series : serie
                    };
  					// send request data.
  					var showId = ${showId};
  					var tenant_fk = "${tenant_fk}" == "" ? null : "${tenant_fk}";
                    var start = "${start}";
                    var end = "${end}";
                    var configdata = {showId:showId,start:start,end:end,tenant_fk:tenant_fk};
                    var serie = [];
                    var legen = [ "Pad登录数", "活跃理财师", "Pad下发数" ];
                    pad_loginSize_option.legend.data = legen;
  					$.ajax({
  						type : 'POST',
  						contentType : 'application/json;charset=utf-8',
  						data : JSON.stringify(configdata),  
  						url : "${path }/report/pad/loginSize/data",
  						dataType : 'json',
  						success : function(data) {
  							if (data.labels.length > 0) {
  								pad_loginSize_option.xAxis[0].data = data.labels;
  							}
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
  	                                    name: legen[int],
  	                                    smooth: true,
  	                                    type: 'line',
  	                                    data: list_1,
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
  							pad_loginSize_option.series = serie;
    						pad_loginSize_report.setOption(pad_loginSize_option);
    						pad_loginSize_report.hideLoading();
    						
    						if(window.addEventListener){
                                window.addEventListener("resize", function () {
                                	pad_loginSize_report.resize();
                                });
                            } else {
                               window.attachEvent("resize", function () {
                            	   pad_loginSize_report.resize();
                               });
                            }
    						
    						try {
                                if ($("#position").val() == "summary") {
                                    var image = "<img class=\"sum-head\" src=\"${path }/resources/images/sum_head.png\"/><span class=\"sum-space\"></span>";
                                    var subitem = "<div>"
                                           + "<p>" + image + "pad登录总数为<span class=\"sum-important\">" + data.pad_login_size_all + "</span>"
                                           + "次，"+ data.datatime +"登录<span class=\"sum-important\">" + data.pad_login_size_days + "</span>"
                                           + "次，占总量的<span class=\"sum-important\">" + data.increasement_rate + "</span>；</p>"
                                           + "<p>" + image + data.datatime + "内Pad登录数最高值日期是<span class=\"sum-important\">" + data.maxDate + "</span>"
                                           + "，为<span class=\"sum-important\">" + data.maxValue + "</span>次，"
                                           + "最低值日期是<span class=\"sum-important\">" + data.minDate + "</span>"
                                           + "，为<span class=\"sum-important\">" + data.minValue + "</span>次。</p></div>";
                                    $("#pad_loginSize_subitem").html(subitem);
                                }
                            }catch(e){} 
  						},
  						error : function(data) {
  							pad_loginSize_report.setOption(pad_loginSize_option);
  							pad_loginSize_report.hideLoading();
  						}
  					});
				});

			});
		</script>
  
  </body>

</html>
