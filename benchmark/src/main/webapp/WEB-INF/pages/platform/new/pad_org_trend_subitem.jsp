<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  request.setAttribute("path", path);
%>
<div>
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>Pad累计激活最多的租户是：</span><span class="sum-important">${tenant_active_pad_max_name }</span><span>，</span>
    <span>累计激活</span><span class="sum-important">${tenant_active_pad_max_value}</span><span>台Pad，</span>
    <span>占总激活数的</span><span class="sum-important">${tenant_active_pad_max_rate }</span><span>；</span>
    </p>
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>Pad累计激活最少的租户是：</span><span class="sum-important">${tenant_active_pad_min_name }</span><span>，</span>
    <span>累计激活</span><span class="sum-important">${tenant_active_pad_min_value}</span><span>台Pad；</span>
    </p>
    <p>
    <img class="sum-head" src="${path }/resources/images/sum_head.png"/><span class="sum-space"></span>
    <span>Pad下发租户中，还有</span><span class="sum-important">${tenant_not_active_pad_size }</span><span>家尚未激活使用，
	该</span><span class="sum-important">${tenant_not_active_pad_size }</span><span>家未激活Pad 数为</span><span class="sum-important">${not_active_pad_size}</span><span>台。</span>
    </p>
</div>