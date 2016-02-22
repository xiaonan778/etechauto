package com.etech.benchmark.backadmin.sys.service;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.sys.model.UserRoleRef;


public interface UserRoleRefService {

    public void saveOrUpdate(UserRoleRef ref);

    public int removeByRoleId(String roleId);

    public int countRoleUserSize(String roleId);

    public List<Map<String, Object>> listAdmins(Map<String, Object> params);
    
    public UserRoleRef getUserRoleRefById(String id);
}
