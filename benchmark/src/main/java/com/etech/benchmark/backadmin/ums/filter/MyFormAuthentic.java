package com.etech.benchmark.backadmin.ums.filter;

import java.util.Date;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.log4j.Logger;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;

import com.etech.benchmark.backadmin.ums.service.UserService;
import com.etech.benchmark.data.ums.model.User;

public class MyFormAuthentic extends FormAuthenticationFilter{
	
	private static final Logger LOG = Logger.getLogger(MyFormAuthentic.class.getName()); 
    @Autowired
    private UserService userService;
	
	@Override
	protected boolean onLoginSuccess(AuthenticationToken token, Subject subject,
            ServletRequest request, ServletResponse response) throws Exception {
		
	    LOG.info(getUsername(request)+" 登录成功");
        User user = userService.getByUsername(getUsername(request), 1);
        long now = System.currentTimeMillis();
        user.setLastLoginTime(new Date(now));
        userService.update(user);
        issueSuccessRedirect(request, response);
		return false;
	}
	
	@Override
	protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e,
	              ServletRequest request, ServletResponse response) {
		LOG.error(getUsername(request)+" 登录失败,失败原因为："+e.getMessage());
		setFailureAttribute(request, e);
		//login failed, let request continue back to the login page:
		return true;
	}

}
