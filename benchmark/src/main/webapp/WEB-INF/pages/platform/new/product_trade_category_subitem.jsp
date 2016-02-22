<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<div>
    <c:if test="${product_trade_category_popular != null && product_trade_category_popular != '' }">
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>${datatime }，</span><span class="sum-important">${product_trade_category_popular}</span><span>产品比较受投资人的欢迎</span>
    <c:choose >
    <c:when test="${product_trade_category_second != null && product_trade_category_second != '' }">；</c:when>
    <c:otherwise>。</c:otherwise>
    </c:choose>
    </p>
    </c:if>
    
    <c:if test="${product_trade_category_second != null && product_trade_category_second != '' }">
        <p>
	    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
	    <span>${datatime }，</span>
	    <span class="sum-important">${product_trade_category_second }</span>
	    <span>产品投资人偏好趋势位于第二，仅次于</span><span class="sum-important">${product_trade_category_first }</span><span>理财产品。</span>
	    </p>
    </c:if>
</div>
			
