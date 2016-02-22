
/**   
 * @Title: SysDataDao.java 
 * @Package: com.etech.benchmark.data.sys.dao 
 * @author DCJ  
 * @date 2015-4-29 下午10:11:03 
 * @version 1.0 
 */


package com.etech.benchmark.data.sys.dao;

import java.util.Map;

import com.etech.benchmark.backadmin.page.Page;
import com.etech.benchmark.data.sys.model.SysData;

/** 
 * @Description 
 * @author DCJ
 * @date 2015-4-29 下午10:11:03 
 * @version V1.0
 */

public interface SysDataDao {
	
	public final static String PREFIX = SysDataDao.class.getName();

	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param params
	 * @return  
	 */
	  	
	Map<String, Object> findOneByCode(Map<String, Object> params);


	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param current
	 * @param pagesize
	 * @return  
	 */
	  	
	public <E, K, V> Page<E> page( int current, int pagesize);



	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param params
	 * @return  
	 */
	  	
	SysData findSysDataById(Map<String, Object> params);

}
