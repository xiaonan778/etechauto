<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<div>
	<c:if test="${tenant_trade_amount ne '0'}">
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>截止昨天，目前租户累计通过Pad共产生</span><span class="sum-important">${tenant_trade_amount }万元</span><span>交易；</span>
    </p>
    
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    ${trade_over_100million}
    </p>
    </c:if>
</div>				