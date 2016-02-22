package com.etech.benchmark.backadmin.sys.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etech.benchmark.backadmin.sys.service.RoleService;
import com.etech.benchmark.data.sys.dao.RoleDao;
import com.etech.benchmark.data.sys.model.Role;
import com.etech.benchmark.page.Page;


@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleDao dao;

    @Override
    public Role get(String id) {
        return dao.get(id);
    }

    @Override
    public void saveOrUpdate(Role role) {
        if (dao.update(role) <= 0) {
            dao.insert(role);
        }
    }

    @Override
    public List<Map<String, Object>> find(Map<String, Object> params) {
        return dao.find(params);
    }

    @Override
    public Page<Map<String, Object>> page(Map<String, Object> params, int current, int pagesize) {
        return dao.page(params, current, pagesize);
    }
}
