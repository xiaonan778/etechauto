<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources2.jsp" />
    
    <link rel="stylesheet" href="${path}/resources/easyui/themes/bootstrap/combo.css" />
    <link rel="stylesheet" href="${path}/resources/easyui/themes/bootstrap/combobox.css" />
    <link rel="stylesheet" href="${path}/resources/easyui/themes/bootstrap/tree.css" />
    <script src="${path}/resources/easyui/js/jquery.easyui.min.js"></script>
    
    <script src="${path}/scripts/info/tree_edit.js" ></script>
    
    <script type="text/javascript" >
       $(function(){
           $("#sys_import").parent().addClass("active");
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
                                    <td style="width: 4%;text-align: left;">
                                       <a class="btn btn-primary" type="button" href="${path}/info/toTree">返回</a>
                                    </td>
                                    <td class="panel-title" style="width: 96%;text-align: center;font-weight:bold">新增车型</td>
                                </tr>
                            </table>
                        </div>
                        <div class="panel-body">
                            <form id="tree_edit_form" class="form" style="height: 550px; width: 90%;margin-top: 20px;">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <div class="input-group-addon">车型名称</div>
                                                    <input class="form-control" type="text" id="name" name="name" value="${tree.name }" >
                                                    <input type="hidden" name="id" value="${tree.id }" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                               <div class="form-group">
                                                   <div class="input-group">
                                                       <div class="input-group-addon">排序</div>
                                                       <input class="form-control" type="text" id="sorter" name="sorter" value="${tree.sorter }">
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
                                                       <div class="input-group-addon">是否为顶层分类</div>
                                                       <select class="form-control" id="level" name="level" style="width:300px;" >
                                                          <option value="1" <c:if test="${tree.level == 1 }">selected</c:if> >是</option>
                                                          <option value="-1" <c:if test="${tree.level != 1 }">selected</c:if> >否</option>
                                                       </select>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-md-6">
                                               <div class="form-group" id="parents_select" style="visibility: hidden;" >
                                                   <div class="input-group">
                                                       <div class="input-group-addon">父级分类</div>
                                                       <input class="form-control easyui-combotree" type="text" id="parent_fk" name="parent_fk" style="width:300px;height:35px;" value="${tree.parent_fk }" />
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
            <!-- Dashboard Wrapper End -->
            <jsp:include page="../common/footer2.jsp" />
         </div>
     </div>
    <!-- Main Container end -->
    
</body>

</html>
