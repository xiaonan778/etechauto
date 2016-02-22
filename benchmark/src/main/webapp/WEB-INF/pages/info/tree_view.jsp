<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <link rel="stylesheet" href="${path}/resources/zTree/css/metroStyle/metroStyle.css" type="text/css" />   
    <script src="${path}/resources/zTree/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="${path}/resources/zTree/js/jquery.ztree.exedit-3.5.min.js"></script>
    <script src="${path}/scripts/info/tree_view.js"></script>
    <link rel="stylesheet" href="${path}/resources/ace/css/chosen.min.css" />
    <script type="text/javascript" src="${path}/resources/ace/js/chosen.jquery.min.js"></script>
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
                        <li class="active">树形结构</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default">
		                 <div class="panel-heading panel-title">
		                    <div class="row">
		                      <div class="col-xs-6">树形结构</div>
		                      <div class="col-xs-6 text-right action-bar">
		                         <a type="button" class="btn btn-primary" href="${path}/info/toAddTree" >新增树节点</a>
		                      </div>
		                    </div>                                    
                         </div>
		            </div>
		            
		            <div class="row" style="margin-top:5px;">
		                <div class="col-xs-12">
		                   <div class="col-xs-12">
		                       <div><a id="openAll" style="cursor:pointer"><i id="treeFlag" class="icon-plus"></i></a></div>
	                           <div>
	                               <ul id="infoTree" class="ztree"></ul>
	                           </div>
	                           <div style="height: 50px;"></div>
	                       </div>
		                </div>
		            </div><!--/row-->
                    
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
        </div>
    </div><!-- /.main-container-inner -->
        <!-- 弹出层 -->
    <div id="myModal1" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;">
       <div class="modal-dialog">
            <div class="modal-content"  style="margin-top: 200px;border-radius: 4px;">
                <div class="modal-header"  style="background-color:#EFF3F8;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">上传文件</h4>
                </div>
                <form id="fileForm" enctype="multipart/form-data">
                <div class="modal-body">
                 	<div class="row">
							<div class="col-md-12">
								<div class="col-md-12">
									<div class="form-group">
										<div class="input-group">
											<div class="input-group-addon">选择文件：</div>
											<input class="form-control" type="file" id="excel"
												name="excel" />
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
              
            </div><!-- /.modal-content -->
         </div><!-- /.modal-dialog -->
     </div><!--弹出层  结束 --> 
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
