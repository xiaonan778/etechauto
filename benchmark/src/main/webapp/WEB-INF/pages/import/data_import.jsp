<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <link rel="stylesheet" type="text/css" href="${path }/resources/iCheck/skins/all.css" />
    <script src="${path }/resources/iCheck/icheck.min.js"></script>
    <script type="text/javascript">
    $(function () {
    	$("#sys_import").addClass("active");
        $("#sys").addClass("open");
        $("#sys").addClass("active");

     	$("input[type='radio']").iCheck({
     	    radioClass: 'icheckbox_flat-orange',
            increaseArea: '20%' // optional
     	});
    	
    	$("#submit").click(function(){
    		if (!$("input[name='tenant_fk']:checked").length) {
    			alert("请选择一个租户！");
    			return false;
    		}
    		if (!$("#excel").val()) {
    			$("#excel").focus();
    			alert("请选择Execl文件！");
                return false;
    		}
    		$("#myModalLabel").html("正在导入数据");
            $("#modalBody").html("请稍后...");
            $("#openModal").click();
    		$("#fileForm").ajaxSubmit({
                type: "POST",
                url: _path + "/import/fileRead",
                dataType: "json",
                success: function(data){
                	$("#closeModal").click();
                	if (data.msg == "success") {
                		$("#excel").val("");
                		$.each($("input[name='tenant_fk']:checked"), function(i, box) {
                            $(box).iCheck('uncheck');
                        });
                		bravoui.ui.msg.alert("导入成功！");
                	} else {
                		alert( data.msg );
                	}
                },  
                error : function(xhr, msg, error) {  
                	$("#closeModal").click();
                	if ("timeout" == msg || "parsererror" == msg) {
                        bravoui.ui.msg.alert("对不起，session过期，请重新登录!");
                        $(document).on("click", "#closeModal", function(){
                            window.location.reload();
                        });
                    } else {
                        bravoui.ui.msg.alert("Internal Server Error!");
                    }
                }  
            });
    	});
    });
    </script>
</head>
<body class="navbar-fixed">
    <button class="btn" data-toggle="modal" data-target="#modal" id="openModal" style="display: none;"></button>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="modal" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog">
          <div class="modal-content" style="margin-top: 150px;border-radius: 4px;">
             <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="closeModal" style="display: none;">&times;</button>
                <h2 class="modal-title" id="myModalLabel"></h2>
             </div>
             <div class="modal-body" >
                <h4 id="modalBody"></h4>
             </div>
          </div><!-- /.modal-content -->
       </div>
     </div><!-- /.modal -->

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
				        <li class="active">系统配置</li>
				        <li class="active">数据导入</li>
				    </ul><!-- .breadcrumb -->
				</div>
				            
				<div class="page-content">
				    <div style="height: 40px;"></div>
				    <div class="alert alert-info">
                         <i class="icon-hand-right"></i> 请选择租户后再上传Excel文件
                    </div>
                    <c:if test="${size > 0 }">
                    <form id="fileForm" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-12">
	                                 <div class="form-group">
	                                     <div class="input-group">
	                                         <div class="input-group-addon">租户：</div>
	                                         <div style="margin-left: 10px;">
	                                         <c:forEach items="${tenants }" var="tenant">
	                                             <span style="display: inline-block;"><input  type="radio" id="tenant_fk" name="tenant_fk" value="${tenant.id }"/>${tenant.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
	                                         </c:forEach>
	                                         </div>
	                                     </div>
	                                 </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon">Excel文件：</div>
                                            <input class="form-control" type="file" id="excel" name="excel" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 text-center">
                                 <button type="button" class="btn btn-primary" id="submit">导 入</button>
                            </div>
                        </div>
                    </form>
                    </c:if>
					<c:if test="${size == 0 }">
					   <div class="text-center">
					       <div style="height: 400px">
                            <br>
                            <span style="font-size: 30px;" >暂无租户</span>
                            </div>
                       </div>
					</c:if>
				</div>
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
       