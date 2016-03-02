<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML>
<html>
<head>
	<jsp:include page="../common/meta.jsp" />
	<jsp:include page="../common/resources.jsp" />
	<link rel="stylesheet" type="text/css" href="${path }/resources/iCheck/skins/all.css" />
    <script src="${path }/resources/iCheck/icheck.min.js"></script>
    <script type="text/javascript">
    $(function () {
    	
    	$("input[type='checkbox']").iCheck({
    		checkboxClass: 'icheckbox_flat-orange',
            increaseArea: '20%' // optional
        });
    	$("#reset").click(function(){
    		$("input[name='tableName']:checked").iCheck('uncheck');
    		$("#alpha_max").val("");
    		$("#alpha_min").val("");
    	});
    	
        
    });
    </script>
</head>
<body class="navbar-fixed">
	<jsp:include page="../common/header.jsp" />
	<div class="main-container">
		<div class="main-container-inner">
			<jsp:include page="../common/menu.jsp" />

			<div class="main-content" id="mainContent">
				<div class="breadcrumbs breadcrumbs-fixed" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="icon-home home-icon"></i> <a href="${path}/">首页</a>
						</li>
						<li class="active">数据报表</li>
						<li class="active">散点图</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div style="height: 40px;"></div>
                    
                    <div class="panel panel-default">
                        <div class="panel-body">
                          <div class="row">
                            <form class="form" id="searchform" name="searchform">
                              <div class="row">
                                 <div class="col-md-12">
	                                <div class="col-md-12">
	                                  <div class="form-group">
	                                    <div class="input-group">
	                                         <div class="input-group-addon">数据标识：</div>
	                                          <div style="margin-left: 10px;">
                                             <c:forEach items="${tableList }" var="one">
                                                 <span style="display: inline-block;margin-right: 15px;"><input  type="checkbox" id="tableName" name="tableName" value="${one.name }"/>${one.name}</span>
                                             </c:forEach>
                                             </div>
	                                     </div>
	                                  </div>
	                                </div>
	                                <div class="col-md-6">
	                                  <div class="form-group">
	                                    <div class="input-group">
	                                      <div class="input-group-addon">ALPHA大于</div>
	                                      <input class="form-control" type="text" id="alpha_min" name="alpha_min" />
	                                    </div>
	                                  </div>
	                                </div>
	                                <div class="col-md-6">
	                                  <div class="form-group">
	                                    <div class="input-group">
	                                      <div class="input-group-addon">ALPHA小于</div>
	                                      <input class="form-control" type="text" id="alpha_max" name="alpha_max" />
	                                    </div>
	                                  </div>
	                                </div>
	                                <div class="col-md-12 text-center">
	                                  <input type="button" class="btn btn-large btn-primary"  id="searchBtn" value="搜索" /> 
	                                  <input type="button" class="btn btn-primary"  id="reset" value="重置" />
	                                </div>
                                </div>
                              </div>
                            </form>
                          </div>
                        </div>
                      </div>
                    
					<div class="row">
						<div class="col-md-12 text-center">
								<div id="chart_scatter" style="width: 90%;min-width: 600px;max-width: 95%;height: 480px;margin:0 auto;"></div>
						</div>
					</div>
				</div>
			</div>
			<!-- /.main-content -->

		</div>

	</div>
	<!-- /.main-container-inner -->

	<jsp:include page="../common/footer.jsp" />

	<script type="text/javascript">
			require.config({
				paths : {
					echarts : '${path}/resources/echarts-2.2.1'
				}
			});
			require(
			        [ 'echarts', 'echarts/themes/shine', 'echarts/chart/scatter' ],
	                function(ec, theme) {
			        	var report_scatter = ec.init(document.getElementById('chart_scatter'), theme);
						report_scatter.showLoading({
						    text : '正在努力的读取数据中...',
						});
						option_scatter = {
						    title : {
						        text : "TORQUE & SPEED",
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
						        y : 100
						    },
						    tooltip : {
						        trigger: 'axis',
						        showDelay : 0,
						        formatter : function (params) {
						            if (params.value.length > 1) {
						                return params.seriesName + ' :<br/>'
						                   + params.value[0] + ' rpm   ' 
						                   + params.value[1] + ' Nm';
						            } 
						        },  
						        axisPointer:{
						            show: true,
						            type : 'cross',
						            lineStyle: {
						                type : 'dashed',
						                width : 1
						            }
						        }
						    },
						    xAxis : [ {
					            type : 'value',
					            scale:true,
					            axisLabel : {
					                formatter: '{value} rpm'
					            }
					        } ],
						    yAxis : [ {
					            type : 'value',
					            scale:true,
					            axisLabel : {
					                formatter: '{value} Nm'
					            }
					        }],
						    series : [ {
						        name : '',
                                type : 'scatter',
						        data : []
						    } ]
						};
						report_scatter.setOption(option_scatter);
						// send request data.
						if (window.addEventListener) {
	                        window.addEventListener("resize", function() {
	                            report_scatter.resize();
	                        });
	                    } else {
	                        window.attachEvent("resize", function() {
	                            report_scatter.resize();
	                        });
	                    }
						
						$("#searchBtn").click(function(){
				            if (!$("input[name='tableName']:checked").val()) {
				                $("#tableName").focus();
				                bravoui.ui.msg.alert("请选择数据标识！");
				                return false;
				            }
				            $("#searchform").ajaxSubmit({
				                type: "GET",
				                url: _path + "/report/listByAlpha",
				                dataType: "json",
				                success: function(data){
				                    if (data.status == "S" && data.result && data.result.length > 0 ) {
				                    	
				                        var result = data.result;
				                        var legend = {
				                            x: 80,
				                            y: 60,
				                            data:[]
				                        };
				                        for (var i = 0; i < result.length; i++) {
				                        	var item = result[i];
				                        	var itemArray = [];
				                        	if (item.list && item.list.length > 0) {
				                        		for (var j =0; j < item.list.length; j++) {
				                        			var record = item.list[j];
				                        			itemArray.push([record.speed, record.torque]);
				                        		}
				                        		option_scatter.series.push({
	                                                name: item.type,
	                                                type: 'scatter',
	                                                data: itemArray
	                                            });
				                        		legend.data.push(item.type);
				                        	}
				                        }
				                        option_scatter.legend = legend;
				                        report_scatter.clear();
				                        report_scatter.setOption(option_scatter);
				                        report_scatter.hideLoading();
				                    } 
				                },  
				                error : function(xhr, msg, error) {  
				                    if ("timeout" == msg || "parsererror" == msg) {
				                        bravoui.ui.msg.alert({
				                            msg:"对不起，session过期，请重新登录!",
				                            ok: function(){
				                                window.location.reload();
				                            }
				                        });
				                    } else {
				                        bravoui.ui.msg.alert("Internal Server Error!");
				                    }
				                }  
				            });
				        });
						
			        }
			);
	</script>
</body>
</html>
