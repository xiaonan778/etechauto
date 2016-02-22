<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../../common/meta.jsp" />
    <jsp:include page="../../common/resources.jsp" />
    <link rel="stylesheet" type="text/css" href="${path }/css/report/summary.css" />
    <script src="${path }/scripts/tenant/new/investor_summary.js" ></script>
    <script src="${path }/scripts/platform/new/investor_tendency_chart.js" ></script>
    <script type="text/javascript">
        $(function(){
            $("#tenantManager").addClass("active");
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
                        <li><a href="${path }/pmd/tenantManager/1/${tenantId}">拉新阶段</a></li>
                        <li class="active">${tenantName } - 投资人报表</li>
                    </ul><!-- .breadcrumb -->
                </div>
            
                <div class="page-content">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default">
		                <div class="panel-heading panel-title">
		                    <table style="width: 100%;"><tr><td style="width: 15%;text-align: left;">租户运营数据</td></tr></table>
		                 </div>
		                 <div class="panel-body clearfix" style="text-align: center">
		                    <div style="float: left;">
		                    <a class="btn btn-primary" href="${path }/pmd/tenantManager/1/${tenantId}">返回</a>
		                    </div>
		                    <span class="text-primary" style="margin-left: -120px;">${tenantName } - 投资人报表</span>
		                 </div>
		            </div>
		            <input type="hidden" id="tenantId" value="${tenantId }" />
		            <input type="hidden" id="position" value="summary" />
		            <div class="row" style="width: 100%;height:620px;margin: 0 auto;border: 1px solid #ddd;">
		                <div class="col-xs-12" >
		                    <div id="investor_trend_chart"></div>
		                    <div class="container-sum" id="investor_trend_subitem"></div>
		                </div>
		            </div>
		            <br>
                    <div class="row" style="width: 100%;height:620px;margin: 0 auto;border: 1px solid #ddd;">
                        <div class="col-xs-12" >
                            <div id="investor_trade_chart" style="margin-top: 30px;"></div>
                            <div class="container-sum" id="investor_trade_subitem"></div>
                        </div>
                    </div>
                    <br>
                    <div class="row" style="width: 100%;margin: 0 auto;border: 1px solid #ddd;">
                        <div class="col-xs-12" >
                            <div id="investor_tendency_chart"></div>
                            <div class="container-sum" id="investor_tendency_sum"></div>
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