<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
  import="org.apache.shiro.SecurityUtils"
  import="org.apache.shiro.subject.Subject"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%  
    Subject subject = SecurityUtils.getSubject();
%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <title>首页</title>
    <jsp:include page="../common/resources.jsp" />
    <script src="${path }/scripts/plugins/mask/jquery.bravoui.mask.js" ></script>
    <script src="${path }/scripts/tms/tenant_addContainer.js" ></script>
    <style type="text/css">
      .dk_container span.dk_label{
          line-height:19px;
      }
      .dk_container{
          line-height:19px;
      }
    </style>
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
    <div class="main-container" >
        <div class="main-container-inner">  
            <jsp:include page="../common/menu.jsp" />
            
            <div class="main-content" id="mainContent">
                <div class="breadcrumbs breadcrumbs-fixed" id="breadcrumbs">
            
                    <ul class="breadcrumb">
                        <li>
                            <i class="icon-home home-icon"></i>
                            <a href="${path}/">首页</a>
                        </li>
                        <li class="active">租户管理</li>
                        <li><a href="${path}/tms/updateView">租户升级</a></li>
                        <li class="active">租户扩容</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
					<div style="height: 40px;"></div>
					<div class="panel panel-default" >
                        <div class="panel-heading panel-title">
                           <table style="width: 100%;">
                                <tr>
                                    <td style="width: 4%;text-align: left;" nowrap="nowrap" >
                                    <a  class="btn btn-primary" type="button" href="${path }/tms/updateView" >返回</a></td>
                                    <td class="panel-title" style="width: 96%;text-align: center;font-weight:bold">租户扩容 -&nbsp;${tenantName}</td>
                                </tr>
                           </table>
                        </div>
                        <div class="panel-body">
                            <form id="mainForm">
                            <div class="row">
                               <div class="col-md-12">
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">租户名:</div>
                                               <input  class="form-control" type="text" id="tenantName" name="tenantName" value="${ tenantName}"  readonly/>  
                                               <input type="hidden" id="tenant_fk" name="tenant_fk" value="${tenant_fk }" />
                                           </div>
                                       </div>
                                   </div>
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">域名:</div>
                                               <input  class="form-control" type="text" id="domain" name="domain" value="${domain }"  readonly/>  
                                           </div>
                                       </div>
                                   </div> 
                               </div>
                            </div>
                            <input type="hidden" name="size" value="${size }" />
                            <c:forEach items="${applications }" var="app" varStatus="status" >
                            <div class="row">
                               <div class="col-md-12">
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">${app.name }现容器数:</div>
                                               <input  class="form-control" type="text" name="container_size_old" value="${app.container_size }"  readonly/>    
                                           </div>
                                       </div>
                                   </div> 
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">${app.name }新容器数:</div>
                                               <input type="hidden" name="appName_fk_${status.index }" value="${app.appName_fk }" />
                                               <input class="form-control container_size_new" type="text" name="container_size_${status.index }"  />    
                                           </div>
                                       </div>
                                   </div>
                               </div>
                            </div>
                            </c:forEach>
                            </form>
                            <div class="row" style="height: 100px;padding-top: 40px;">
                                <div class="col-md-12 text-center">
                                     <button type="button" class="btn btn-primary" id="submit">确定</button>
                                </div>
                            </div>
                        
                        </div><!-- /.panel-body -->
                   </div><!-- /.panel -->

				</div><!-- /.page-content -->
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>