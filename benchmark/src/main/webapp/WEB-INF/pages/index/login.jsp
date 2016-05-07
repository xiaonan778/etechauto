<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %> 
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<jsp:include page="../common/meta.jsp" />
	<title>登录</title>
	<jsp:include page="../common/resources.jsp" />
	<script src="${path }/scripts/sys/login.js" ></script>
	
	<link href="${path }/css/login.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<shiro:authenticated>
		<script>
			window.location = "<%=request.getContextPath()%>";
		</script>
	</shiro:authenticated>
	
	<div class="login-page">
	    <div class="login-main">    
	         <div class="login-head">
	                <h1>Login</h1>
	            </div>
	            <div class="login-block">
	                <c:if test="${not empty error}">
                        <div class="error alert alert-warning alert-dismissable bottom-margin">
                            ${error}
                        </div>
                    </c:if>
	                <form id="loginForm" class="form-signin"  method="post"   >
				        <fieldset>
                              <label class="block clearfix">
                                  <span class="block input-icon input-icon-right">
                                      <input type="text" class="form-control"  id="username" name="username" placeholder="请输入账号" />
                                      <i class="icon-user"></i>
                                  </span>
                              </label>
                              <label class="block clearfix">
                                  <span class="block input-icon input-icon-right">
                                      <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" />
                                      <i class="icon-lock"></i>
                                  </span>
                              </label>
                              <div class="space"></div>
                              <div class="clearfix">
	                               <button type="submit" class="btn btn-block btn-lg btn-primary"><i class="icon-key"></i>登录</button>
                              </div>
                              <div class="space-4"></div>
                          </fieldset>
	                </form>
	            </div>
	      </div>
     </div>
	
</body>
</html>
