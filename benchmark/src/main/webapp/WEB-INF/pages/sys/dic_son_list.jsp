<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources2.jsp" />
    <script>
        function operation(data, el) {
        
                // -------------------------------------------------------------------------------------------------------------------------------------------------------
                $editor = $("<a class=\"edit\" href=\"javascript:void(0);\"><span>编辑</span></a>");
                $(el).append($editor);
                $(el).find(".edit").unbind("click").click(function() {
                    window.location = _path + "/dic/" + data.id + "/sonedit";
                });
                
            }
        
        $(function(){
        	$("#sys_config").parent().addClass("active");
        });
    </script>
    <script src="${path }/scripts/sys/dic_son_list.js"></script>
    <script src="${path }/scripts/plugins/datatable/jquery.bravoui.datatable.js"></script>
    
    <style>
        .operation-column a {
          padding-right: 10px;
        }
        
        .panel-body .row {
          margin: 0px;
        }
        
        .action-bar {
          margin: 5px 0px;
        }
    </style>
</head>
  
<body >

    <jsp:include page="../common/header2.jsp" />

    <!-- Main Container start -->
    <div class="dashboard-container">

        <div class="container">

            <jsp:include page="../common/menu2.jsp" />

            <!-- Dashboard Wrapper Start -->
            <div class="dashboard-wrapper">


                    <input type="hidden" value="${sysdata.id}" id="father"/>
                    <div class="panel panel-default">
                        <div class="panel-heading panel-title">
                            <table style="width: 100%;">
                            <tr>
                                <td style="width: 4%;text-align: left;" >
                                <a  class="btn btn-primary" type="button" href="javascript:window.history.back();" >返回</a></td>
                                <td class="panel-title" style="width: 96%;text-align: center;font-weight:bold">${sysdata.code}&nbsp;${sysdata.name}</td>
                            </tr></table>
                         </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-right action-bar">
                          <input type="button" class="btn btn-large btn-primary add-data" value="新增数据" /> 
                        </div>
                    </div>
                  
                    <div class="row">
                        <div class="col-xs-12">
                          <table id="tp" class="table table-striped table-hover table-bordered table-responsive" style="wigth:100%">
                          </table>
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