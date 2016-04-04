<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
    <jsp:include page="../common/meta.jsp" />
    <jsp:include page="../common/resources2.jsp" />
	<link rel="stylesheet" type="text/css" href="${path }/resources/bootstrap/3.3.0/css/dataTables.bootstrap.min.css">
	<script src="${path }/resources/table/jquery.dataTables.min.js"></script>
	<script src="${path }/resources/table/dataTables.bootstrap.min.js"></script>
	<script src="${path }/resources/table/default.js"></script>
	 <style type="text/css">
     
      .opt{
          display: inline-block;
          padding: 5px;
      }
    </style>
</head>
  
<body class="navbar-fixed">
    <jsp:include page="../common/header.jsp" />
    <div class="main-container">
        <div class="main-container-inner">  
            <jsp:include page="../common/menu.jsp" />
            
            <div class="main-content" id="mainContent">
                <div class="breadcrumbs breadcrumbs-fixed" id="breadcrumbs">
            
                    <ul class="breadcrumb">
                        <li>
                            <i class="icon-home home-icon"></i>
                            <a href="${path}/">首页</a>
                        </li>
                        <li >信息分类</li>
                        <li ><a href="${path}/info/listall">信息查询</a></li>
                        <li class="active">Excel数据</li>
                    </ul><!-- .breadcrumb -->
                </div>
                <div class="page-content">
                    <div style="height: 40px;"></div>
			            <div class="row">
		                <div class="col-xs-12">
					    <table id="excel_data" class="table table-striped table-bordered" style="width:100%;" >
					        <c:forEach items="${dataList }"  var="row"  varStatus="status">
					           <c:if test="${status.index == 0}">
					               <tr>
	                                   <c:forEach items="${row }" var="cell">
	                                       <th>${cell.key }</th>
	                                   </c:forEach>
	                               </tr>
					           </c:if>
					           <tr>
					               <c:forEach items="${row }" var="cell">
					                   <td>${cell.value }</td>
					               </c:forEach>
					           </tr>
					        </c:forEach>
	                    </table>
		                </div>
		                <div id="searchText"></div>
		            </div><!--/row-->	            
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
        </div>
    </div><!-- /.main-container-inner -->
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
