<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <script src="${path }/scripts/tms/version_add.js" ></script>
    <style type="text/css">
        .dk_fouc select {
            position: relative;
            top: 0;
            visibility: visible;
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
                        <li><a href="${path}/tms/versionControl">版本控制</a></li>
                        <li class="active">新增版本</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
					<div style="height: 40px;"></div>
					<div class="panel panel-default" >
                        <div class="panel-heading panel-title">
                           <table style="width: 100%;">
                                <tr>
                                    <td style="width: 5%;text-align: left;" >
                                        <a  class="btn btn-primary" type="button" href="${path }/tms/versionControl" >返回</a>
                                    </td>
                                    <td class="panel-title" style="width: 95%;text-align: center;font-weight:bold">新增版本</td>
                                </tr>
                           </table>
                        </div>
                        <div class="panel-body">
                        <form id="mainForm" enctype="multipart/form-data">
                            <div class="row">
                               <div class="col-md-12">
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">祺鲲产品:</div>
                                               <select  class="form-control" id="qkcp_fk" name="qkcp_fk" >
                                                    <c:forEach items="${qkcpList}" var="one" >
                                                        <option value="${one.id }">${one.name}</option>
                                                    </c:forEach>
                                               </select>
                                           </div>
                                       </div>
                                   </div>
                                   <div class="col-sm-6">
                                        <div class="form-group">
                                           <div class="input-group" style="height: 35px;">
                                               <div class="input-group-addon">版本号:</div>
                                               <c:choose>
                                                  <c:when test="${versionNames != null && versionNames.size() > 0}">
                                                  <select  class="form-control" id="version" name="version">
                                                    <c:forEach items="${versionNames}" var="one" >
                                                        <option value="${one }">${one}</option>
                                                    </c:forEach>
                                                  </select>
                                                  </c:when>
                                                  <c:otherwise>
                                                     <select  class="form-control" id="version" name="version" style="display:none;"></select>
                                                     <input id="noVersion" class="form-control" type="text" value="无可用版本"  readonly/>
                                                  </c:otherwise>
                                               </c:choose>   
                                           </div>
                                           <div id="versionError"></div>
                                       </div>
                                   </div> 
                               </div>
                            </div>
                            <div class="row">
                               <div class="col-md-12">
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">初始化SQL文件:</div>
                                               <input  class="form-control" type="file" id="createFile" name="createFile" />    
                                           </div>
                                       </div>
                                   </div> 
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">增量SQL文件:</div>
                                               <input  class="form-control" type="file" id="updateFile" name="updateFile" />    
                                           </div>
                                       </div>
                                   </div>
                               </div>
                            </div>
                            <div class="row" style="height: 100px;padding-top: 40px;">
	                            <div class="col-md-12 text-center">
	                                 <button type="button" class="btn btn-primary" id="submit">确定</button>
	                            </div>
	                        </div>
	                    </form>
                        </div>
                   </div>

				</div><!-- /.page-content -->
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>