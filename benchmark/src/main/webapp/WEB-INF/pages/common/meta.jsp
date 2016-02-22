<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  request.setAttribute("path", path);
%>
	    <meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta name="description" content="">
	    <meta name="author" content="">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<!-- 禁止页面缓存 -->
	    <meta http-equiv="pragram" content="no-cache">
	    <meta http-equiv="Cache-Control" content="no-cache">
	    <meta http-equiv="expires" content="0">
        <link rel="icon" href="${path }/images/favicon.ico" type="image/x-icon">  
        <link rel="shortcut icon" href="${path }/images/favicon.ico" type="image/x-icon">
         
		<title><c:if test="${title eq null }">BM</c:if><c:if test="${title ne null }">${title }</c:if></title>
		
        <c:if test="${editable eq null }">
          <c:set var="editable" value="false" />
        </c:if>
        
		<script>
			_path = "${path }";
			_editable = ${editable == null ? false : editable };
		</script>