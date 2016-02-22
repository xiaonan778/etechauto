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
    <script src="${path }/scripts/tms/tenant_appUpdate.js" ></script>
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
                        <li class="active">应用更新</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
					<div style="height: 40px;"></div>
					<div class="panel panel-default" style="height: 400px;">
                        <div class="panel-heading panel-title">
                           <table style="width: 100%;">
                                <tr>
                                    <td style="width: 4%;text-align: left;" nowrap="nowrap" >
                                    <a  class="btn btn-primary" type="button" href="${path }/tms/updateView" >返回</a></td>
                                    <td class="panel-title" style="width: 96%;text-align: center;font-weight:bold">应用更新 -&nbsp;${tenantName}</td>
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
                                               <input type="hidden" id="tenant_domain" name="tenant_domain" value="${domain }" /> 
                                           </div>
                                       </div>
                                   </div> 
                               </div>
                            </div>
                            <div class="row">
                               <div class="col-md-12">
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">当前版本号:</div>
                                               <input  class="form-control" type="text" id="version" name="version"  value="${version}" readonly/>    
                                               <input  type="hidden" id="oldVersion" name="oldVersion"  value="${oldVersion}" /> 
                                               <input  type="hidden" id="ver_value" name="ver_value"  value="${version}" /> 
                                           </div>
                                       </div>
                                   </div> 
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">上一次更新日期:</div>
                                               <input  class="form-control" type="text" id="dateOfUpdate" name="dateOfUpdate" value="${date_update }"  readonly/>    
                                           </div>
                                       </div>
                                   </div>
                               </div>
                            </div>
                            <div class="row">
                               <div class="col-md-12">
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">祺鲲产品:</div>
                                               <input  class="form-control" type="text" id="qkcp" name="qkcp" value="${qkcp }"  readonly/> 
                                               <input type="hidden" name="qkcp_fk" value="${qkcp_fk }" />   
                                           </div>
                                       </div>
                                   </div>
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">新版本号:</div>
                                               <c:choose>
                                                  <c:when test="${versions != null && versions.size() > 0}">
                                                  <select class="form-control" id="newVersion" name="newVersion">
                                                      <c:forEach items="${versions }" var="newVersion">
                                                        <option value="${newVersion.id }">${newVersion.name }</option>
                                                      </c:forEach>
                                                  </select> 
                                                  </c:when>
                                                  <c:otherwise>
                                                     <input  class="form-control" type="text" value="无可用版本"  readonly/>
                                                  </c:otherwise>
                                               </c:choose>
                                               
                                           </div>
                                       </div>
                                   </div>
                                </div>
                            </div>
                            </form>
                            <div class="row" style="height: 100px;padding-top: 40px;">
                                <div class="col-md-12 text-center">
                                     <button type="button" class="btn btn-primary" id="submit">确定</button>
                                </div>
                            </div>
                        </div><!--  /.panel-body -->
                   </div><!--  /.panel -->

				</div><!-- /.page-content -->
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>