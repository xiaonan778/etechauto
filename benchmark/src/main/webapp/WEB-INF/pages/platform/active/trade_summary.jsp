<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../../common/meta.jsp" />
    <jsp:include page="../../common/resources.jsp" />
    <script src="${path}/resources/plugins/datetime/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="${path}/resources/reveal/jquery.reveal.js" ></script>
    <link rel="stylesheet" type="text/css" href="${path }/css/report/summary.css" />
    <script src="${path }/scripts/platform/active/trade_summary.js" ></script>
    <script src="${path }/scripts/platform/active/trade_order_pay_chart.js" ></script>
    
    <script type="text/javascript">
        $(function(){
            
            $("#pmd_new_phase_2").addClass("active");
            $("#pmd").addClass("open");
            $("#pmd").addClass("active");
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
                        <li class="active">平台运营数据</li>
                        <li><a href="${path }/pmd/view/2">活跃黏性阶段</a></li>
                        <li class="active">产品交易报表</li>
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
			                    <button class="btn btn-primary" type="button" id="goback">返回</button>
			                </div>
			                <span class="text-primary" style="margin-left: -120px;">产品交易报表</span>
			             </div>
			        </div>
			        <input type="hidden" id="position" value="summary" />
			        <div class="row" style="width: 100%;height: 620px; margin: 0 auto;border: 1px solid #ddd;">
			            <div class="col-xs-12">
			                <div id="trade_trend_chart"></div>
			                <div class="container-sum" id="trade_trend_subitem"></div>
			            </div>
			        </div>
			        <br/>
			        <div class="row" style="width: 100%; height: 650px;margin: 0 auto;border: 1px solid #ddd;">
			            <div class="col-xs-12">
			                <div id="trade_order_pay_chart"></div>
			                <div class="container-sum" id="trade_order_pay_conclusion"></div>
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