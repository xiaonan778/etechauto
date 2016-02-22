<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div>
	   <c:if test="${tenant_max_size ne 0}">  
	   	    <p>
		    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
		    <span>${datatime }内理财师数量排名前</span><span class="sum-important">${tenant_max_size }</span>的租户为:
		    <span class="sum-important">          
		    	${fn:substring(tenant_list, 1, fn:length(tenant_list.toString())-1)}
		    </span>；    
		    </p>
		    <p>
		    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
		    <span>Top</span><span class="sum-important">${tenant_max_size }</span>名租户的理财师合计<span class="sum-important">${cfp_size }</span>位,
		         占总数的<span class="sum-important">${cfp_ratio}</span>。
		    </p>
	   </c:if>  

</div>

		