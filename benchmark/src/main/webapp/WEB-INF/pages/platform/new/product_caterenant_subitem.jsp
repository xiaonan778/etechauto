<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div>
	<c:choose>  
	   <c:when test="${tenant_max_size eq 0}">  
	        <p>
		   		<img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
		   		<span>${datatime }内租户无产品发布。</span>
	   		</p>
	   </c:when>  
	   <c:otherwise>  
	   	    <p>
		    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
		    <span>${datatime }内租户发布产品数Top</span><span class="sum-important">${tenant_max_size }</span>名分别是:
		    <span class="sum-important">          
		    	${fn:substring(tenant_list, 1, fn:length(tenant_list.toString())-1)}
		    </span>；    
		    </p>
		    <p>
		    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
		    <span>Top</span><span class="sum-important">${tenant_max_size }</span>名的租户发布的理财产品主要集中在
		    <span class="sum-important">${fn:substring(product_cate_list, 1, fn:length(product_cate_list.toString())-1)}</span>类产品。
		    </p>
	   </c:otherwise>  
	</c:choose>  

</div>

		