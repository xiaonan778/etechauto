<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<div>
    <c:if test="${product_max_count ne '0' && product_max_count ne null }">
	    <p>
	    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
	    <span>${datatime }，</span><span class="sum-important">${product_cate_max_name }</span><span>产品最多，为</span>
	    <span class="sum-important">${product_cate_max }</span>款，
	    <span class="sum-important">${product_cate_min_name }</span><span>产品最少，为</span><span class="sum-important">${product_cate_min }</span>款；
	    </p>
	    
	    <p>
	    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
	    <span>${datatime }内产品发布量最多的日期是</span><span class="sum-important">${product_max_date }</span>
	    <span>，为</span><span class="sum-important">${product_max_count }</span>款，
	    <span>最低值为</span><span class="sum-important">${product_min_date }</span>
	    <span>，为</span><span class="sum-important" >${product_min_count }</span>款。
	    </p>
    </c:if>
</div>