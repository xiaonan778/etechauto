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
    <jsp:include page="../common/resources.jsp" />
    <script src="${path }/scripts/tms/tenant_update_view.js" ></script>
    <script src="${path }/scripts/plugins/mask/jquery.bravoui.mask.js" ></script>
    <script src="${path }/scripts/plugins/datatable/jquery.bravoui.datatable.js" ></script>
    <script type="text/javascript">
        function operation(data, el) {
                var editor = "<a class=\"detail  opt\" href=\"javascript:void(0);\" ><span>详情</span></a>";
                        <% 
                            if(subject.isPermittedAll("tms:groupUpdate")) {
                        %>
                        editor = editor
                         + "<a class=\"appUpdate  opt\" href=\"javascript:void(0);\" ><span>升级</span></a>"
                         + "<a class=\"addContainer  opt\" href=\"javascript:void(0);\" ><span>扩容</span></a>"
                         + "<a class=\"appRollBack  opt\" href=\"javascript:void(0);\" ><span>回退</span></a>";
                        <% 
                         }
                        %>
                $(el).append(editor);
                $(el).find(".detail").unbind("click").click(function(){
                    window.location = _path + "/tms/" + data.id + "/appDetail";
                    
                });
                $(el).find(".appUpdate").unbind("click").click(function(){
                    if(data.status==0){
                        window.location = _path + "/tms/" + data.id + "/toAppUpdate";
                    }else{
                        alert("请先停止租户服务!");
                    }
                });
                $(el).find(".addContainer").unbind("click").click(function(){
                	if(data.status==0){
                		 window.location = _path + "/tms/" + data.id + "/toAddContainer";
                    }else{
                        alert("请先停止租户服务!");
                    }
                });
                $(el).find(".appRollBack").unbind("click").click(function(){
                    if(data.status==0){
                         window.location = _path + "/tms/" + data.id + "/toTenantVersionRollBack";
                    }else{
                        alert("请先停止租户服务!");
                    }
                });
            }
        
        
        $(function(){
        	$("#tms_update").addClass("active");
            $("#tms").addClass("open");
            $("#tms").addClass("active");
            
		    $("#status").select({
		        change: function (value, label) {},
			    width:200
		    });
        });
        
    </script>
    <style type="text/css">
      .dk_container span.dk_label{
          line-height:19px;
      }
      .dk_container{
          line-height:19px;
      }
      .opt{
          display: inline-block;
          width: 50px;
          padding: 5px;
      }
    </style>
</head>
  
<body class="navbar-fixed">
    
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
                        <li class="active">租户升级</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default">
		                 <div class="panel-heading panel-title">
		                        <table style="width: 100%;">
		                            <tr>
		                                <td style="width: 15%;text-align: left;">租户升级</td>
		                            </tr>
		                        </table>
		                 </div>
		                 <div class="panel-body">
		                     <div class="row">
		                     <form class="form searchform" role="form" id="searchform" name="searchform">
		                            <div class="row">
		                                <div class="col-md-12">
		                                    <div class="col-md-3">
		                                        <div class="form-group">
		                                            <div class="input-group">
		                                                <div class="input-group-addon">租户名</div>
		                                                <input  class="form-control" type="text" id="name" name="name"  placeholder="请输入租户名称">  
		                                            </div>
		                                        </div>
		                                    </div> 
		                                    <div class="col-md-3">
		                                        <div class="form-group">
		                                            <div class="input-group">
		                                                <div class="input-group-addon">域名</div>
		                                                <input  class="form-control" type="text" id="domain" name="domain"  placeholder="请输入域名">    
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <div class="col-md-3">
		                                        <div class="form-group">
		                                          <div class="input-group">
		                                            <div class="input-group-addon">状态</div>
		                                            <select class="form-control" id="status" name="status">
		                                                <option value="-1">全部</option>
		                                                <option value="0">停止</option>
		                                                <option value="1">启动</option>
		                                                <option value="2">异常</option>
		                                            </select>
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