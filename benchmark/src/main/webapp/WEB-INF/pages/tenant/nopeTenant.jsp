<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources.jsp" />
    <link href="${path}/css/report/tenantManager.css" rel="stylesheet">
    <script type="text/javascript">
    $(function(){
         var flag =	$("#flag").val();
	    switch(flag) {
		    case "1" : $("#tenantManager").addClass("active");break;
		    case "2" :$("#activeManager").addClass("active");break;
		    case "3":break;
		    default:break;
	    }
	     $("#tenant").addClass("open");
	     $("#tenant").addClass("active");
       
    });
    </script>
</head>
<body class="navbar-fixed">
    <jsp:include page="../common/header.jsp" />
    <div class="main-container">
        <div class="main-container-inner">  
            <jsp:include page="../common/menu.jsp" />
            <input type="hidden" id="flag" value="${flag}">
            <div class="main-content" id="mainContent">
                <div class="breadcrumbs" id="breadcrumbs">       
				    <ul class="breadcrumb">
				        <li>
				            <i class="icon-home home-icon"></i>
				            <a href="${path}/">首页</a>
				        </li>
				        <li class="active">租户运营数据</li>
				        <c:if test="${flag eq '1'}"><li class="active">拉新阶段</li></c:if>
				        <c:if test="${flag eq '2'}"><li class="active">活跃黏性阶段</li></c:if>
				        <c:if test="${flag eq '3'}"><li class="active">活动运营阶段</li></c:if>
				    </ul><!-- .breadcrumb -->
				</div>
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12 text-center">
						    <h1>暂无租户</h1>
						</div>
					</div>
	
            </div><!-- /.main-content -->
            
        </div>
        
    </div><!-- /.main-container-inner -->
    </div>
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>
       