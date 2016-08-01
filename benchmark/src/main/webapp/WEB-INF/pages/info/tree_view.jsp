<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
	<jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
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
                            <li class="active">数据导入</li>
                        </ul>
                        <!-- .breadcrumb -->
                    </div>
                    
					<div class="panel panel-default">
						<div class="panel-heading panel-title">
							<div class="row">
								<div class="col-xs-6" style="font-weight:bold">车型分类</div>
								<div class="col-xs-6 text-right">
									<a type="button" class="btn btn-primary" href="${path}/info/toAddTree">新增车型</a>
								</div>
							</div>
						</div>
						<div class="panel-body">
						   <div class="row" style="margin-top:5px;">
		                        <div class="col-md-6">
	                                <div>
	                                    <a id="openAll" style="cursor:pointer"><i id="treeFlag" class="fa fa-plus"></i></a>
	                                </div>
	                                <div>
	                                    <ul id="infoTree" class="ztree"></ul>
	                                </div>
	                                <div class="row" style="margin-top: 50px;">
	                                   <div class="col-xs-12">
	                                       <div class="form-group">
	                                           <div class="input-group">
	                                                <div class="input-group-addon">已选择车型</div>
	                                                <textArea  class="form-control" id="selectedCategory" readonly="readonly" ></textArea>
	                                                
	                                           </div>
	                                       </div>
	                                       </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                      
                                </div>
                            </div>
                            <!--/row-->
                        </div>
                        
                    </div>
                    
                    <div class="panel panel-default">
                        <div class="panel-heading panel-title">
                            <div class="row">
                                <div class="col-xs-6" style="font-weight:bold">实验数据录入</div>
                                <div class="col-xs-6 text-right">
                                    <button type="button" class="btn btn-primary"  id="fileChooseBtn" >文件选择</button>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                           <div class="row">
		                        <div class="col-xs-12" style="margin-top: 10px;">
		                            <form id="uploadForm"  enctype="multipart/form-data">
		                                <input type="hidden" name="categoryId" id="categoryId" />
		                                <input type="hidden" name="categoryName" id="categoryName" />
			                            <table id="tp" class="table table-striped table-hover table-bordered table-responsive" style="width:100%;">      
			                               <thead>
			                                   <tr>
			                                        <th>模板名称</th>
			                                        <th>文件类型</th>
			                                        <th>文件名</th>
			                                        <th>操作</th>
			                                    </tr>
			                               </thead>
			                               <tbody>
			                               </tbody>          
			                            </table>
		                            </form>
		                        </div>
		                    </div><!--/row-->   
		                    
		                    <div class="row">
		                          <div class="col-xs-12 text-center">
		                              <button type="button" class="btn btn-primary" id="uploadBtn">确认上传</button>
		                          </div>
		                    </div><!--/row-->
                        </div>
                        
                    </div>

            </div>
            <!-- Dashboard Wrapper End -->
            <jsp:include page="../common/footer.jsp" />
         </div>
     </div>
    <!-- Main Container end -->
    
    
    <!-- 弹出层 -->
    <div id="myModal1" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content"  style="margin-top: 100px;border-radius: 4px;">
                <div class="modal-header" style="background-color:#EFF3F8;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" >新增分类</h4>
                </div>

                <div class="modal-body">
                    <form id="addForm" >
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-sm-12" >
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon">分类名称：</div>
                                            <input class="form-control" type="text" id="category" name="category" />
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
    
    <!-- 文件选择 弹出层 -->
    <div id="fileChooseModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content"  style="margin-top: 100px;border-radius: 4px;">
                <div class="modal-header" style="background-color:#EFF3F8;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" >文件选择</h4>
                </div>

                <div class="modal-body">
                    <div id="fileContainer">
                      <div class="row">
                          <div class="col-md-12">
                              <div class="form-group">
                                   <div class="input-group">
                                  <label class="checkbox-inline"><input type="radio" name="fileType" value="1" >按Excel模板导入</label>
                                  <label class="checkbox-inline"><input type="radio" name="fileType" value="2" >其他文件导入</label>
                             </div>
                         </div>
                          </div>
                      </div>
                      
                      <div class="row hidden fileType1" >
                          <div class="col-xs-5">
                               <div class="form-group">
                                   <div class="input-group">
                                       <div class="input-group-addon">模板：</div>
                                       <select class="form-control"  id="template" name="template" >
                                          <c:forEach items="${ templateList}" var="item">
                                              <option value="${item.id }">${item.template_name }</option>
                                          </c:forEach>
                                       </select>
                                   </div>
                               </div>
                          </div>
                          <div class="col-xs-5">
                               <div class="form-group">
                                   <div class="input-group">
                                       <div class="input-group-addon">文件：</div>
                                       <input class="form-control" type="file" id="excelFile" name="excelFile" 
                                       accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />
                                   </div>
                               </div>
                          </div> 
                          <div class="col-xs-2">
                               <a class="addFile1" style="cursor:pointer;line-height: 34px;"><i  class="fa fa-plus"></i></a>
                               <a class="removeFile1 hidden" style="margin-left:10px;cursor:pointer;line-height: 34px;"><i  class="fa fa-minus"></i></a>
                          </div>   
                      </div>
                      
                      <div class="row hidden fileType2" >
                          <div class="col-xs-6">
                               <div class="form-group">
                                   <div class="input-group">
                                       <div class="input-group-addon">文件：</div>
                                       <input class="form-control" type="file" id="otherFile" name="otherFile" />
                                   </div>
                               </div>
                          </div> 
                          <div class="col-xs-6">
                               <a class="addFile2" style="cursor:pointer;line-height: 34px;"><i  class="fa fa-plus"></i></a>
                               <a class="removeFile2 hidden" style="margin-left:10px;cursor:pointer;line-height: 34px;"><i  class="fa fa-minus"></i></a>
                          </div> 
                      </div>
                    </div>    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="chooseConfirmbtn">确定</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>

            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!--文件选择 弹出层  结束 -->
    
</body>
</html>
