package com.etech.benchmark.data.sys.dao;


import java.util.Map;
import java.util.List;

import com.etech.benchmark.data.sys.model.Role;
import com.etech.benchmark.model.Page;



/**
 * 数据访问接口
 *
 */
public interface RoleDao {

    public final static String PREFIX = RoleDao.class.getName();
    
	public Role get(String id);
	
	public <K, V> Map<K, V> findOne(String id);
	
	public <T, K, V> List<T> find(Map<K, V> params);
	
	public int insert(Role role);
	
	public int update(Role role);
	
	public int delete(String id );

	public <E, K, V> Page<E> page(Map<K, V> params, int current, int pagesize);

}


