package com.etech.benchmark.data.sys.dao;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.page.Page;
import com.etech.benchmark.data.sys.model.Permission;


/**
 * 数据访问接口
 * 
 */
public interface PermissionDao {

    public final static String PREFIX = PermissionDao.class.getName();

    public Permission get(String id);

    public <K, V> Map<K, V> findOne(String id);

    public <T, K, V> List<T> find(Map<K, V> params);

    public int insert(Permission permission);

    public int update(Permission permission);

    public int delete(String id);

    public <E, K, V> Page<E> page(Map<K, V> params, int current, int pagesize);

}
