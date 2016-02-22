<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<div>
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>${datatime }，使用间隔最多的是</span><span class="sum-important">${max_useInterval_range }</span>
    <span>，共有</span><span class="sum-important">${max_useInterval_size }</span><span>台；</span>
    <span>使用间隔最少的是</span><span class="sum-important">${min_useInterval_range }</span>
    <span>，共有</span><span class="sum-important">${min_useInterval_size }</span><span>台。</span>            
    </p>
</div>

		