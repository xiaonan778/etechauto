package com.etech.benchmark.data.sys.dao;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.sys.model.RolePermissionRef;
import com.etech.benchmark.model.Page;


/**
 * 数据访问接口
 * 
 */
public interface RolePermissionRefDao {

    public final static String PREFIX = RolePermissionRefDao.class.getName();

    public RolePermissionRef get(String id);

    public <K, V> Map<K, V> findOne(String id);

    public <T, K, V> List<T> find(Map<K, V> params);

    public int insert(RolePermissionRef ref);

    public int update(RolePermissionRef ref);

    public int removeByRoleId(String roleId);

    public int delete(String id);

    public <E, K, V> Page<E> page(Map<K, V> params, int current, int pagesize);
    
    /**
     * 获取 角色 权限 对应关系
     * @param params
     * @return
     */
    <T, K, V> List<T> getRolePermissionRef(Map<String, Object> params);
}
