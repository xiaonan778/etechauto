<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<div>
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>${datatime }，最高使用频次范围为</span><span class="sum-important">${max_frequency_range }</span>
    <span>次，为</span><span class="sum-important">${max_frequency_size }</span>台，
    <span>最低使用频次范围为</span><span class="sum-important">${min_frequency_range }</span>
    <span>次，为</span><span class="sum-important">${min_frequency_size }</span>台。            
    </p>
</div>

		