<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <script src="${path}/scripts/sys/permission_edit.js"></script>
    <script >
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
                        <li class="active">权限管理</li>
                    </ul>
                    <!-- .breadcrumb -->
                </div>
                
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <table style="width: 99%;">
                                <tr>
                                    <td style="width: 4%;text-align: left;">
                                       <a class="btn btn-primary" type="button" href="${path}/permission/list">返回</a></td>
                                    <td class="panel-title" style="width: 96%;text-align: center;font-weight:bold">权限详情</td>
                                </tr>
                            </table>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <form id="permission_edit_form" class="form">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">权限名称</div>
                                                        <input class="form-control" type="text" id="name" name="name" value="${permission.name }" />
                                                        <input type="hidden" name="id" value="${permission.id }" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">权限代号</div>
                                                        <input class="form-control" type="text" id="code" name="code" value="${permission.code}" />
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
                                                        <div class="input-group-addon">状态</div>
                                                        <select class="form-control" id="isValid" name="isValid">
                                                            <option value="1"
                                                                <c:if test="${ permission.isValid == 1 }">selected</c:if>>启用</option>
                                                            <option value="0"
                                                                <c:if test="${ permission.isValid == 0 }">selected</c:if>>禁用</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">权限类型</div>
                                                        <select class="form-control" id="type" name="type">
                                                            <option value="0">其它</option>
                                                            <option value="1" <c:if test="${ permission.type == 1 }">selected</c:if>>菜单</option>
                                                        </select>
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
                                                        <div class="input-group-addon">备注</div>
                                                        <textArea class="form-control" id="memo" name="memo">${permission.memo }</textArea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button type="button" class="btn btn-primary" id="submit">提交</button>
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
