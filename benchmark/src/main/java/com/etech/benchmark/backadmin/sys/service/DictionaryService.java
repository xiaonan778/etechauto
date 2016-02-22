
/**   
 * @Title: DictionaryService.java 
 * @Package: com.etech.benchmark.backadmin.sys.service 
 * @author DCJ  
 * @date 2015-4-29 下午10:32:41 
 * @version 1.0 
 */


package com.etech.benchmark.backadmin.sys.service;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.sys.model.SysData;
import com.etech.benchmark.data.sys.model.SysDataDictionary;
import com.etech.benchmark.page.Page;

/** 
 * @Description 
 * @author DCJ
 * @date 2015-4-29 下午10:32:41 
 * @version V1.0
 */

public interface DictionaryService {

	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param glmk
	 * @return  
	 */
	  	
	Map<String, Object> findOneByCode(String code);

	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param dictionaryId
	 * @return  
	 */
	  	
	public <T, K, V> List<T> findDicById(Integer dictionaryId,String tenantFk);


	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param bbsj
	 * @return  
	 */
	  	
	List<SysDataDictionary> findDictionaryByCode(String code);


	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param i
	 * @param pageSize
	 * @return  
	 */
	  	
	Page<Map<String, Object>> page(int current, int pageSize);


	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param params
	 * @param i
	 * @param pageSize
	 * @return  
	 */
	  	
	Page<Map<String, Object>> sonpage(Map<String, Object> params, int current,	int pageSize);


	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param parseInt
	 * @return  
	 */
	  	
	SysData findSysDataById(int parseInt);


	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param parseInt
	 * @return  
	 */
	  	
	SysDataDictionary findSysDataDicById(int parseInt);


	/** 
	 * @Description 
	 * @author DCJ
	 * @return  
	 */
	  	
	int dicDataUpdate(SysDataDictionary dicdata);


	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param dicdata  
	 */
	  	
	int dicDataInsert(SysDataDictionary dicdata);


	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param dicId
	 * @return  
	 */
	  	
	Map<String, Object> findMaxIdSort(int dicId);


	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param id  
	 */
	  	
	Integer updRuleById(Integer id,String rule,String memo);


	 
	/** 
	 * @Description 
	 * @author DCJ
	 * @param exml
	 * @param fomatRow
	 * @return  
	 */
	  	
	List<SysDataDictionary> findDicList(String exml, String fomatRow);

}
