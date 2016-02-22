<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div>
	<c:choose>  
	   <c:when test="${total_order_size eq 0}">  
	        <p>
		   		<img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
		   		<span>${datatime }内没有下单信息!</span>
	   		</p>
	   </c:when>  
	   <c:otherwise>  
	   	    <p>
		    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
		    <span>${datatime }内共产生</span>
		    <span class="sum-important">${total_order_size }</span>笔下单，有
		    <span class="sum-important">${effective_order_size }</span>笔完成支付，累计交易金额为
		    <span class="sum-important">${effective_order_amount}</span>万元，支付转化率为
		    <span class="sum-important">${effective_order_ratio}</span>；  
		    </p>
		    <p>
		    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
		    <span>${datatime }内下单最高值为</span><span class="sum-important">${max_order_date }</span>
		    <span>，为</span><span class="sum-important">${max_order_size }</span>笔，最低值为<span class="sum-important">${min_order_date }</span>
		    <span>，为</span><span class="sum-important">${min_order_size }</span>笔。
		    </p>
	   </c:otherwise>  
	</c:choose>  

</div>

		