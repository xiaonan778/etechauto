<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <title>租户总览</title>
    <jsp:include page="../common/resources.jsp" />
    <script src="${path }/scripts/tms/tenant_view.js" ></script>
    <script src="${path }/scripts/plugins/mask/jquery.bravoui.mask.js" ></script>
    <script src="${path }/scripts/plugins/datatable/jquery.bravoui.datatable.js" ></script>
    <style type="text/css">
        .radioList-horizontal{
            text-align:right;
        }
        
        .radioList-horizontal-first{
            margin-left:10px;
        }
        
        .ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset{ 
            text-align: center 
         }
         
        .inlineWrap{
	        margin-top:10px;
	        margin-bottom:10px;
	    }
    </style>
    <script type="text/javascript">
        $(function(){
        	$("#tms_view").addClass("active");
            $("#tms").addClass("open");
            $("#tms").addClass("active");
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
                        <li class="active">租户管理</li>
                        <li class="active">租户总览</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    <div style="height: 40px;"></div>
		            <div class="panel panel-default">
		                <div class="panel-heading panel-title">
		                   <table style="width: 100%;"><tr><td style="width: 15%;text-align: left;">租户总览</td>
		                   <td style="width: 10%;text-align: right;" nowrap="nowrap" ></td></tr></table>
		                </div>
		                <div class="panel-body">
		                    <div class="row">
		                       <div class="col-md-12">
		                           <div class="col-md-2">
		                               <div class="form-group">
		                                   <div class="input-group">
		                                       <div class="input-group-addon">租户总数:</div>
		                                       <input  class="form-control" type="text" id="countNum" name="countNum"  readonly/>  
		                                   </div>
		                               </div>
		                           </div>
		                           <div class="col-md-2">
		                               <div class="form-group">
		                                   <div class="input-group">
		                                       <div class="input-group-addon">正常租户:</div>
		                                       <input  class="form-control" type="text" id="normal" name="normal"  readonly/>  
		                                   </div>
		                               </div>
		                           </div> 
		                           <div class="col-md-2">
		                               <div class="form-group">
		                                   <div class="input-group">
		                                       <div class="input-group-addon">异常租户:</div>
		                                       <input  class="form-control" type="text" id="abnormalNum" name="abnormalNum"  readonly/>    
		                                   </div>
		                               </div>
		                           </div> 
		                           <div class="col-md-2">
		                               <div class="form-group">
		                                   <div class="input-group">
		                                       <div class="input-group-addon">服务启动:</div>
		                                       <input  class="form-control" type="text" id="startNum" name="startNum"  readonly/>  
		                                   </div>
		                               </div>
		                           </div> 
		                           <div class="col-md-2">
		                               <div class="form-group">
		                                   <div class="input-group">
		                                       <div class="input-group-addon">服务停止:</div>
		                                       <input  class="form-control" type="text" id="shutdownNum" name="shutdownNum"  readonly/>    
		                                   </div>
		                               </div>
		                           </div>  
		                       </div>
		                    </div>
		                </div>
		           </div>
		           <div class="row">
		               <div class="col-xs-12">
		                    <table id="tp" class="table table-striped table-hover table-bordered table-responsive"></table>
		               </div>
		           </div><!--/row-->
		           
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>