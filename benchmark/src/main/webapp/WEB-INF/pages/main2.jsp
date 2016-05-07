<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<jsp:include page="common/meta.jsp" />
	<jsp:include page="common/resources2.jsp" />
	
	<script src="${path }/resources/echarts-2.2.1/echarts-all.js"></script>
	
	<script type="text/javascript" src="${path }/scripts/report/chart_init.js"></script>
	<script type="text/javascript" src="${path }/scripts/report/report_main.js"></script>
	<script type="text/javascript" >
	   $(function(){
		   $("#sys_search").parent().addClass("active");
	   });
	</script>
</head>

<body>
	<jsp:include page="common/header2.jsp" />

	<!-- Main Container start -->
	<div class="dashboard-container">

		<div class="container">

			<jsp:include page="common/menu2.jsp" />

			<!-- Dashboard Wrapper Start -->
			<div class="dashboard-wrapper">

				<div class="row">
					<div class="col-md-3"
						style="min-height: 680px;border-right-style: ridge;">
						<div class="col-xs-12">
							<form class="form-inline">
								<div class="form-group">
									<div class="input-group">
										<input type="text" class="form-control" name="keywords" id="keywords" placeholder="请输入关键字搜索">
									</div>
								</div>
								<button type="button" class="btn btn-primary" id="searchBtn">
									<i class="fa fa-search"></i>
								</button>
							</form>
						</div>
					</div>
					<form id="reportFrom">
						<div class="col-md-9" style="min-height: 680px;">
							<ul id="myTab" class="nav nav-tabs">
								<li class="active"><a href="#reportData" data-toggle="tab">数据展示</a>
								</li>
								<li><a href="#reportChart" data-toggle="tab" id="chartTab">报表展示</a></li>
							</ul>
							<div id="myTabContent" class="tab-content" style="min-height: 640px;">

								<div class="tab-pane fade in active" id="reportData">

									<div class="row">
										<div class="col-xs-12" style="height: 200px;overflow: auto;">
											<table id="file_data"
												class="table table-striped table-bordered"
												style="width:100%;">
											</table>
										</div>
									</div>
									<!--/row-->

								</div>
								<div class="tab-pane fade" id="reportChart">
									<div class="row">
										<div class="col-xs-12"
											style="margin-top: 25px;height: 200px;overflow: auto;">
											<table id="column_data"
												class="table table-striped table-bordered"
												style="width:100%;">
											</table>
										</div>
									</div>
									<!--/row-->

									<div class="row">
										<div class="col-xs-12" style="margin-top: 25px;height: 200px;">
											<table id="report_data"
												class="table table-striped table-bordered"
												style="width:100%;">
											</table>
										</div>
									</div>
									<!--/row-->

									<div class="row">
										<div class="col-xs-12 text-center" id="report_btn"
											style="margin-bottom: 20px;;height: 100px;display: none;">
											<button id="createReport" class="btn btn-large btn-primary"
												type="button">生成报表</button>
										</div>
									</div>
									<!--/row-->

									<div class="row">
										<div class="col-xs-12 text-center">
											<div id="report_chart"
												style="width: 90%;min-width: 600px;max-width: 95%;height: 550px;margin:0 auto;"></div>
										</div>
									</div>
									<!--/row-->
									
								</div>
								
							</div>

						</div>
					</form>
				</div>

			</div>
			<!-- Dashboard Wrapper End -->

			<jsp:include page="common/footer2.jsp" />

		</div>
	</div>
	<!-- Main Container end -->

</body>
</html>
