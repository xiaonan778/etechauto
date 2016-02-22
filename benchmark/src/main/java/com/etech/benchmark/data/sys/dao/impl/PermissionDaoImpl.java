package com.etech.benchmark.data.sys.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.etech.benchmark.backadmin.page.Page;
import com.etech.benchmark.data.DaoSupport;
import com.etech.benchmark.data.sys.dao.PermissionDao;
import com.etech.benchmark.data.sys.model.Permission;


/**
 * 数据访问接口
 * 
 * @author xiaoming
 * 
 */
@Repository
public class PermissionDaoImpl implements PermissionDao {

    @Autowired
    private DaoSupport dao;

    @Override
    public Permission get(String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return dao.get(PREFIX + ".get", params);
    }

    @Override
    public <K, V> Map<K, V> findOne(String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return dao.get(PREFIX + ".findOne", params);
    }

    @Override
    public <T, K, V> List<T> find(Map<K, V> params) {
        return dao.find(PREFIX + ".find", params);
    }

    @Override
    public int insert(Permission permission) {
        return dao.insert(PREFIX + ".insert", permission);
    }

    @Override
    public int update(Permission permission) {
        return dao.update(PREFIX + ".update", permission);
    }

    @Override
    public int delete(String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return dao.delete(PREFIX + ".delete", params);
    }

    @Override
    public <E, K, V> Page<E> page(Map<K, V> params, int current, int pagesize) {
        return dao.page(PREFIX + ".page", params, current, pagesize);
    }
}
