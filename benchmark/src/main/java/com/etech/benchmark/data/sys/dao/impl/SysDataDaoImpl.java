
/**   
 * @Title: SysDataDaoImpl.java 
 * @Package: com.etech.benchmark.data.sys.dao.impl 
 * @author DCJ  
 * @date 2015-4-29 下午10:11:56 
 * @version 1.0 
 */


package com.etech.benchmark.data.sys.dao.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.etech.benchmark.data.DaoSupport;
import com.etech.benchmark.data.page.Page;
import com.etech.benchmark.data.sys.dao.SysDataDao;
import com.etech.benchmark.data.sys.model.SysData;

/** 
 * @Description 
 * @author DCJ
 * @date 2015-4-29 下午10:11:56 
 * @version V1.0
 */

@Repository
public class SysDataDaoImpl implements SysDataDao{
	
	@Autowired  private DaoSupport dao;
	/**
	 * Description 
	 * @param params
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysDataDao#findOneByCode(java.util.Map) 
	 */ 
		
	@Override
	public Map<String, Object> findOneByCode(Map<String, Object> params) {
		return dao.findOne(PREFIX + ".findOneByCode", params);
	}
	/**
	 * Description 
	 * @param current
	 * @param pagesize
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysDataDao#page(int, int) 
	 */ 
		
	@Override
	public <E, K, V> Page<E> page(int current, int pagesize) {
		return dao.page(PREFIX + ".page", null,  current, pagesize);
	}
	/**
	 * Description 
	 * @param params
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysDataDao#findSysDataById(java.util.Map) 
	 */ 
		
	@Override
	public SysData findSysDataById(Map<String, Object> params) {
		return dao.get(PREFIX + ".findSysDataById", params);
	}

}
