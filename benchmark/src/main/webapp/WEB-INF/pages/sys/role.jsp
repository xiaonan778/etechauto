<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <script src="${path}/scripts/common/jquery.serializeJson.js"></script>
    <script src="${path }/scripts/sys/role.js"></script>
    <style>
      .row {
          margin: 0px;
      }
      .form-control label {
          padding-right: 25px;
      }
    </style>
    <script type="text/javascript">
	    $(function(){
	    	 $("#sys_config").parent().addClass("active");
	    });
    </script>
</head>
  
<body>
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
                        <li class="active">角色权限</li>
                    </ul>
                    <!-- .breadcrumb -->
                </div>
                
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <table style="width: 99%;">
                                <tr>
                                    <td style="width: 4%;text-align: left;" nowrap="nowrap">
                                        <a class="btn btn-primary" type="button"  href="${path }/role/list">返回</a>
                                    </td>
                                    <td class="panel-title" style="width: 96%;text-align: center;font-weight:bold">
                                        <c:if test="${action eq 'CREATE' }">新建角色</c:if><c:if test="${action eq 'EDIT' }">角色编辑</c:if><c:if test="${action eq null}">角色详情</c:if>
                                    </td>
                                </tr>
                            </table>
                            
                        </div>
                        <div class="panel-body">
                          <div class="row">
                            <form class="form" <c:if test="${action ne null }">action="${path }/role/save" method="POST"</c:if> >
                              <input type="hidden" id="id" name="id" value="${role.id }" />
                              <input type="hidden" id="dateOfCreate" name="dateOfCreate" value="<fmt:formatDate value="${role.dateOfCreate }" pattern="yyyy-MM-dd HH:mm:ss.SSS" />" />
                              <input type="hidden" id="dateOfUpdate" name="dateOfUpdate" value="<fmt:formatDate value="${role.dateOfUpdate }" pattern="yyyy-MM-dd HH:mm:ss.SSS" />" />
                              <div class="row">
                                <div class="col-md-6">
                                  <div class="form-group">
                                    <div class="input-group">
                                      <div class="input-group-addon">角色名称</div>
                                      <input class="form-control" id="name" name="name" value="${role.name }" <c:if test="${action ne 'CREATE' }">readonly</c:if> />
                                    </div>
                                  </div>
                                </div>
                                <div class="col-md-6">
                                  <div class="form-group">
                                    <div class="input-group">
                                      <div class="input-group-addon">角色状态</div>
                                      <c:if test="${action eq null }">
                                      <input class="form-control" id="status" name="status" value="<c:if test="${role.valid eq true }">启用</c:if><c:if test="${role.valid eq false }">停用</c:if>" readonly/>
                                      </c:if>
                                      <c:if test="${action eq 'CREATE' or action eq 'EDIT' }">
                                      <div class="form-control">
                                      <input type="radio" id="valid-true" name="valid" value="true" <c:if test="${role.valid eq true }">checked</c:if> /><label for="valid-true">启用</label>
                                      <input type="radio" id="valid-false" name="valid" value="false" <c:if test="${role.valid eq false }">checked</c:if> /><label for="valid-false">停用</label>
                                      </div>
                                      </c:if>
                                    </div>
                                  </div>
                                </div>
                              </div>
                              <div class="row">
                                <div class="col-md-12">
                                  <div class="form-group">
                                    <div class="input-group">
                                      <div class="input-group-addon">角色描述</div>
                                      <textarea class="form-control" id="memo" name="memo" <c:if test="${action eq null or action eq '' }">readonly</c:if> >${role.memo }</textarea>
                                    </div>
                                  </div>
                                </div>
                              </div>
                              <div class="row">
                                <div class="col-md-12 text-center">
                                  <c:if test="${action eq 'CREATE' or action eq 'EDIT' }">
                                  <input type="button" class="btn btn-primary submit" onclick="save()" value="保存" />
                                  </c:if>
                                  <input type="button" class="btn btn-primary" onclick="closePage()" value="关闭" />
                                </div>
                              </div>
                              
                            </form>
                          </div>
                        </div>
                      </div>

            </div>
            <!-- Dashboard Wrapper End -->

            <jsp:include page="../common/footer.jsp" />

        </div>
    </div>
    <!-- Main Container end -->

</body>
</html>