<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <script src="${path }/scripts/pbr/operate_log_list.js" ></script>
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
	    .words-break {
	       min-width: 200px;
	       word-wrap: break-word;
	       word-break:break-all;
	    }
    </style>
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
                        <li class="active">运维日志</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default">
	                    <div class="panel-heading panel-title">
	                        <table style="width: 100%;">
	                            <tr>
	                                <td style="width: 15%;text-align: left;">操作日志</td>
	                                <td style="width: 10%;text-align: right;" nowrap="nowrap"></td>
	                            </tr>
	                        </table>
	                    </div>
	                    <div class="panel-body">
	                       <div class="row">
	                          <form class="form searchform" role="form" id="searchform" name="searchform">
	                            <div class="row">
	                                <div class="col-md-12">
	                                    <div class="col-md-4">
	                                        <div class="form-group">
	                                            <div class="input-group">
	                                                <div class="input-group-addon">租户名</div>
	                                                <input  class="form-control" type="text" id="tenantName" name="tenantName"  placeholder="请输入租户名称">  
	                                            </div>
	                                        </div>
	                                    </div> 
	                                    <div class="col-md-4">
	                                        <div class="form-group">
	                                            <div class="input-group">
	                                                <div class="input-group-addon">域名</div>
	                                                <input  class="form-control" type="text" id="domain" name="domain"  placeholder="请输入域名">    
	                                            </div>
	                                        </div>
	                                    </div>
	<!--                                    <div class="col-md-3">
	                                        <div class="form-group">
	                                            <div class="input-group">
	                                                <div class="input-group-addon">标题</div>
	                                                <input  class="form-control" type="text" id="title" name="title"  placeholder="请输入标题">  
	                                            </div>
	                                        </div>
	                                    </div> -->
	                                    <div class="col-md-4">
	                                        <div class="form-group">
	                                            <div class="input-group">
	                                                <div class="input-group-addon">内容</div>
	                                                <input  class="form-control" type="text" id="content" name="content"  placeholder="请输入内容">  
	                                            </div>
	                                        </div>
	                                    </div>
	                                    <div class="text-center">
	                                        <input type="button" id="searchButton" class="btn btn-large btn-primary" value="搜索"/>
	                                        <input type="button" id="resetButton" class="btn btn-primary" value="重置" />
	                                   </div>
	                                </div>
	                              </div>
	                           </form>
	                        </div>
	                    </div>
		            </div>
		            <div class="row">
		                <div class="col-xs-12">
		                        <table id="tp" class="table table-striped table-hover table-bordered table-responsive">                
		                        </table>
		                </div>
		            </div><!--/row-->
                    
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>