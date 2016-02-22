/*package com.etech.benchmark.backadmin.log;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;



@Component
@Aspect
public class LogAspect {
	
	@Autowired  
	private  HttpServletRequest req;
	
	
	private static final Logger LOG = Logger.getLogger(LogAspect.class); 
	
	@Pointcut("execution(* com.etech.benchmark.backadmin.*.service.impl.*.*(..))")
	public void pointCut() {
	}
	

	@AfterReturning(pointcut = "pointCut()", returning = "returnVal")
	public void afterReturning(JoinPoint joinPoint, Object returnVal) {
//		Loggable l = joinPoint.getClass().getAnnotation(Loggable.class);
//		System.out.println(l.value());
			try{
				LOG.setLevel(OperationLogLevel.OPERATION);
			    Object[] args = joinPoint.getArgs();
			    String inputParams ="";
				if(req!=null) {
					
					String requestType =(String)((HttpServletRequest) req).getHeader("X-Requested-With");    
			  	    if (requestType != null && requestType.equals("XMLHttpRequest")) { 
			  	    	LOG.log(OperationLogLevel.OPERATION,"the request type is AJAX:");
			  	    }else {
			  	    	LOG.log(OperationLogLevel.OPERATION,"the request type is not AJAX:");
			  	    }
			  		LOG.log(OperationLogLevel.OPERATION,"请求路径是："+((HttpServletRequest)req).getRequestURI());
			  		if(((HttpServletRequest)req).getUserPrincipal()!=null)LOG.log(OperationLogLevel.OPERATION,"the operator is "+((HttpServletRequest)req).getUserPrincipal().getName());
			  		LOG.log(OperationLogLevel.OPERATION,"the requester ip is "+getLocalIp((HttpServletRequest)req));
				}
			        //目标参数列表
			        if (args != null) {
			            for (Object obj : args) {
			            	if(!(obj instanceof HttpServletRequest)||!(obj instanceof HttpServletResponse)) {
			            		inputParams+= obj + ",";
			            	}
			            	
			            }
			            LOG.log(OperationLogLevel.OPERATION,"请求的参数为："+inputParams.toString());
			        }
			        LOG.log(OperationLogLevel.OPERATION,"调用的方法为："+joinPoint.getSignature().toString());
			        if(returnVal!=null)LOG.log(OperationLogLevel.OPERATION,"返回的值为："+returnVal.toString());
			        LOG.log(OperationLogLevel.OPERATION,"调用成功");
			        
			    }catch(Exception e) {
			        LOG.log(OperationLogLevel.OPERATION,"该请求不是http请求");
			    }
			   
	}


	@AfterThrowing(pointcut = "pointCut()", throwing = "error")
	public void afterThrowing(JoinPoint joinPoint, Throwable error) { 	
		
		try{
		
		    Object[] args = joinPoint.getArgs();
		    String inputParams ="";
			if(req!=null) {
				String requestType =(String)((HttpServletRequest)req).getHeader("X-Requested-With");   
		  	    if (requestType != null && requestType.equals("XMLHttpRequest")) { 
		  	    	LOG.log(OperationLogLevel.OPERATION,"请求方式为 AJAX:");
		  	    }else {
		  	    	LOG.log(OperationLogLevel.OPERATION,"请求方式为非 AjaX:");
		  	    }
		  		LOG.log(OperationLogLevel.OPERATION,"请求路径是："+((HttpServletRequest)req).getRequestURI());
		  		if(((HttpServletRequest)req).getUserPrincipal()!=null)LOG.log(OperationLogLevel.OPERATION,"操作者是："+((HttpServletRequest)req).getUserPrincipal().getName());
		  		LOG.log(OperationLogLevel.OPERATION,"请求地址ip: "+getLocalIp(((HttpServletRequest)req)));
			}
		        //目标参数列表
		        if (args != null) {
		            for (Object obj : args) {
		            	if(!(obj instanceof HttpServletRequest)||!(obj instanceof HttpServletResponse)) {
		            		inputParams+= obj + ",";
		            	}
		            	
		            }
		            LOG.log(OperationLogLevel.OPERATION,"请求的参数为："+inputParams.toString());
		        }
		        LOG.log(OperationLogLevel.OPERATION,"调用的方法为："+joinPoint.getSignature().toString());
		        LOG.log(OperationLogLevel.OPERATION,"调用失败");
		        if(error!=null)LOG.log(OperationLogLevel.OPERATION,error.getMessage());
		}catch(Exception e) {
		     LOG.log(OperationLogLevel.OPERATION,"该请求不是http请求");
		}    
	}
	
	
    private  String getLocalIp(HttpServletRequest request) {
        String remoteAddr = request.getRemoteAddr();
        String forwarded = request.getHeader("X-Forwarded-For");
        String realIp = request.getHeader("X-Real-IP");

        String ip = null;
        if (realIp == null) {
            if (forwarded == null) {
                ip = remoteAddr;
            } else {
                ip = remoteAddr + "/" + forwarded.split(",")[0];
            }
        } else {
            if (realIp.equals(forwarded)) {
                ip = realIp;
            } else {
                if(forwarded != null){
                    forwarded = forwarded.split(",")[0];
                }
                ip = realIp + "/" + forwarded;
            }
        }
        return ip;
    }
	
}*/