<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
	<jsp:include page="../common/meta.jsp" />
	<jsp:include page="../common/resources.jsp" />
	
	<script src="${path }/resources/echarts-2.2.1/echarts-all.js"></script>
	
	<script type="text/javascript" src="${path }/scripts/report/chart_init.js"></script>
	<script type="text/javascript" src="${path }/scripts/report/chart_main.js"></script>
	<script type="text/javascript" >
	   $(function(){
		   $("#sys_chart").parent().addClass("active");
	   });
	</script>
</head>

<body>
	<jsp:include page="../common/header.jsp" />

	<!-- Main Container start -->
	<div class="dashboard-container">

		<div class="container">

			<jsp:include page="../common/menu.jsp" />

			<!-- Dashboard Wrapper Start -->
			<div class="dashboard-wrapper">
                <div class="breadcrumbs" id="breadcrumbs">
                    <ul class="breadcrumb">
                        <li><i class="icon-home home-icon"></i> <a href="${path}/">首页</a></li>
                        <li class="active">生成报表</li>
                    </ul>
                    <!-- .breadcrumb -->
                </div>
                <div class="container-fluid">
                    <form id="chartFrom">
						<div class="row">
							<div class="col-md-3" style="min-height: 500px;padding-top:20px;">
								<div class="form-group">
									<div class="input-group">
									    <div class="input-group-addon">数据模板</div>
										<select  class="form-control" name="template" id="template" >
										      <c:forEach items="${templateList }" var="item">
										          <option value="${item.id }">${item.template_name}</option>
										      </c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group">
	                                 <div class="input-group">
	                                     <div class="input-group-addon">报表类型</div>
	                                     <select class="form-control"  name='chartType'>
	                                         <option value='SCATTER'>散点图</option>
	                                         <option value='BAR'>柱状图</option>
	                                     </select>
	                                 </div>
	                             </div>
	                             <div class="form-group">
	                                 <div class="input-group">
	                                     <div class="input-group-addon">X轴</div>
	                                     <select name='xAxis' id='xAxis'>
	                                         <c:forEach items="${columnList }" var="item">
	                                             <option value="${item }">${item}</option>
	                                         </c:forEach>
	                                     </select>
	                                 </div>
	                             </div>
					             <div class="form-group">
	                                 <div class="input-group">
	                                     <div class="input-group-addon">Y轴</div>
	                                     <select name='yAxis' id='yAxis' >
	                                         <c:forEach items="${columnList }" var="item">
	                                             <option value="${item }">${item}</option>
	                                         </c:forEach>
	                                     </select>
	                                 </div>
	                             </div>
									
								<div class="col-md-12 text-center">
								     <button type="button" class="btn btn-primary btn-block"  id="createReport">生成报表</button>
								</div>
							</div>
							
							<div class="col-md-9" style="min-height: 500px;border-left-style: ridge;">
									
								<div class="panel panel-default">
								    <div class="panel-heading panel-title">
			                            <div class="row">
			                                <div class="col-xs-12">筛选条件</div>
			                            </div>
			                         </div>
			                         <div class="panel-body">
			                             <div class="row">
	                                             <div class="col-xs-12">
			                                     <table id="report_data" class="table table-striped table-bordered" style="width:100%;max-height: 200px;overflow:auto;">
				                                    <c:forEach items="${columnList }" var="item">
					                                     <tr>
		                                                      <td>  ${item }</td>
		                                                      <td>
		                                                          <input type='hidden' name='queryAttribute' value="${item }" >
		                                                          <select  class='condition' name="${item }_rule" ><option value='1'>等于</option><option value='2'>介于</option></select>
		                                                      </td>
		                                                      <td>
		                                                          <input type='text' name='${item }_eq' id='${item }_eq' />
		                                                          <input style='display:none;' type='text' name='${item }_gt' id='${item }_gt'  />
		                                                          <input style='display:none;'  type='text' name='${item }_lt' id='${item }_lt' />
		                                                      </td>
			                                             </tr>
		                                            </c:forEach>
	                                                </table>
	                                           </div>
	                                        </div>
			                         </div>
								</div>
	
								<div class="row">
									<div class="col-xs-12 text-center">
										<div id="report_chart" style="width: 90%;min-width: 600px;max-width: 95%;height: 550px;margin:0 auto;"></div>
									</div>
								</div>
								<!--/row-->
	                        
							</div>
								
						</div>
					</form>
                </div>
			</div>
			<!-- Dashboard Wrapper End -->

			<jsp:include page="../common/footer.jsp" />

		</div>
	</div>
	<!-- Main Container end -->
    
</body>
</html>
