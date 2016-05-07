<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../common/meta.jsp" />
	<jsp:include page="../common/resources.jsp" />
	<script src="${path }/resources/echarts-2.2.1/echarts-all.js" ></script>
	
    <script type="text/javascript" src="${path }/scripts/report/chart_init.js"></script>
	<script type="text/javascript" src="${path }/scripts/report/report_main.js"></script>
</head>

<body class="navbar-fixed">
	<jsp:include page="../common/header.jsp" />
	<div class="main-container">
		<div class="main-container-inner">
			<jsp:include page="../common/menu.jsp" />

			<div class="main-content" id="mainContent">
				<div class="breadcrumbs breadcrumbs-fixed" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="icon-home home-icon"></i> <a href="${path}/">首页</a></li>
						<li class="active">数据报表</li>
						<li class="active">报表展示</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content" style="margin-top: 40px;">

					<div class="panel panel-default">
						<div class="panel-body">
						
							<div class="row">
								<form class="form" id="searchform" name="searchform">
									<div class="row">
										<div class="col-md-12">
											<div class="col-xs-6">
												<div class="form-group">
													<div class="input-group">
														<div class="input-group-addon">模糊查询：</div>
														<input class="form-control" type="text" id="keywords" name="keywords" />
													</div>
												</div>
											</div>
											<div class="col-xs-6  text-center">
												<input type="button" class="btn btn-large btn-primary" id="searchBtn" value="搜索" /> 
												<input type="button"	class="btn btn-primary" id="reset" value="重置" />
											</div>
										</div>
									</div>
								</form>
							</div>
							
						</div>
					</div>
                    
                    <form id="reportFrom">
					<div class="row" >
                        <div class="col-xs-12"  style="height: 200px;overflow: auto;">
	                        <table id="file_data" class="table table-striped table-bordered" style="width:100%;" >       
	                        </table>
                        </div>
                    </div><!--/row-->
                    
                    <div class="row">
                        <div class="col-xs-12" style="margin-top: 25px;height: 200px;overflow: auto;">
                            <table id="column_data" class="table table-striped table-bordered" style="width:100%;" >       
                            </table>
                        </div>
                    </div><!--/row-->     
                    
                    <div class="row">
                        <div class="col-xs-12"  style="margin-top: 25px;height: 200px;">
                            <table  id="report_data" class="table table-striped table-bordered" style="width:100%;" >       
                            </table>
                        </div>
                    </div><!--/row-->     
                    
                    <div class="row"  >
                        <div class="col-xs-12 text-center"   id="report_btn"  style="margin-bottom: 20px;;height: 100px;display: none;">
                            <button id="createReport"  class="btn btn-large btn-primary"  type="button">生成报表</button>
                        </div>
                    </div><!--/row-->   
                    
                    </form>
                    
                    <div class="row"  >
                        <div class="col-xs-12 text-center" >
                            <div id="report_chart"  style="width: 90%;min-width: 600px;max-width: 95%;height: 550px;margin:0 auto;"></div>
                        </div>
                    </div><!--/row-->   
                    
				</div>
			</div>
			<!-- /.main-content -->

		</div>

	</div>
	<!-- /.main-container-inner -->

	<jsp:include page="../common/footer.jsp" />

</body>
</html>
