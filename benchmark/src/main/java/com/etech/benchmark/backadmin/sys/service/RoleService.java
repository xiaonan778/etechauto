package com.etech.benchmark.backadmin.sys.service;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.backadmin.page.Page;
import com.etech.benchmark.data.sys.model.Role;

public interface RoleService {

    public Role get(String id);

    public void saveOrUpdate(Role role);

    public List<Map<String, Object>> find(Map<String, Object> params);

    public Page<Map<String, Object>> page(Map<String, Object> params, int current, int pagesize);

}
