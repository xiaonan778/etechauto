<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources2.jsp" />
    <script src="${path }/scripts/sys/sys_admin_edit.js" ></script>
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
                                    <td style="width: 4%;text-align: left;" nowrap="nowrap">
                                        <a class="btn btn-primary" type="button"
                                        href="${path }/sys/admin/list">返回</a>
                                    </td>
                                    <td class="panel-title"
                                        style="width: 96%;text-align: center;font-weight:bold">系统管理员编辑</td>
                                </tr>
                            </table>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <p class="bg-success subHeader">人员信息：</p>
                                </div>
                                <form id="user_edit_form" class="form">
                                    <div class="row">
                                        <input value="${user.id }" type="hidden" id="id">
                                        <div class="col-md-12">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">&nbsp;姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;</div>
                                                        <input class="form-control" value="${user.realname }"
                                                            type="text" id="realname" name="realname">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        性&nbsp;&nbsp;别&nbsp;&nbsp;&nbsp;&nbsp; <label
                                                            class="radio-inline radioList-horizontal-first">
                                                            <input type="radio" name="sex" id="sex0" value="0"
                                                            <c:if test="${user.sex eq 0 }"> checked="checked" </c:if>>
                                                            男
                                                        </label> <label class="radio-inline"> <input type="radio"
                                                            name="sex" id="sex1" value="1"
                                                            <c:if test="${user.sex eq 1 }"> checked="checked" </c:if>>
                                                            女
                                                        </label>
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
                                                            name="phone" value="${user.phone }">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">电子邮箱</div>
                                                        <input class="form-control" type="text" id="email"
                                                            name="email" value="${user.email }">
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
                                                    <div class="input-group date form_datetime "
                                                        data-date-format="yyyy-mm-dd hh:ii:ss"
                                                        data-link-field="dtp_input1">
                                                        <span class="input-group-addon"><span
                                                            class="glyphicon glyphicon-th hidden"></span><span>生效时间</span></span>
                                                        <input class="form-control" size="16" type="text" value=""
                                                            id="dateEffect" name="dateEffect" placeholder="请选择时间"
                                                            readonly>
                                                    </div>
                                                    <input type="hidden" id="dtp_input1" value="" /><br />
                                                </div>

                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group date form_datetime "
                                                        data-date-format="yyyy-mm-dd hh:ii:ss"
                                                        data-link-field="dtp_input1">
                                                        <span class="input-group-addon"><span
                                                            class="glyphicon glyphicon-th hidden"></span><span>过期时间</span></span>
                                                        <input class="form-control" size="16" type="text" value=""
                                                            id="dateExpire" name="dateExpire" placeholder="请选择时间"
                                                            readonly>
                                                    </div>
                                                    <input type="hidden" id="dtp_input1" value="" /><br />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">&nbsp;账&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号&nbsp;</div>
                                                        <input class="form-control" type="text" id="username" name="username" value="${user.username}" disabled="disabled">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        账号状态 <label
                                                            class="radio-inline radioList-horizontal-first">
                                                            <input type="radio" name="status" value="1"
                                                            <c:if test="${user.status eq 1 }"> checked="checked" </c:if>>
                                                            启用
                                                        </label> <label class="radio-inline"> <input type="radio"
                                                            name="status" value="0"
                                                            <c:if test="${user.status eq 0 }"> checked="checked" </c:if>>
                                                            停用
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button type="button" class="btn btn-primary" onclick="updateUser()">保存</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <script>
                         Date.prototype.pattern = function(fmt) {
                             var o = {
                                 "M+" : this.getMonth() + 1, //月份          
                                 "d+" : this.getDate(), //日          
                                 "h+" : this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时          
                                 "H+" : this.getHours(), //小时          
                                 "m+" : this.getMinutes(), //分          
                                 "s+" : this.getSeconds(), //秒          
                                 "q+" : Math.floor((this.getMonth() + 3) / 3), //季度          
                                 "S" : this.getMilliseconds()
                             };
                             var week = {
                                 "0" : "\u65e5",
                                 "1" : "\u4e00",
                                 "2" : "\u4e8c",
                                 "3" : "\u4e09",
                                 "4" : "\u56db",
                                 "5" : "\u4e94",
                                 "6" : "\u516d"
                             };

                             if (/(y+)/.test(fmt)) {

                                 fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));

                             }

                             if (/(E+)/.test(fmt)) {
                                 fmt = fmt.replace(RegExp.$1,((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "\u661f\u671f"
                                                         : "\u5468")
                                                         : "")
                                                         + week[this.getDay() + ""]);

                             }

                             for ( var k in o) {

                                 if (new RegExp("(" + k + ")").test(fmt)) {

                                     fmt = fmt.replace(RegExp.$1,(RegExp.$1.length == 1) ? (o[k]): (("00" + o[k]).substr(("" + o[k]).length)));

                                 }

                             }

                             return fmt;

                         };
                         var userDateEffect = '${user.dateEffect}';
                         if (userDateEffect) {
                             var dateEffect = new Date(userDateEffect).pattern("yyyy-MM-dd hh:mm:ss");
                             $("#dateEffect").val(dateEffect);
                         }
                         var userDateExpire = '${user.dateExpire}';
                         if (userDateExpire) {
                             var dateExpire = new Date(userDateExpire).pattern("yyyy-MM-dd hh:mm:ss");
                             $("#dateExpire").val(dateExpire);
                         }
                     </script>

            </div>
            <!-- Dashboard Wrapper End -->

            <jsp:include page="../common/footer2.jsp" />

        </div>
    </div>
    <!-- Main Container end -->
    
</body>
</html>