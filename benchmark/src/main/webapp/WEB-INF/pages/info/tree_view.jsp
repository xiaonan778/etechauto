<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
	<jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources2.jsp" />
	<link rel="stylesheet" href="${path}/resources/zTree/css/metroStyle/metroStyle.css" type="text/css" />
	<script src="${path}/resources/zTree/js/jquery.ztree.core-3.5.min.js"></script>
	<script src="${path}/resources/zTree/js/jquery.ztree.exedit-3.5.min.js"></script>
	<script src="${path}/scripts/info/tree_view.js"></script>
	<script type="text/javascript" >
       $(function(){
           $("#sys_import").parent().addClass("active");
       });
    </script>
</head>

<body class="navbar-fixed">
	<jsp:include page="../common/header2.jsp" />
	<!-- Main Container start -->
    <div class="dashboard-container">

        <div class="container">

            <jsp:include page="../common/menu2.jsp" />

            <!-- Dashboard Wrapper Start -->
            <div class="dashboard-wrapper">
					<div style="height: 20px;"></div>
					<div class="panel panel-default">
						<div class="panel-heading panel-title">
							<div class="row">
								<div class="col-xs-6">树形结构</div>
								<div class="col-xs-6 text-right action-bar">
									<a type="button" class="btn btn-primary" href="${path}/info/toAddTree">新增树节点</a>
								</div>
							</div>
						</div>
					</div>

					<div class="row" style="margin-top:5px;">
						<div class="col-xs-12">
							<div class="col-xs-12">
								<div>
									<a id="openAll" style="cursor:pointer"><i id="treeFlag" class="icon-plus"></i></a>
								</div>
								<div>
									<ul id="infoTree" class="ztree"></ul>
								</div>
								<div style="height: 50px;"></div>
							</div>
						</div>
					</div>
					<!--/row-->

		    </div>
		    <!-- Dashboard Wrapper End -->
		    <jsp:include page="../common/footer2.jsp" />
         </div>
     </div>
	<!-- Main Container end -->
	
	
	<!-- 弹出层 -->
	<div id="myModal1" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content"
				style="margin-top: 200px;border-radius: 4px;">
				<div class="modal-header" style="background-color:#EFF3F8;">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">上传文件</h4>
				</div>

				<div class="modal-body">
					<form id="fileForm"  enctype="multipart/form-data">
						<div class="row">
							<div class="col-md-12">
							    <div class="col-sm-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon">新增类型：</div>
                                            <select class="form-control"  id="addType" name="addType" >
                                                <option value="1">分类或标签</option>
                                                <option value="2">Excel</option>
                                                <option value="3">其他文件</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
								<div class="col-sm-12"  id="category1">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon">分类名称：</div>
                                            <input class="form-control" type="text" id="category" name="category" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12"  id="category3">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon">选择模板：</div>
                                            <select class="form-control"  id="template" name="template" >
                                                <c:forEach items="${templateList }"  var="one" >
                                                    <option value="${one.id }">${one.name }</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12"  id="category2">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon">选择文件：</div>
                                            <input class="form-control" type="file" id="uploadFile" name="uploadFile" />
                                        </div>
                                    </div>
                                </div>
							</div>
						</div>
					</form>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal" id="confirmAdd">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>

			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!--弹出层  结束 -->
	
</body>
</html>
