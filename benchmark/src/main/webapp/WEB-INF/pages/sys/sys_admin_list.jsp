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
         $("#sys_config").parent().addClass("active");
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
  
<body >
    <jsp:include page="../common/header.jsp" />

    <!-- Main Container start -->
    <div class="dashboard-container">

        <div class="container">

            <jsp:include page="../common/menu.jsp" />

            <!-- Dashboard Wrapper Start -->
            <div class="dashboard-wrapper">
                    
                    <div class="breadcrumbs" id="breadcrumbs">
                        <ul class="breadcrumb">
                            <li><i class="icon-home home-icon"></i> <a href="${path}/">首页</a></li>
                            <li class="active">设置</li>
                            <li class="active">账号管理</li>
                        </ul>
                        <!-- .breadcrumb -->
                    </div>
                    
                    <div class="panel panel-default">
                         <div class="panel-heading panel-title">
                              <div class="row">
                                    <div class="col-xs-6 text-left"> 账号管理</div>
                                    <div class="col-xs-6 text-right">
                                        <shiro:hasPermission name="sys.administrator:create">                 
			                                 <a type="button" class="btn btn-primary" href="${path}/sys/admin/toSysAdminAdd" >新增用户</a>
					                    </shiro:hasPermission>   
                                    </div>
                              </div>
                         </div>
                         <div class="panel-body">
                             <div class="row">
                             <form class="form searchform"  id="searchform" name="searchform">
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
                    
                    <div class="row" style="margin-top:5px;">
                        <div class="col-xs-12">
                                <table id="tp" class="table table-striped table-hover table-bordered table-responsive">                
                                </table>
                        </div>
                    </div><!--/row-->
                

            </div>
            <!-- Dashboard Wrapper End -->

            <jsp:include page="../common/footer.jsp" />

        </div>
    </div>
    <!-- Main Container end -->

</body>
</html>
