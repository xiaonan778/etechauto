package com.etech.benchmark.backadmin.index.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.etech.benchmark.exception.DisableAccountException;

@Controller
public class IndexController {
    
    /**
     * 登录页面 及 登录失败错误返回页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/login")
    public String doLogin(HttpServletRequest request, Model model) {
        String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
        String error = null;
        if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
            error = "账号不存在,请重新输入.";
        } else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
            error = "密码错误";
        } else if (DisableAccountException.class.getName().equals(exceptionClassName)) {
            error = "账号已经被停用，请联系系统管理员";
        } else if ("jcaptcha.error".equals(exceptionClassName)) {
            error = "验证码错误";
        } else if ("jcaptcha.expired".equals(exceptionClassName)) {
            error = "验证码失效，请重新获取";
        } else if (exceptionClassName != null) {
            error = "其他错误：" + exceptionClassName;
        }
        model.addAttribute("error", error);
        return "index/login";
    }

    /**
     * 登陆成功跳转页面
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String afterLoginSuccess(HttpServletRequest request, HttpServletResponse response) {
        return "main";
    }

}
