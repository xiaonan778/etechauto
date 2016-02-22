<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <title>租户配置更新</title>
    <jsp:include page="../common/resources.jsp" />
    
    <link rel="stylesheet" type="text/css" href="${path }/resources/iCheck/skins/all.css" />
    <script src="${path }/resources/iCheck/icheck.min.js"></script>
    <script src="${path }/scripts/tms/tenant_config_edit.js" ></script>
    <script type="text/javascript">
        $(function(){
            $("#tms_list").addClass("active");
            $("#tms").addClass("open");
            $("#tms").addClass("active");
            
            $("input[type='checkbox']").iCheck({
                checkboxClass: 'icheckbox_flat-blue',
                increaseArea: '20%' // optional
            });
        });
    </script>
</head>
  
<body class="navbar-fixed">
    <button class="btn" data-toggle="modal" data-target="#modal" id="openModal" style="display: none;"></button>
    <!-- 模态框（Modal） -->
	<div class="modal fade" id="modal" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog">
	       <div class="modal-content" style="margin-top: 150px;border-radius: 4px;">
             <div class="modal-header">
                <h2 class="modal-title" id="myModalLabel"></h2>
             </div>
             <div class="modal-body" >
                <h4 id="modalBody"></h4>
             </div>
          </div><!-- /.modal-content -->
	    </div>
	</div><!-- /.modal -->
    
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
                        <li><a href="${path}/tms/list">租户清单</a></li>
                        <li class="active">租户配置更新</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default">
			            <div class="panel-heading">
			                <table style="width: 99%;">
			                    <tr>
			                        <td style="width: 4%;text-align: left;" nowrap="nowrap" >
			                        <a  class="btn btn-primary" type="button" href="${path }/tms/list" >返回</a></td>
			                        <td class="panel-title" style="width: 96%;text-align: center;font-weight:bold">配置租户 &nbsp;${tenant.name}</td>
			                    </tr>
			               </table>
			            </div>
			            <div class="panel-body">
			            <div class="row">
			            <form  id="tenant_config_form" class="form" >
			            <div class="col-md-12">
			                    <p class="bg-success subHeader">数据库信息：</p>
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                          <div class="form-group">
			                            <div class="input-group">
			                                    <div class="input-group-addon">库名：</div>
			                                    <input value="${tenant.id}" type="hidden" id="tenantFk">        
			                                    <input class="form-control" value="${tenantDb.name}" type="text" id="name" name="name" readonly placeholder="请输入数据库名">                             
			                            </div>
			                          </div>
			                    </div>
			                </div>                  
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-6">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon"> 帐号：</div>
			                                <input class="form-control"  value="${tenantDb.account}"  type="text" id="account" name="account" readonly placeholder="请输入数据库账号">  
			                            </div>
			                        </div>
			                    </div>
			                    <div class="col-md-6">
			                          <div class="form-group">
			                            <div class="input-group">
			                                    <div class="input-group-addon">密码：</div>
			                                    <input class="form-control" value="${tenantDb.password}" type="text" id="password" name="password" readonly  placeholder="请输入数据库密码">        
			                            </div>
			                          </div>
			                    </div>
			                </div>                  
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-12">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <div class="input-group-addon">备注：</div>
			                                <textarea class="form-control" rows="2" id="memo" name="memo" maxlength="200">${tenantDb.memo}</textarea>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <div class="col-md-12">
			                        <p class="bg-success subHeader">屏蔽功能：</p>
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-12">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <c:forEach items="${dictionaryList}" var="dictionary">
			                                   <div style="display: inline-block">
			                                      <input type="checkbox" id="glmk-${dictionary.id}" name="glmk" value="${dictionary.id}"  <c:if test="${dictionary.valid eq 1 }"> checked </c:if>>
			                                      <span>${dictionary.name}&nbsp;&nbsp;</span>
			                                   </div>
			                                </c:forEach>
			                            </div>
			                        </div>
			                    </div>
			                </div>                  
			            </div>
			            
			<!--            <div class="col-md-12">
			                        <p class="bg-success subHeader">支付方法：</p>
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-12">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <input name="pay" type=checkbox>&nbsp;银联&nbsp;&nbsp;&nbsp;&nbsp;
			                                <input name="pay" type=checkbox>&nbsp;通联&nbsp;&nbsp;&nbsp;&nbsp;
			                                <input name="pay" type=checkbox>&nbsp;易宝&nbsp;&nbsp;&nbsp;&nbsp;
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <div class="col-md-12">
			                        <p class="bg-success subHeader">规模：</p>
			            </div>
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="col-md-12">
			                        <div class="form-group">
			                            <div class="input-group">
			                                <input name="size" type=checkbox>&nbsp;20&nbsp;&nbsp;&nbsp;&nbsp;
			                                <input name="size" type=checkbox>&nbsp;50&nbsp;&nbsp;&nbsp;&nbsp;
			                                <input name="size" type=checkbox>&nbsp;100&nbsp;&nbsp;&nbsp;&nbsp;
			                                <input name="size" type=checkbox>&nbsp;200&nbsp;&nbsp;&nbsp;&nbsp;
			                                <input name="size" type=checkbox>&nbsp;500&nbsp;&nbsp;&nbsp;&nbsp;
			                                <input name="size" type=checkbox>&nbsp;1000&nbsp;&nbsp;&nbsp;&nbsp;
			                                <input name="size" type=checkbox>&nbsp;自定义
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div> -->
			             <div class="text-center">
			                <button type="button" class="btn btn-primary" onclick="editConfig();">保存</button>
			            </div>
			              </form>
			            </div>             
			         </div>    
			        </div>
                    
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>