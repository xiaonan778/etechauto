/*package com.etech.benchmark.backadmin.log;

import org.apache.log4j.Level;  
  
    *//** 
     * 继承Level 
     * 
     *//*  
    public class OperationLogLevel extends Level{  
        *//**
		 * 
		 *//*
		private static final long serialVersionUID = -6563607907408979120L;
		public static final int OPERATION_INT=DEBUG_INT+50;
		
	      
	    *//** 
	     * 自定义级别名称，以及级别范围 
	     *//*  
	    public static final Level OPERATION = new OperationLogLevel(OPERATION_INT,"OPERATION",7);  

		public OperationLogLevel(int level, String levelStr, int syslogEquivalent) {  
            super(level, levelStr, syslogEquivalent);  
        }        
		
		  public static Level toLevel(String logArgument) {
		        if (logArgument != null && logArgument.toUpperCase().equals("OPERATION")) {
		            return OPERATION;
		        }
		        return  Level.toLevel(logArgument);
		    }
		 
    }  
      
*/