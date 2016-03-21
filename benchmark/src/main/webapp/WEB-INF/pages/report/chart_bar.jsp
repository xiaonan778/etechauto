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
						<li class="active">柱状图</li>
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
                                                 <span style="display: inline-block;margin-right: 15px;"><input  type="checkbox" id="tableName" name="tableName" value="${one.rule }"/>${one.name}</span>
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
								<div id="chart_bar" style="width: 90%;min-width: 600px;max-width: 95%;height: 480px;margin:0 auto;"></div>
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
			        [ 'echarts', 'echarts/themes/blue', 'echarts/chart/bar' ],
	                function(ec, theme) {
			        	var report_bar = ec.init(document.getElementById('chart_bar'), theme);
						report_bar.showLoading({
						    text : '正在努力的读取数据中...',
						});
						option_bar = {
						    title : {
						        text : "TORQUE",
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
						        trigger : 'axis',
						        axisPointer : {
						            type : 'shadow'
						        },
						        formatter : '{b}<br/> {a}: {c}Nm  '
						    },
						    
						    xAxis : [ {
						        type : 'category',
						        boundaryGap : true,
						        data : ['']
						    } ],
						    yAxis : [ {
						        type : 'value',
						        axisLabel : {
						            formatter : '{value} Nm'
						        }
						    } ],
						    series : [ {
						        name : 'TORQUE',
						        smooth: true,
                                type : 'bar',
						        data : []
						    } ]
						};
						report_bar.setOption(option_bar);
						// send request data.
						if (window.addEventListener) {
	                        window.addEventListener("resize", function() {
	                            report_bar.resize();
	                        });
	                    } else {
	                        window.attachEvent("resize", function() {
	                            report_bar.resize();
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
				                url: _path + "/report/getMaxTorqueByAlpha",
				                dataType: "json",
				                success: function(data){
				                    if (data.status == "S" && data.result && data.result.length > 0 ) {
				                    	
				                        var labels = [];
				                        var values = [];
				                        var result = data.result;
				                        for (var i = 0; i < result.length; i++) {
				                            labels.push(result[i].tableName);
				                            values.push(result[i].torque ? result[i].torque : 0);
				                        }
				                        option_bar.xAxis[0].data = labels;
				                        option_bar.series[0].data = values;
				                        report_bar.clear();
				                        report_bar.setOption(option_bar);
				                        report_bar.hideLoading();
				                    } else {
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
