<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources2.jsp" />
	<link rel="stylesheet" type="text/css" href="${path }/resources/bootstrap/3.3.0/css/dataTables.bootstrap.min.css">
	<script src="${path }/resources/table/jquery.dataTables.min.js"></script>
	<script src="${path }/resources/table/dataTables.bootstrap.min.js"></script>
	<script src="${path }/resources/table/default.js"></script>
	<script src="${path }/resources/table/datasource2.js"></script>
</head>
  
<body class="navbar-fixed">
    <jsp:include page="../common/header.jsp" />
    <div class="main-container">
        <div class="main-container-inner">  
            <jsp:include page="../common/menu.jsp" />
            
            <div class="main-content" id="mainContent">
                <div class="breadcrumbs breadcrumbs-fixed" id="breadcrumbs">
            
                    <ul class="breadcrumb">
                        <li>
                            <i class="icon-home home-icon"></i>
                            <a href="${path}/">首页</a>
                        </li>
                        <li class="active">信息分类</li>
                        <li class="active">信息查询</li>
                    </ul><!-- .breadcrumb -->
                </div>
                <div class="page-content">
                    <div style="height: 40px;"></div>
			            <div class="row">
		                <div class="col-xs-12">
					    <table id="bm_data" class="table table-striped table-bordered" style="width:100%;" >
					        <thead>
					            <tr>
					                <th>名称</th>
					                <th>模版</th>
					                <th>文件类型</th>
					                <th>文件位置</th>
					                <th>分类条件</th>
					                <th>添加时间</th>
					            </tr>
					        </thead>           
	                        </table>
		                </div>
		                <div id="searchText"></div>
		            </div><!--/row-->	            
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
        </div>
    </div><!-- /.main-container-inner -->
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
