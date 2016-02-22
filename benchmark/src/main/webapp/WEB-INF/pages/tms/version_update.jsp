<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <script src="${path }/scripts/plugins/mask/jquery.bravoui.mask.js" ></script>
    <script src="${path }/scripts/tms/version_update.js" ></script>
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
                        <li><a href="${path}/tms/versionControl">版本控制</a></li>
                        <li class="active">更新版本信息</li>
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
                                    <td class="panel-title" style="width: 95%;text-align: center;font-weight:bold">更新版本信息</td>
                                </tr>
                           </table>
                        </div>
                        <div class="panel-body">
                        <form id="updateForm" enctype="multipart/form-data">
                            <div class="row">
                               <div class="col-md-12">
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">祺鲲产品:</div>
                                               <input  class="form-control" type="text" id="qkcp" name="qkcp" value="${qkcp}" readonly/> 
                                               <input type="hidden" id="id" name="id" value="${id}" />  
                                               <input type="hidden" id="qkcp_fk" name="qkcp_fk" value="${qkcp_fk}" />  
                                           </div>
                                       </div>
                                   </div>
                                   <div class="col-sm-6">
                                       <div class="form-group">
                                           <div class="input-group">
                                               <div class="input-group-addon">版本名称:</div>
                                               <input  class="form-control" type="text" id="version" name="version" value="${name}" readonly/> 
                                           </div>
                                       </div>
                                   </div> 
                               </div>
                            </div>
                            <div class="row" style="height: 50px;">
                               <div class="col-md-12">
                                   <div class="col-sm-6">
                                       <div class="input-group">
                                           <div class="input-group-addon">状态:</div>
                                           <select class="form-control" id="valid" name="valid">
                                                <option value="0" <c:if test="${valid eq 0 }">selected</c:if> >禁用</option>
                                                <option value="1" <c:if test="${valid eq 1 }">selected</c:if> >启用</option>
                                            </select>
                                       </div>
                                   </div> 
                                   <div class="col-sm-6">
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