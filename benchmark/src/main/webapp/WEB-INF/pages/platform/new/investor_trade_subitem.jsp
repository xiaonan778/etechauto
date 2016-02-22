<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>				
<div>
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>近30天，已完成投资的人数为</span><span class="sum-important">${effective_investor_size }</span><span>位，</span>
    <span>占总投资人的</span><span class="sum-important">${effective_investor_rate }</span><span>；</span>
    </p>
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>未完成投资的投资人数为</span><span class="sum-important">${not_finished_investor_size }</span><span>位，</span>
    <span>占总投资人的</span><span class="sum-important">${not_finished_investor_rate }</span><span>。</span>
    </p>
</div>
			
			