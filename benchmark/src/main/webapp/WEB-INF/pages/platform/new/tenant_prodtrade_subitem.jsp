<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div>
		 <c:if test="${fn:length(tenants) > 0}">
			<p>
		    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
		    <span>${datatime }内</span>
		    <c:set var="size" value="0" ></c:set>
		    <c:set var="amount" value="0" ></c:set>
   		    <c:forEach var="tenant" items="${tenants}">
   		    	<c:set var="size" value="${size+1}" ></c:set>
   		    	<c:set var="amount" value="${amount+tenant.amount}" ></c:set>
   		        <c:if test="${tenant.amount ne 0}">
   		        	购买<span class="sum-important">${tenant.prodcate }</span>类理财产品投资最多的租户是<span class="sum-important">${tenant.name }</span>
   		        	<c:choose>
	   		        <c:when test="${size eq  fn:length(tenants)}">
	   		        	;
	   		        </c:when>
	   		        <c:otherwise> 
	   		        	，
	   		        </c:otherwise>
   		        </c:choose>
   		        </c:if>
		    </c:forEach>
		    <c:if test="${amount eq 0}">无数据。</c:if>
		    </p>
		    	<c:if test="${amount > 0}">
			    <p>
			    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
			    	<c:set var="size" value="0" ></c:set>
			       	<c:forEach var="tenant" items="${tenants}">
	   		    	<c:set var="size" value="${size+1}" ></c:set>
	   		        <c:if test="${tenant.amount ne 0}">
	   		        	<span class="sum-important">${tenant.name }</span>租户购买<span class="sum-important">${tenant.prodcate }</span>类理财产品交易金额为
	   		        	<span class="sum-important">${tenant.amount }</span>万元
	   		        	<c:choose>
		   		        <c:when test="${size eq  fn:length(tenants)}">
		   		        	。
		   		        </c:when>
		   		        <c:otherwise> 
		   		        	，
		   		        </c:otherwise>
	   		        </c:choose>
	   		        </c:if>
			    </c:forEach>
			    </p>
			    </c:if>
		   </c:if>
</div>

		