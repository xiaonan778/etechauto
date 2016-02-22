<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../../common/meta.jsp" />
    <jsp:include page="../../common/resources.jsp" />
    <link rel="stylesheet" type="text/css" href="${path }/css/report/summary.css" />
    <script src="${path }/scripts/tenant/active/finPlanner_active_summary.js" ></script>
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
                        <li><a href="${path }/pmd/tenantManager/2/${tenantId}">活跃黏性阶段</a></li>
                        <li class="active">${tenantName } - 活跃理财师报表</li>
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
		                          <a class="btn btn-primary" href="${path }/pmd/tenantManager/2/${tenantId}">返回</a>
		                    </div>
		                    <span class="text-primary" style="margin-left: -120px;">${tenantName } - 活跃理财师报表</span>
		                 </div>
		            </div>
		            <input type="hidden" id="position" value="summary" />
		            <input type="hidden" id="tenantId" value="${tenantId }" />
		            
		            <div class="row" style="width: 100%; height: 620px;margin: 0 auto;border: 1px solid #ddd;">
		                <div class="col-xs-12">
		                    <div id="cfp_active_chart"></div>
		                    <div class="container-sum" id="cfp_active_subitem"></div>
		                </div>
		            </div>
		            <br/>
		            <div class="row" style="width: 100%; height: 650px; margin: 0 auto;border: 1px solid #ddd;">
		                <div class="col-xs-12">
		                    <div id="cfp_active_detail_chart" ></div>
		                    <div class="container-sum" id="cfp_active_detail_subitem"></div>
		                </div>
		            </div>
                    
                    <div style="height: 40px;"></div>
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    
    <jsp:include page="../../common/footer.jsp" />
</body>
</html>
