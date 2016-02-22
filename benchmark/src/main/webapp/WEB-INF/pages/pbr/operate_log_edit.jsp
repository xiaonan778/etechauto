<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <script src="${path }/scripts/common/preview.js" ></script>
    <script src="${path }/scripts/pbr/operate_log_edit.js" ></script>
    <script type="text/javascript">
        $(function(){
            $("#sys_ope_log").addClass("active");
            $("#sys").addClass("open");
            $("#sys").addClass("active");
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
                        <li><a href="${path }/pbr/list">运维日志</a></li>
                        <li class="active">日志备注</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default">
			            <div class="panel-heading">
			                <table style="width: 99%;">
			                    <tr>
			                        <td style="width: 4%;text-align: left;" nowrap="nowrap" >
			                        <a  class="btn btn-primary" type="button" href="${path }/pbr/list" >返回</a></td>
			                        <td class="panel-title" style="width: 96%;text-align: center;font-weight:bold">日志备注</td>
			                    </tr>
			               </table>
			            </div>
			            <div class="panel-body">
			            <div class="row">
			            <form  id="tenant_edit_form" class="form"  enctype="multipart/form-data" >
			                <div class="col-md-12">
			                        <p class="bg-success subHeader">基本信息：</p>
			                        <input class="form-control" value="${sysLog.id}" name="id" id="id" type="hidden" readonly>  
			                </div>
				            <div class="row">
				                <div class="col-md-12">
				                    <div class="col-md-6">
				                          <div class="form-group">
				                            <div class="input-group">
				                                    <div class="input-group-addon">租户名称：</div>
				                                    <input class="form-control" value="${sysLog.tenantName}"  type="text" readonly>                            
				                            </div>
				                          </div>
				                    </div>
				                    <div class="col-md-6">
				                          <div class="form-group">
				                            <div class="input-group">
				                                <div class="input-group-addon"> 平台域名：</div>
				                                <input class="form-control" value="${sysLog.domain}" type="text"  readonly> 
				                            </div>
				                          </div>
				                    </div>
				                </div>                  
				            </div>
			<%--            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon"> 标题：</div>
			                                <input class="form-control" value="${sysLog.title}" type="text" readonly>   
			                            </div>
			                        </div>
			                    </div>
			                </div>                  
			            </div> --%>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-12">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">内容：</div>
			                                <textarea class="form-control" rows="2" readonly>${sysLog.content}</textarea>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-12">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">备注：</div>
			                                <textarea class="form-control" rows="2" id="detail" name="detail" maxlength="200">${sysLog.detail}</textarea>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			             <div class="text-center">
			                <button type="button" class="btn btn-primary" onclick="editLog();">保存</button>
			            </div>
			              </form>
			            </div>             
			         </div>    
			        </div>
                    
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
