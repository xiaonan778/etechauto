<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<div>
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>${datatime }内，平均登录Pad在</span><span class="sum-important">${loginSize_avg }</span><span>台左右；</span>
    </p>
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>${datatime }内，登录最高值为</span><span class="sum-important">${loginSize_max_date }</span>
    <span>，为</span><span class="sum-important">${loginSize_max_value }</span><span>位，</span>
    <span>最低值为</span><span class="sum-important">${loginSize_min_date }</span>
    <span>，为</span><span class="sum-important">${loginSize_min_value }</span><span>位。</span>
    </p>
</div>