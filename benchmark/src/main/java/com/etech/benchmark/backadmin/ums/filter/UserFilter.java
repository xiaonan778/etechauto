package com.etech.benchmark.backadmin.ums.filter;



import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.springframework.beans.factory.annotation.Autowired;

import com.etech.benchmark.backadmin.ums.service.UserService;
import com.etech.benchmark.constant.Constants;
import com.etech.benchmark.data.ums.model.User;
import com.etech.benchmark.util.ValidateUtils;


public class UserFilter extends PathMatchingFilter {

    @Autowired
    private UserService userService;

    @Override
    protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        Subject currentUser =SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        if(ValidateUtils.isEmpty(session.getAttribute(Constants.CURRENT_USER))){
            String account = (String) SecurityUtils.getSubject().getPrincipal();
            User user = userService.getByUsername(account, 1);
            session.setAttribute(Constants.CURRENT_USER, user);
            session.setAttribute("userId", user.getId());
        }
        return true;
    }
}
