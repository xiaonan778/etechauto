<%@ page language="java" pageEncoding="UTF-8"%>
<!-- Header Start -->
<header>
  <a href="${path}/" class="logo">
    <span><i class="fa fa-cloud"></i> Bench Mark</span>
  </a>
  <div class="pull-right">
    <ul id="mini-nav" class="clearfix">
      <li class="list-box user-profile">
        <a id="drop7" href="#"  class="dropdown-toggle user-avtar" data-toggle="dropdown">
          <img src="${path }/images/user.png" alt="" />&nbsp;&nbsp;您好，<%=request.getUserPrincipal()%>！&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-caret-down"></i>
        </a>
        <ul class="dropdown-menu server-activity">
          <li>
            <a href="${path}/logout"><i class="fa fa-power-off text-info"></i> 退出登录</a>
          </li>
        </ul>
      </li>
    </ul>
  </div>
</header>
<!-- Header End -->