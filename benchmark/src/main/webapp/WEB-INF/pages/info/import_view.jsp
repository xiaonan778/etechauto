<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>

<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <link rel="stylesheet" href="${path}/resources/ace/css/chosen.min.css" />
    <script type="text/javascript" src="${path}/resources/ace/js/chosen.jquery.min.js"></script>
    <script type="text/javascript">
    $(function () {
	     $("#exModel").chosen().change(function(){

	    });
    
    	$("#submit").click(function(){
    	    if(!$("#exModel").val()){
    	        $("#exModel").focus();
    	        bravoui.ui.msg.alert("请选择Execl模版！");
                return false;
    	    }
    		if (!$("#excel").val()) {
    			$("#excel").focus();
    			bravoui.ui.msg.alert("请选择Execl文件！");
                return false;
    		}
    		bravoui.ui.msg.waiting({
    			title : "正在导入",
    			msg : "请稍等..."
    		});
    		$("#fileForm").ajaxSubmit({
                type: "POST",
                url: _path + "/info/fileRead/"+$("#exModel").val(),
                dataType: "json",
                success: function(data){
                	bravoui.ui.msg.waiting.remove();
                	if (data.msg == "success") {
                		$("#excel").val("");
                		bravoui.ui.msg.alert("导入成功！");
                	} else {
                	    bravoui.ui.msg.alert(data.msg);
                	}
                },  
                error : function(xhr, msg, error) {  
                	bravoui.ui.msg.waiting.remove();
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
				        <li class="active">导入读取规则</li>
				    </ul><!-- .breadcrumb -->
				</div>
				            
				<div class="page-content">
				    <div style="height: 40px;"></div>
				    <div class="alert alert-info">
                         <i class="icon-hand-right"></i> 请上传Excel文件
                    </div>
                    <form id="fileForm" enctype="multipart/form-data">
                     <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon">选择模版:</div>
                                            <select class="form-control" id="exModel" name="exModel" style="width:300px;" >
                                            	  <option value="">&nbsp;</option>
                                                  <c:forEach items="${dicList}" var="per" >
                                                      <option value="${per.id}">${per.name}</option>
                                                  </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="parents_select" style="visibility: hidden;" >
                                        <div class="input-group">
                                            <div class="input-group-addon">父级节点</div>
                                            <input class="form-control easyui-combotree" type="text" id="parent_fk" name="parent_fk" style="width:300px;height:35px;" />
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
				</div>
            </div><!-- /.main-content -->
        </div>
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
       