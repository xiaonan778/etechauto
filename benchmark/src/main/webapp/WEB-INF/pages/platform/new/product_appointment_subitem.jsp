<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<div>
    <c:if test="${product_appointment_summary ne null and product_appointment_summary ne ''}">
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    ${product_appointment_summary }       
    </p>
    </c:if>
    <c:if test="${product_appointment_sort ne null and product_appointment_sort ne ''}">
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    ${product_appointment_sort }       
    </p>
    </c:if>
</div>