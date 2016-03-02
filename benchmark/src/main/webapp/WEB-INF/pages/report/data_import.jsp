<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <link rel="stylesheet" href="${path}/resources/ace/css/chosen.min.css" />
    <script type="text/javascript" src="${path}/resources/ace/js/chosen.jquery.min.js"></script>
    <script type="text/javascript">
    $(function () {
    	
    	$("#tableName").chosen().change(function(){

        });
    	
    	$("#submit").click(function(){
    		if (!$("#tableName").val()) {
                $("#tableName").focus();
                bravoui.ui.msg.alert("请选择导入标识！");
                return false;
            }
    		if (!$("#excel").val()) {
    			$("#excel").focus();
    			 bravoui.ui.msg.alert("请选择Execl文件！");
                return false;
    		}
            bravoui.ui.msg.waiting({
            	title: "正在导入数据",
            	msg: "请稍后..."
            });
    		$("#importForm").ajaxSubmit({
                type: "POST",
                url: _path + "/report/dataImport",
                dataType: "json",
                success: function(data){
                	bravoui.ui.msg.waiting.remove();
                	if (data.msg == "success") {
                		$("#excel").val("");
                		$("#tableName").val("");
                		$("#tableName").trigger("chosen:updated");
                		bravoui.ui.msg.alert("导入成功！");
                	} else {
                		alert( data.msg );
                	}
                },  
                error : function(xhr, msg, error) {  
                	bravoui.ui.msg.waiting.remove();
                	if ("timeout" == msg || "parsererror" == msg) {
                        bravoui.ui.msg.alert({
                        	msg:"对不起，session过期，请重新登录!",
                        	ok: function(){
                        		window.location.reload();
                        	}
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
				    <div style="height: 50px;"></div>
                    <form id="importForm" enctype="multipart/form-data" style="min-height: 400px;">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon">数据导入标识：</div>
                                             <select class="form-control" id="tableName" name="tableName" style="min-width:300px;" >
                                                  <option value="">&nbsp;</option>
                                                  <c:forEach items="${tableList}" var="one" >
                                                      <option value="${one.name}">${one.name}</option>
                                                  </c:forEach>
                                            </select>
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
                        <div class="row " >
                            <div class="col-md-12 text-center"  style="margin-top: 40px;width: 100%;"  >
                                 <button type="button" class="btn btn-primary" id="submit">导 入</button>
                            </div>
                        </div>
                    </form>
               
				</div>
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
       