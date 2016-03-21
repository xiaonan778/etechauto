
/**   
 * @Title: DictionaryServiceImpl.java 
 * @Package: com.etech.benchmark.backadmin.sys.service.impl 
 * @author DCJ  
 * @date 2015-4-29 下午10:33:14 
 * @version 1.0 
 */


package com.etech.benchmark.backadmin.sys.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etech.benchmark.backadmin.sys.service.DictionaryService;
import com.etech.benchmark.data.sys.dao.SysDataDao;
import com.etech.benchmark.data.sys.dao.SysDataDictionaryDao;
import com.etech.benchmark.data.sys.model.SysData;
import com.etech.benchmark.data.sys.model.SysDataDictionary;
import com.etech.benchmark.model.Page;

/** 
 * @Description 
 * @author DCJ
 * @date 2015-4-29 下午10:33:14 
 * @version V1.0
 */

@Service
public class DictionaryServiceImpl implements DictionaryService{
	
	@Autowired private SysDataDao sysDataDao;
	@Autowired private SysDataDictionaryDao sysDicDao;

	/**
	 * Description 
	 * @param glmk
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#findOneByCode(java.lang.String) 
	 */ 
		
	@Override
	public Map<String, Object> findOneByCode(String code) {
		Map<String, Object> params = new HashMap<String, Object>();
        params.put("code", code);
        return sysDataDao.findOneByCode(params);
	}

	/**
	 * Description 
	 * @param dictionaryId
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#findDicById(java.lang.String) 
	 */ 
		
	@Override
	public <T, K, V> List<T> findDicById(Integer dictionaryId, String tenantFk) {
		Map<String, Object> params = new HashMap<String, Object>();
        params.put("data_fk", dictionaryId);
        params.put("tenant_fk", tenantFk);
        return sysDicDao.findDicById(params);
	}

	/**
	 * Description 
	 * @param bbsj
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#findDictionaryByCode(java.lang.String) 
	 */ 
		
	@Override
	public List<SysDataDictionary> findDictionaryByCode(String code) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("code", code);
		return sysDicDao.findDictionaryByCode(params);
	}

	/**
	 * Description 
	 * @param current
	 * @param pageSize
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#page(int, int) 
	 */ 
		
	@Override
	public Page<Map<String, Object>> page(int current, int pagesize) {
		return sysDataDao.page( current, pagesize);
	}

	/**
	 * Description 
	 * @param params
	 * @param current
	 * @param pageSize
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#sonpage(java.util.Map, int, int) 
	 */ 
		
	@Override
	public Page<Map<String, Object>> sonpage(Map<String, Object> params,
			int current, int pagesize) {
		return sysDicDao.page( params,current, pagesize);
	}

	/**
	 * Description 
	 * @param parseInt
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#findSysDataById(int) 
	 */ 
		
	@Override
	public SysData findSysDataById(int parseInt) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", parseInt);
		return sysDataDao.findSysDataById(params );
	}

	/**
	 * Description 
	 * @param parseInt
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#findSysDataDicById(int) 
	 */ 
		
	@Override
	public SysDataDictionary findSysDataDicById(int parseInt) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", parseInt);
		return sysDicDao.findSysDataDicById(params);
	}

	/**
	 * Description 
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#dicDataUpdate() 
	 */ 
		
	@Override
	public int dicDataUpdate(SysDataDictionary dicdata) {
		return sysDicDao.dicDataUpdate(dicdata);
	}

	/**
	 * Description 
	 * @param dicdata
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#dicDataInsert(com.etech.benchmark.data.sys.model.SysDataDictionary) 
	 */ 
		
	@Override
	public int dicDataInsert(SysDataDictionary dicdata) {
		return sysDicDao.dicDataInsert(dicdata);
	}

	/**
	 * Description 
	 * @param dicId
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#findMaxIdSort(int) 
	 */ 
		
	@Override
	public Map<String, Object> findMaxIdSort(int dicId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("data_fk", dicId);
		return sysDicDao.findMaxIdSort(params);
	}

	/**
	 * Description 
	 * @param id
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#updRuleById(java.lang.String) 
	 */ 
		
	@Override
	public Integer updRuleById(Integer id,String rule,String memo) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("rule", rule);
		params.put("memo", memo);
		return sysDicDao.updRuleById(params);
	}

	/**
	 * Description 
	 * @param exml
	 * @param fomatRow
	 * @return 
	 * @see com.etech.benchmark.backadmin.sys.service.DictionaryService#findDicList(java.lang.String, java.lang.String) 
	 */ 
		
	@Override
	public List<SysDataDictionary> findDicList(String code, String fomatRow) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("code", code);
		params.put("rule", fomatRow);
		return sysDicDao.findDicList(params);
	}

}
