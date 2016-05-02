<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
  import="org.apache.shiro.SecurityUtils"
  import="org.apache.shiro.subject.Subject"
%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%  
    Subject subject = SecurityUtils.getSubject();
%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <script src="${path }/scripts/sys/sys_admin_list.js" ></script>
    <script src="${path }/scripts/plugins/datatable/jquery.bravoui.datatable.js" ></script>
    <script>
    function operation (data, el) {
        <% 
        if(subject.isPermittedAll("sys.administrator:read")) {
        %>
        var $editor= $("<a class=\"detail\" href=\"javascript:void(0);\"><span>详情</span></a>&nbsp;&nbsp;&nbsp;&nbsp;");
        $(el).append($editor);
        $(el).find(".detail").unbind("click").click(function(){
            window.location = _path + "/sys/admin/" + data.id+"/toSysAdminDetail";
        });
        <% 
        }
        if(subject.isPermittedAll("sys.administrator:password")) {
        %>
        $editor = $("<a class=\"change\" href=\"javascript:void(0);\"><span>改密</span></a>&nbsp;&nbsp;&nbsp;&nbsp;");
        $(el).append($editor);
        $(el).find(".change").unbind("click").click(function(){
            window.location = _path + "/sys/admin/" + data.id+"/toSysAdminPasswordChange";
        });
        <% 
        }
        if(subject.isPermittedAll("sys.administrator:update")) {
        %>
        $editor = $("<a class=\"edit\" href=\"javascript:void(0);\"><span>编辑</span></a>");
        $(el).append($editor);
        $(el).find(".edit").unbind("click").click(function(){
            window.location = _path + "/sys/admin/" + data.id+"/toSysAdminEdit";
        });
        <% 
        }
        %>
    }
    
    $(function(){
        $("#sys_admin").addClass("active");
        $("#sys").addClass("open");
        $("#sys").addClass("active");
    });
    </script>
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
        .table-operation-column a {
          padding-right: 10px;
        }
    </style>
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
                        <li class="active">系统管理员</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default">
		                 <div class="panel-heading panel-title">新增用户</div>
		                 <div class="panel-body">
		                     <div class="row">
		                     <form class="form searchform" role="form" id="searchform" name="searchform">
		                            <div class="row">
		                                <div class="col-md-12">
		                                
		                                    <div class="col-md-3">
		                                        <div class="form-group">
		                                            <div class="input-group">
		                                                <div class="input-group-addon">帐号</div>
                                                        <input class="form-control" type="text" id="username" name="username"  placeholder="请输入帐号">
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <div class="col-md-3">
		                                        <div class="form-group">
		                                            <div class="input-group">
		                                                <div class="input-group-addon">姓名</div>
		                                                <input  class="form-control" type="text" id="realname" name="realname"  placeholder="请输入姓名">    
		                                            </div>
		                                        </div>
		                                    </div> 
		                                    
		                                    
		                                    <div class="text-left">
		                                        <input type="button" id="searchButton" class="btn btn-large btn-primary" value="查询"/>
		                                        <input type="button" id="resetButton" class="btn btn-primary" value="重置" />
		                                   </div>
		                                </div>
		                            </div>
		                            </form>
		                     </div>
		                 </div>
		            </div>
		            
		            <shiro:hasPermission name="sys.administrator:create">                 
		                <div class="row">
		                  <div class="col-md-12 text-right action-bar">
		                     <a type="button" class="btn btn-primary" href="${path}/sys/admin/toSysAdminAdd" >新增用户</a>
		                  </div>
		                </div>
		            </shiro:hasPermission>   
		            
		            
		            <div class="row" style="margin-top:5px;">
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
