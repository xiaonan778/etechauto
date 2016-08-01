<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    
	<link rel="stylesheet" href="${path }/resources/datatables/css/dataTables.bootstrap.min.css" />
    <script src="${path }/resources/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${path }/resources/datatables/js/dataTables.bootstrap.min.js"></script>
    <script src="${path }/resources/datatables/js/default.js"></script>
	
	<script src="${path }/scripts/report/template_list.js"></script>
	
	<style type="text/css">
     
      .opt{
          display: inline-block;
          padding: 5px;
      }
    </style>
    <script type="text/javascript">
    $(function(){
        $("#sys_config").parent().addClass("active");
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
	                        <li class="active">设置</li>
	                        <li class="active">模板管理</li>
	                    </ul>
	                    <!-- .breadcrumb -->
	                </div>
                    <div class="panel panel-default">
                        <div class="panel-heading panel-title">
                            <div class="row">
                                <div class="col-xs-3"></div>
                                <div class="col-xs-6 text-center">模板管理</div>
                                <div class="col-xs-3 text-right"><button type="button" class="btn btn-large btn-primary" id="addTemplate">新增模板</button> </div>
                            </div>
                         </div>
                    </div>
            
		            <div class="row">
		                <div class="col-xs-12">
						    <table id="template" class="table table-striped table-bordered" style="width:100%;" ></table>
		                </div>
		            </div><!--/row-->	            
             </div>
            <!-- Dashboard Wrapper End -->

            <jsp:include page="../common/footer.jsp" />

        </div>
    </div>
    <!-- Main Container end -->
    
    <div id="templateModal" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                    <h4 class="modal-title" >新增模板</h4>
               </div>
               <div class="modal-body" style="overflow: auto;min-height: 100px;max-height: 450px;">
                    <form id="uploadForm" enctype="multipart/form-data" method="post" action="${path }/template/upload">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-addon">模板名称</div>
                                        <input class="form-control" type="text" name="template_name" id="template_name" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-addon">模板类型</div>
                                        <select class="form-control" name="template_type" id="template_type" >
                                            <c:forEach items="${dicList }" var="item">
                                                <option value="${item.id }">${item.name }</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-addon">模板文件</div>
                                        <input class="form-control" type="file" name="template_excel" id="template_excel" 
                                        accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-addon">描述</div>
                                        <textArea class="form-control" id="desciption" name="desciption"></textArea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
               </div>
               <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" >取消</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveBtn" >确 定</button>
               </div>
            </div>
        </div>
    </div>
    <script>
    $(function(){
    	$("#addTemplate").click(function(){
    		$("#templateModal").modal("show");
    	});
    	$("#saveBtn").click(function(){
    		if (!$("#template_name").val()) {
    			bravoui.ui.msg.alert("模板名称不可为空");
    			return false;
    		}
    		if (!$("#template_excel").val()) {
    			bravui.ui.msg.alert("请选择Excel模板文件");
    			return false;
    		}
    		bravoui.ui.msg.waiting({
    			title: "正在上传模板",
    			msg: "请稍等..."
    		});
    		$("#uploadForm").ajaxSubmit({
    			dataType: "json",
    			success: function(data){
    				bravoui.ui.msg.waiting.remove();
    				if (data.status == "S") {
    					bravoui.ui.msg.alert({
    						msg:data.message,
    						ok: function(){
    							location.reload();
    						}
   						});
    				} else {
    					bravoui.ui.msg.alert(data.message);
    				}
    			},
    			error: function(xhr, msg, error){
    				bravoui.ui.msg.waiting.remove();
    				if (msg == "parsererror") {
    					bravoui.ui.msg.alert({
                            msg:"连接超时，请重新登录",
                            ok: function(){
                                location.reload();
                            }
                        });
    				} else {
    					bravoui.ui.msg.alert("Internal Server Error");
    				}
    			}
    		});
    		
    	});
    });
    </script>
</body>
</html>
