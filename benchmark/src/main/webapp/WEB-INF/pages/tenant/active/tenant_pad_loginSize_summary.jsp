<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../../common/meta.jsp" />
    <jsp:include page="../../common/resources.jsp" />
    <link rel="stylesheet" type="text/css" href="${path }/css/report/summary.css" />
    <script type="text/javascript">
        $(function(){
        	var tenant_fk = "${tenant_fk}" == "" ? null : "${tenant_fk}";
            // 近30天 Pad登录分布趋势图
            var url = _path + "/report/pad/loginSize/chart";
            $("#pad_loginSize_chart").load(url,{tenant_fk:tenant_fk},function(){
                $("#pad_loginSize_report").prev().show();
            });
            
            $("#activeManager").addClass("active");
            $("#tenant").addClass("open");
            $("#tenant").addClass("active");
            
        });
    </script>
</head>
  
<body class="navbar-fixed">
    <jsp:include page="../../common/header.jsp" />
    <div class="main-container">
        <div class="main-container-inner">  
            <jsp:include page="../../common/menu.jsp" />
            
            <div class="main-content" id="mainContent">
                <div class="breadcrumbs breadcrumbs-fixed" id="breadcrumbs">
            
                    <ul class="breadcrumb">
                        <li>
                            <i class="icon-home home-icon"></i>
                            <a href="${path}/">首页</a>
                        </li>
                        <li class="active">租户运营数据</li>
                        <li><a href="${path }/pmd/tenantManager/2/${tenant_fk}">活跃黏性阶段</a></li>
                        <li class="active">${tenantName} - Pad登录数报表</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default">
			            <div class="panel-heading panel-title">
			                <table style="width: 100%;"><tr><td style="width: 15%;text-align: left;">平台运营数据</td></tr></table>
			             </div>
			             <div class="panel-body clearfix" style="text-align: center">
			                <div style="float: left;">
			                  <a class="btn btn-primary" href="${path }/pmd/tenantManager/2/${tenant_fk}">返回</a>
			                </div>
			                <span class="text-primary" style="margin-left: -120px;">${tenantName} - Pad登录数报表</span>
			             </div>
			        </div>
			        <input type="hidden" id="position" value="summary" />
			        <input type="hidden" id="tenantId" value="${tenant_fk }" />
			        
			        <div class="row" style="width: 100%; height: 620px;margin: 0 auto;border: 1px solid #ddd;">
			            <div class="col-xs-12">
			                <div id="pad_loginSize_chart"></div>
			                <div class="container-sum" id="pad_loginSize_subitem"></div>
			            </div>
			        </div>
			        <br>
                    <div style="height: 40px;"></div>
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../../common/footer.jsp" />
</body>
</html>
