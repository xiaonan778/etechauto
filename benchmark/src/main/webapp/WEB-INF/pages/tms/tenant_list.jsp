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
    <script src="${path }/scripts/tms/tenant_list.js" ></script>
    <script src="${path }/scripts/plugins/mask/jquery.bravoui.mask.js" ></script>
    <script src="${path }/scripts/plugins/datatable/jquery.bravoui.datatable.js" ></script>
    <script type="text/javascript">
        function operation(data, el) {
                var editor = "<a class=\"detail opt\" href=\"javascript:void(0);\" ><span>详情</span></a>";
                        <% 
                            if(subject.isPermittedAll("tms:groupUpdate")) {
                        %>
                        editor = editor 
                         + "<a class=\"edit  opt\" href=\"javascript:void(0);\" ><span>编辑</span></a>"
                         + "<a class=\"start  opt\" href=\"javascript:void(0);\" ><span>启用</span></a>"
                         + "<a class=\"stop  opt\" href=\"javascript:void(0);\" ><span>停用</span></a>"
                         + "<a class=\"config  opt\" href=\"javascript:void(0);\" ><span>配置</span></a>"
                         + "<a class=\"sync  opt\" href=\"javascript:void(0);\" ><span>同步</span></a>";
                        <% 
                         }
                        %>
                $(el).append(editor);
                $(el).find(".detail").unbind("click").click(function(){
                    window.location = _path + "/tms/" + data.id+"/toTenantDetail";
                });
                $(el).find(".edit").unbind("click").click(function(){
                   // if(data.status == 0 ){
                        window.location = _path + "/tms/" + data.id+"/toTenantEdit";
                   // }else{
                   //     alert("请先停止租户服务!");
                   // }
                });
                $(el).find(".start").unbind("click").click(function(){
                    if(data.status==0){
                        tenantService(data,1);
                    }else if (data.status == 2){
                        alert(data.name+" 服务异常，无法进行启用操作!");
                    }else{
                    	alert(data.name+" 服务已启用!");
                    }
                });
                $(el).find(".stop").unbind("click").click(function(){
                    if(data.status==0){
                        alert(data.name+" 服务已停用!");
                    }else{
                        tenantService(data,0);
                    }
                });
                $(el).find(".config").unbind("click").click(function(){
                  // if(data.status==0){
                        window.location = _path + "/tms/" + data.id+"/toTenantConfig";
                  //  }else{
                  //      alert("请先停止租户服务!");
                  //  }
                });
                $(el).find(".sync").unbind("click").click(function(){
                	$("#myModalLabel").html("正在同步数据");
                    $("#modalBody").html("请稍后...");
                    $("#openModal").click();
                	$.ajax({
                		url : _path + "/tms/" + data.id + "/tenantSync",
                		type : "GET",
                		dataType : "json",
                		success : function (json){
                			$("#closeModal").click();
                			if (json.status == "S") {
                				bravoui.ui.msg.alert("同步成功！");
                                $(document).on("click", "#closeModal", function(){
                                    window.location.reload();
                                });
                			} else {
                				bravoui.ui.msg.alert("Internal Server Error!");
                			}
                		},
                		error : function(xhr, msg){
                			$("#closeModal").click();
                			if ("timeout" == msg || "parsererror" == msg) {
                                bravoui.ui.msg.alert("对不起，session过期，请重新登录!");
                                $(document).on("click", "#closeModal", function(){
                                    window.location.reload();
                                });
                            } else {
                            	bravoui.ui.msg.alert("Internal Server Error!");
                            }
                		}
                	});
                });
                
            }
        
        
        $(function(){
        	$("#tms_list").addClass("active");
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
                        <li class="active">租户清单</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default">
		                 <div class="panel-heading panel-title">
		                        <table style="width: 100%;">
		                            <tr>
		                                <td style="width: 15%;text-align: left;">租户清单</td>
		                                
		                                    <td style="width: 10%;text-align: right;" nowrap="nowrap">
		                                    <shiro:hasPermission name="tms:tenantAdd">
		                                    <a  type="button" class="btn btn-primary"
		                                        href="${path}/tms/toTenantAdd">新增租户</a>
		                                    </shiro:hasPermission>
		                                    </td>
		                                    
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