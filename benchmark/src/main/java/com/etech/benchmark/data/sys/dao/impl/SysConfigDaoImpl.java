
/**   
 * @Title: SysConfigDaoImpl.java 
 * @Package: com.etech.benchmark.api.data.dao.impl 
 * @author DCJ  
 * @date 2015-4-29 下午4:33:18 
 * @version 1.0 
 */


package com.etech.benchmark.data.sys.dao.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.etech.benchmark.data.DaoSupport;
import com.etech.benchmark.data.sys.dao.SysConfigDao;
import com.etech.benchmark.data.sys.model.SysConfig;

/** 
 * @Description 
 * @author DCJ
 * @date 2015-4-29 下午4:33:18 
 * @version V1.0
 */
@Repository
public class SysConfigDaoImpl implements SysConfigDao{
	
	@Autowired  private DaoSupport dao;

	/**
	 * Description 
	 * @param sysConfig
	 * @return 
	 * @see com.etech.benchmark.api.data.dao.SysConfigDao#insertSysConfig(com.etech.benchmark.api.data.model.SysConfig) 
	 */ 
		
	@Override
	public boolean insertSysConfig(SysConfig sysConfig) {
		return dao.insert(PREFIX + ".insertSysConfig", sysConfig)>0;
	}

	/**
	 * Description 
	 * @param params
	 * @return 
	 * @see com.etech.benchmark.api.data.dao.SysConfigDao#findOneSysConfig(java.util.Map) 
	 */ 
		
	@Override
	public Map<String, Object> findOneSysConfig(Map<String, Object> params) {
		return dao.findOne(PREFIX + ".findOneByIdKey", params);
	}

	/**
	 * Description 
	 * @param params
	 * @return 
	 * @see com.etech.benchmark.api.data.dao.SysConfigDao#delSysConfig(java.util.Map) 
	 */ 
		
	@Override
	public boolean delSysConfig(Map<String, Object> params) {
		return dao.delete(PREFIX + ".delSysConfig", params)>0;
	}

	/**
	 * Description 
	 * @param method
	 * @param arg
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysConfigDao#getMapperSql(java.lang.String, java.lang.Object[]) 
	 */ 
		
	@Override
	public String getBeanSql(String method, Object arg) {
		return dao.getBeanSql(method, arg);
	}

	/**
	 * Description 
	 * @param method
	 * @param args
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysConfigDao#getNamespaceSql(java.lang.String, java.lang.Object[]) 
	 */ 
		
	@Override
	public String getNamespaceSql(String method) {
		return dao.getNamespaceSql(method);
	}

	/**
	 * Description 
	 * @param method
	 * @param arg
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysConfigDao#getMapperSql(java.lang.String, java.lang.Object[]) 
	 */ 
		
	@Override
	public String getMapperSql(String method, Object... args) {
		return dao.getMapperSql(method, args);
	}

	/**
	 * Description 
	 * @param params
	 * @return 
	 * @see com.etech.benchmark.data.sys.dao.SysConfigDao#delSysConfigLogo(java.util.Map) 
	 */ 
		
	@Override
	public boolean delSysConfigLogo(Map<String, Object> params) {
		return dao.delete(PREFIX + ".delSysConfigLogo", params)>0;
	}

}
