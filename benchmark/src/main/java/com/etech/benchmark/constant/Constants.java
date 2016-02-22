package com.etech.benchmark.constant;

import com.etech.benchmark.util.PropertiesUtils;



public class Constants {
	
	/** 当前用户 */
	public final static String CURRENT_USER = "currentUser";
	/** 当前验证码 */
	public final static String CURRENT_USER_VALIDATE_CODE_KEY = "CURRENT_USER_VALIDATE_CODE_KEY";
	/** 文件上传路径**/
	public final static String UPLOAD_PATH = PropertiesUtils.getValue("upload.path");
	/** 文件读取路径 **/
	public final static String FILEPATH_PREFIX = PropertiesUtils.getValue("fileUpload.web.prefix");

	public class Log{
		/**LOG级别INFO**/
		public final static int LOG_LEVEL_INFO = 1;
		/**LOG级别ERROR**/
		public final static int LOG_LEVEL_ERROR = 2;
		/**LOG级别WARM*/
		public final static int LOG_LEVEL_WARM = 3;
		/**LOG级别DEBUG**/
		public final static int LOG_LEVEL_DEBUG = 4;
		
		/**LOG类型操作日志**/
		public final static int LOG_TYPE_OPE = 1;
		/**LOG类型系统日志**/
		public final static int LOG_TYPE_SYS = 2;
		
	}
	
	
	public class DataDictionary{
		/**支付方法**/
		public final static String EXML = "EXML"; //Excel模版
	}
	
	/** 有效 **/
	public final static Byte VALID = 1;
	/** 无效 **/
	public final static Byte INVALID = 0;
	
}
