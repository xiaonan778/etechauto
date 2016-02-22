<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<div>
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>${datatime }，使用时间最长范围为</span><span class="sum-important">${max_duration_range }</span>
    <span>，为</span><span class="sum-important">${max_duration_size }</span>台，
    <span>使用时间最短范围为</span><span class="sum-important">${min_duration_range }</span>
    <span>，为</span><span class="sum-important">${min_duration_size }</span>台。            
    </p>
</div>

		