package com.etech.benchmark.backadmin.sys.service;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.sys.model.RolePermissionRef;

public interface RolePermissionRefService {

    public void saveOrUpdate(RolePermissionRef ref);

    public int removeByRoleId(String roleId);
    
    /**
     * 获取 角色 权限 对应关系
     * @param params
     * @return
     */
    <T, K, V> List<T> getRolePermissionRef(Map<String, Object> params);
    
    public RolePermissionRef get(String id);
}
