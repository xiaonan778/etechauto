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
    <script src="${path }/scripts/tms/version_control.js" ></script>
    <script src="${path }/scripts/plugins/mask/jquery.bravoui.mask.js" ></script>
    <script src="${path }/scripts/plugins/datatable/jquery.bravoui.datatable.js" ></script>
    <script type="text/javascript">
        function operation(data, el) {
                var editor = "";
                        <% 
                            if(subject.isPermittedAll("tms:editVersion")) {
                        %>
                        editor = editor
                         + "<a class=\"update  opt\" href=\"javascript:void(0);\" ><span>编辑</span></a>";
                        <% 
                         }
                        %>
                $(el).append(editor);
                $(el).find(".update").unbind("click").click(function(){
                    window.location = _path + "/tms/" + data.id + "/toUpdateVersion";
                });
            }
        
        
        $(function(){
        	$("#version_control").addClass("active");
            $("#tms").addClass("open");
            $("#tms").addClass("active");
            
		    $("#valid").select({
		        change: function (value, label) {},
			    width:200
		    });
		    $("#qkcp_fk").select({
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
                        <li class="active">版本控制</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default">
		                 <div class="panel-heading panel-title">
		                        <table style="width: 100%;">
		                            <tr>
		                                <td style="width: 25%;text-align: left;">版本控制</td>
		                                <td style="width: 75%;text-align: right;">
                                        <shiro:hasPermission name="tms:addVersion">
                                            <a type="button" class="btn btn-primary" href="${path}/tms/toAddVersion">新增版本</a>
                                        </shiro:hasPermission>
                                        </td>
		                            </tr>
		                        </table>
		                 </div>
		                 <div class="panel-body">
		                     <div class="row">
		                     <form class="form searchform" id="searchform" name="searchform">
		                            <div class="row">
		                                <div class="col-md-12">
		                                    <div class="col-md-3">
		                                        <div class="form-group">
		                                            <div class="input-group">
		                                                <div class="input-group-addon">版本名称</div>
		                                                <input  class="form-control" type="text" id="name" name="name"  placeholder="请输入版本名称">  
		                                            </div>
		                                        </div>
		                                    </div> 
		                                    <div class="col-md-3">
		                                        <div class="form-group">
		                                          <div class="input-group">
		                                            <div class="input-group-addon">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态</div>
		                                            <select class="form-control" id="valid" name="valid">
		                                                <option value="-1">全部</option>
		                                                <option value="0">停用</option>
		                                                <option value="1">启用</option>
		                                            </select>
		                                          </div>
		                                        </div>
		                                    </div>
		                                    <div class="col-md-3">
		                                       <div class="form-group">
		                                           <div class="input-group">
		                                               <div class="input-group-addon">祺鲲产品</div>
		                                               <select  class="form-control" id="qkcp_fk" name="qkcp_fk" >
		                                                    <option value="-1">全部</option> 
		                                                    <c:forEach items="${qkcpList}" var="one" >
		                                                        <option value="${one.id }">${one.name}</option>
		                                                    </c:forEach>
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