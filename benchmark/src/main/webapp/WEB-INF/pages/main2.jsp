<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<jsp:include page="common/meta.jsp" />
	<jsp:include page="common/resources.jsp" />
	
	<script src="${path }/resources/echarts-2.2.1/echarts-all.js"></script>
	
	<script type="text/javascript" src="${path }/scripts/report/report_main.js"></script>
	<script type="text/javascript" >
	   $(function(){
		   $("#sys_search").parent().addClass("active");
	   });
	</script>
</head>

<body>
	<jsp:include page="common/header.jsp" />

	<!-- Main Container start -->
	<div class="dashboard-container">

		<div class="container">

			<jsp:include page="common/menu.jsp" />

			<!-- Dashboard Wrapper Start -->
			<div class="dashboard-wrapper">
                <div class="breadcrumbs" id="breadcrumbs">
                    <ul class="breadcrumb">
                        <li><i class="icon-home home-icon"></i> <a href="${path}/">首页</a></li>
                        <li class="active">信息检索</li>
                    </ul>
                    <!-- .breadcrumb -->
                </div>
                <div class="container-fluid">
					<div class="row">
						<div class="col-md-3" style="min-height: 500px;">
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
						
						<div class="col-md-9" style="min-height: 500px;border-left-style: ridge;">
                             <form id="reportFrom">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <table id="file_data" class="table table-striped table-bordered" style="width:100%;">
                                            </table>
                                            <div id="grid-pager"></div>
                                        </div>
                                    </div>
                                    <!--/row-->
                                </div>  
                            </form>
                        </div>
                        
                    </div>
                </div>
            </div>
            <!-- Dashboard Wrapper End -->

            <jsp:include page="common/footer.jsp" />

        </div>
    </div>
    <!-- Main Container end -->
    
</body>
</html>
