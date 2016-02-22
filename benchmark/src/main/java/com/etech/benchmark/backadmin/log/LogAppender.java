/*package com.etech.benchmark.backadmin.log;

import java.lang.reflect.Method;

import org.apache.log4j.DailyRollingFileAppender;
import org.apache.log4j.Priority;

import com.etech.benchmark.backadmin.log.annotation.Loggable;

public class LogAppender extends DailyRollingFileAppender{
	
	@Override  
	@Loggable("租户管理 --> 租户清单 --> 搜索")
	 public boolean isAsSevereAsThreshold(Priority priority) {  
	  //只判断是否相等，而不判断优先级  
	  return this.getThreshold().toInt()==priority.toInt();  
	 }  
	
	public static void main(String[] args) throws NoSuchMethodException, SecurityException {
		Class<?> c =LogAppender.class;
		Method m = c.getMethod("isAsSevereAsThreshold", Priority.class);
		Loggable logable = m.getAnnotation(Loggable.class);
		System.out.println(logable.value());
	}

}
*/