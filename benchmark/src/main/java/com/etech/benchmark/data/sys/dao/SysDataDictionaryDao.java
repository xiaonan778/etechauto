
/**   
 * @Title: SysDataDictionaryDao.java 
 * @Package: com.etech.benchmark.data.sys.dao 
 * @author DCJ  
 * @date 2015-4-29 下午10:11:33 
 * @version 1.0 
 */


package com.etech.benchmark.data.sys.dao;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.page.Page;
import com.etech.benchmark.data.sys.model.SysDataDictionary;

/** 
 * @Description 
 * @author DCJ
 * @date 2015-4-29 下午10:11:33 
 * @version V1.0
 */

public interface SysDataDictionaryDao {

	public final static String PREFIX = SysDataDictionaryDao.class.getName();
	/** 
	 * @Description 
	 * @author DCJ
	 * @param params
	 * @return  
	 */
	  	
	public <T, K, V> List<T> findDicById(Map<K, V> params);
	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param params
	 * @return  
	 */
	  	
	public <T, K, V> List<T> findDictionaryByCode(Map<String, Object> params);

	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param params
	 * @param current
	 * @param pagesize
	 * @return  
	 */
	public <E, K, V> Page<E> page( Map<String, Object> params,int current, int pagesize);

	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param params
	 * @return  
	 */
	  	
	public SysDataDictionary findSysDataDicById(Map<String, Object> params);

	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param dicdata
	 * @return  
	 */
	  	
	public int dicDataUpdate(SysDataDictionary dicdata);  
	
	public int dicDataInsert(SysDataDictionary dicdata);

	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param params
	 * @return  
	 */
	  	
	public Map<String, Object> findMaxIdSort(Map<String, Object> params);

	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param params
	 * @return  
	 */
	  	
	public Integer updRuleById(Map<String, Object> params);

	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param params
	 * @return  
	 */
	  	
	public <T, K, V> List<T> findDicList(Map<String, Object> params);  

}
