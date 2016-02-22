<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../../common/meta.jsp" />
    <jsp:include page="../../common/resources.jsp" />
    <link rel="stylesheet" type="text/css" href="${path }/css/report/summary.css" />
    <link rel="stylesheet" type="text/css" href="${path}/css/report/chart.css">
    <script src="${path }/scripts/platform/active/pad_tenant_frequency_chart.js" ></script>
    <script src="${path }/scripts/platform/active/pad_tenant_frequencies_chart.js" ></script>
    <script type="text/javascript">
        $(function(){
            // Pad 使用频次
            var url = _path + "/report/pad/frequency/chart";
            $("#pad_frequency_chart").load(url,function(){
                 $("#pad_frequency_report").prev().show();
            });
            var url1 = _path + "/report/pad/frequency_sum_subitem";
            $("#pad_frequency_subitem").load(url1);
            
            // Pad访问页数
            var url2 = _path + "/report/pad/visitPage/chart";
            $("#pad_visitPage_chart").load(url2);
            var url2 = _path + "/report/pad/visitPage/subitem";
            $("#pad_visitPage_subitem").load(url2);
            
            // Pad使用间隔
            var url3 = _path + "/report/pad/useInterval/chart";
            $("#pad_useInterval_chart").load(url3);
            var url31 = _path + "/report/pad/useInterval/subitem";
            $("#pad_useInterval_subitem").load(url31);
            
            $("#goback").click(function(){
                window.history.back();
            });
            
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
                        <li class="active">Pad使用频次报表</li>
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
			                <span class="text-primary" style="margin-left: -120px;">Pad使用频次报表</span>
			             </div>
			        </div>
			        <input type="hidden" id="position" value="summary" />
			        <div class="row" style="width: 100%; height: 600px;margin: 0 auto;border: 1px solid #ddd;">
			            <div class="col-xs-12">
			                <div id="pad_frequency_chart"></div>
			                <div class="container-sum" id="pad_frequency_subitem"></div>
			            </div>
			        </div>
			        <br>
			        <div class="row" style="width: 100%; height: 600px;margin: 0 auto;border: 1px solid #ddd;">
			            <div class="col-xs-12">
			                <div id="pad_visitPage_chart"></div>
			                <div class="container-sum" id="pad_visitPage_subitem"></div>
			            </div>
			        </div>
			        <br>
			        <div class="row" style="width: 100%; height: 600px;margin: 0 auto;border: 1px solid #ddd;">
			            <div class="col-xs-12">
			                <div id="pad_useInterval_chart"></div>
			                <div class="container-sum" id="pad_useInterval_subitem"></div>
			            </div>
			        </div>
			        <br/>
			        <div class="row" style="width: 100%; display:none;height: 650px;margin: 0 auto;border: 1px solid #ddd;"  >
			            <div class="col-xs-12">
			                <div id="pad_tenant_frequency_chart"></div>
			                <div class="container-sum" id="pad_tenant_frequency_sum"></div>
			            </div>
			        </div>
			        <div class="row" style="width: 100%;height: 650px;margin: 0 auto;border: 1px solid #ddd;"  >
			            <div class="col-xs-12">
			                <div id="pad_tenant_frequencies_chart"></div>
			                <div class="container-sum" id="pad_tenant_frequencies_sum"></div>
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
