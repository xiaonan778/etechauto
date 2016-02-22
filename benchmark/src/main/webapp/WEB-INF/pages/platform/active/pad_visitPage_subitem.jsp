<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<div>
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>${datatime }，访问页数最多的为</span><span class="sum-important">${max_visitPage_range }</span>
    <span>页，共有</span><span class="sum-important">${max_visitPage_size }</span><span>台；</span>
    <span>访问最少的为</span><span class="sum-important">${min_visitPage_range }</span>
    <span>页，共有</span><span class="sum-important">${min_visitPage_size }</span><span>台。</span>          
    </p>
</div>

		