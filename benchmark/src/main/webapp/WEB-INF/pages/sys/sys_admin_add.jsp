<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources2.jsp" />
    <script src="${path }/scripts/sys/sys_admin_add.js"></script>
    <script type="text/javascript">
	    $(function(){
	        $("#sys_config").parent().addClass("active");
	    });
    </script>
</head>
  
<body>
    <jsp:include page="../common/header2.jsp" />

    <!-- Main Container start -->
    <div class="dashboard-container">

        <div class="container">

            <jsp:include page="../common/menu2.jsp" />

            <!-- Dashboard Wrapper Start -->
            <div class="dashboard-wrapper">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <table style="width: 99%;">
                                <tr>
                                    <td style="width: 4%;text-align: left;" nowrap="nowrap"><a
                                        class="btn btn-primary" type="button"
                                        href="${path }/sys/admin/list">返回</a></td>
                                    <td class="panel-title"
                                        style="width: 96%;text-align: center;font-weight:bold">新增用户</td>
                                </tr>
                            </table>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <form id="user_add_form" class="form">
                                    <div class="col-md-12">
                                        <p class="bg-success subHeader">基本信息：</p>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">&nbsp;姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;</div>
                                                        <input class="form-control" type="text" id="realname"
                                                            name="realname" placeholder="请输入姓名">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        性&nbsp;&nbsp;别&nbsp;&nbsp;&nbsp;&nbsp; <label
                                                            class="radio-inline radioList-horizontal-first"> <input
                                                            type="radio" name="sex" id="sex0" value="0"
                                                            checked="checked"> 男 </label> <label class="radio-inline">
                                                            <input type="radio" name="sex" id="sex1" value="1">
                                                            女 </label>
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
                                                        <div class="input-group-addon">手机号码</div>
                                                        <input class="form-control" type="text" id="phone"
                                                            name="phone" placeholder="请输入手机号码">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">电子邮箱</div>
                                                        <input class="form-control" type="text" id="email"
                                                            name="email" placeholder="请输入电子邮箱">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 生效和过期时间 -->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-6">
                                            
                                             <div class="form-group">
                                                  <div class="input-group date form_datetime " data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input1">
                                                         <span class="input-group-addon"><span class="glyphicon glyphicon-th hidden"></span><span>生效时间</span></span>
                                                            <input class="form-control" size="16" type="text" value="" id="dateEffect" name="dateEffect" placeholder="请选择时间" readonly>
                                                        </div>
                                                        <input type="hidden" id="dtp_input1" value="" /><br/>
                                                </div>
                                                
                                            </div>
                                            <div class="col-md-6">
                                                 <div class="form-group">
                                                  <div class="input-group date form_datetime "  data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input1">
                                                         <span class="input-group-addon"><span class="glyphicon glyphicon-th hidden"></span><span>过期时间</span></span>
                                                            <input class="form-control" size="16" type="text" value="" id="dateExpire" name="dateExpire" placeholder="请选择时间" readonly>
                                                        </div>
                                                        <input type="hidden" id="dtp_input1" value="" /><br/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-12">
                                        <p class="bg-success subHeader">账号信息：</p>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <!-- 账号 -->
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">&nbsp;账&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号&nbsp;</div>
                                                        <input class="form-control" type="text" id="username"
                                                            name="username">
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <!-- 登录密码 -->
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">登录密码</div>
                                                        <input class="form-control" type="password" id="password"
                                                            name="password" placeholder="5-15位，支持字母、数字和符号，字母区分大小写">
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            
                                            <!-- 确认密码-->
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">确认密码</div>
                                                        <input class="form-control" type="password"
                                                            id="confirmPassword" name="confirmPassword"
                                                            placeholder="请再输一次刚输入的登录密码，确保两次输入一致">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <!-- 账号状态 -->
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        账号状态&nbsp; <label
                                                            class="radio-inline radioList-horizontal-first"> <input
                                                            type="radio" name="status" value="1" checked="checked">
                                                            启用 </label> <label class="radio-inline"> <input
                                                            type="radio" name="status" value="0"> 停用 </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
    
                                    <div class="text-center">
                                        <button type="button" class="btn btn-primary"
                                            onclick="addUser(2)">保存并新增</button>
                                        <button type="button" class="btn btn-primary"
                                            onclick="addUser(1)">保存</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                
            </div>
            <!-- Dashboard Wrapper End -->

            <jsp:include page="../common/footer2.jsp" />

        </div>
    </div>
    <!-- Main Container end -->


</body>
</html>
