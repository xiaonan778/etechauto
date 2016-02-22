
/**   
 * @Title: SysDataDictionaryDaoImpl.java 
 * @Package: com.etech.benchmark.data.sys.dao.impl 
 * @author DCJ  
 * @date 2015-4-29 下午10:12:40 
 * @version 1.0 
 */


package com.etech.benchmark.data.sys.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.etech.benchmark.backadmin.page.Page;
import com.etech.benchmark.data.DaoSupport;
import com.etech.benchmark.data.sys.dao.SysDataDictionaryDao;
import com.etech.benchmark.data.sys.model.SysDataDictionary;

/** 
 * @Description 
 * @author DCJ
 * @date 2015-4-29 下午10:12:40 
 * @version V1.0
 */

@Repository
public class SysDataDictionaryDaoImpl implements SysDataDictionaryDao{
	
	@Autowired  private DaoSupport dao;

	/**
	 * Description 
	 * @param params
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysDataDictionaryDao#findDicById(java.util.Map) 
	 */ 
		
	@Override
	public <T, K, V> List<T> findDicById(Map<K, V> params) {
		return dao.find(PREFIX + ".findDicById", params);
	}

	/**
	 * Description 
	 * @param params
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysDataDictionaryDao#findDictionaryByCode(java.util.Map) 
	 */ 
		
	@Override
	public <T, K, V> List<T> findDictionaryByCode(
			Map<String, Object> params) {
		return dao.find(PREFIX + ".findDictionaryByCode", params);
	}

	/**
	 * Description 
	 * @param params
	 * @param current
	 * @param pagesize
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysDataDictionaryDao#page(java.util.Map, int, int) 
	 */ 
		
	@Override
	public <E, K, V> Page<E> page(Map<String, Object> params, int current,int pagesize) {
		return dao.page(PREFIX + ".page", params,  current, pagesize);
	}

	/**
	 * Description 
	 * @param params
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysDataDictionaryDao#findSysDataDicById(java.util.Map) 
	 */ 
		
	@Override
	public SysDataDictionary findSysDataDicById(Map<String, Object> params) {
		return dao.get(PREFIX + ".findSysDataDicById", params);
	}

	/**
	 * Description 
	 * @param dicdata
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysDataDictionaryDao#dicDataUpdate(com.etech.benchmark.data.sys.model.SysDataDictionary) 
	 */ 
		
	@Override
	public int dicDataUpdate(SysDataDictionary dicdata) {
		return dao.update(PREFIX + ".dicDataUpdate",dicdata);
	}
	
	@Override
	public int dicDataInsert(SysDataDictionary dicdata) {
		return dao.insert(PREFIX + ".dicDataInsert",dicdata);
	}

	/**
	 * Description 
	 * @param params
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysDataDictionaryDao#findMaxIdSort(java.util.Map) 
	 */ 
		
	@Override
	public Map<String, Object> findMaxIdSort(Map<String, Object> params) {
		return dao.get(PREFIX + ".findMaxIdSort", params);
	}

	/**
	 * Description 
	 * @param params
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysDataDictionaryDao#updRuleById(java.util.Map) 
	 */ 
		
	@Override
	public Integer updRuleById(Map<String, Object> params) {
		return dao.update(PREFIX + ".updRuleById", params);
	}

	/**
	 * Description 
	 * @param params
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysDataDictionaryDao#findDicList(java.util.Map) 
	 */ 
		
	@Override
	public <T, K, V> List<T> findDicList(Map<String, Object> params) {
		return dao.find(PREFIX + ".findDictionaryParams", params);
	}

}
