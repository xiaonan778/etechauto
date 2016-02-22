package com.etech.benchmark.data.sys.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.etech.benchmark.backadmin.page.Page;
import com.etech.benchmark.data.DaoSupport;
import com.etech.benchmark.data.sys.dao.UserRoleRefDao;
import com.etech.benchmark.data.sys.model.UserRoleRef;


/**
 * 数据访问接口
 * 
 * @author xiaoming
 * 
 */
@Repository
public class UserRoleRefDaoImpl implements UserRoleRefDao {

    @Autowired
    private DaoSupport dao;

    @Override
    public UserRoleRef get(java.lang.String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return dao.get(PREFIX + ".get", params);
    }

    @Override
    public <K, V> Map<K, V> findOne(java.lang.String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return dao.get(PREFIX + ".findOne", params);
    }

    @Override
    public <T, K, V> List<T> find(Map<K, V> params) {
        return dao.find(PREFIX + ".find", params);
    }

    @Override
    public int insert(UserRoleRef ref) {
        return dao.insert(PREFIX + ".insert", ref);
    }

    @Override
    public int update(UserRoleRef ref) {
        return dao.update(PREFIX + ".update", ref);
    }

    @Override
    public int removeByRoleId(String roleId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("roleId", roleId);
        return dao.update(PREFIX + ".removeByRoleId", params);
    }

    @Override
    public int delete(java.lang.String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return dao.delete(PREFIX + ".delete", params);
    }

    @Override
    public <E, K, V> Page<E> page(Map<K, V> params, int current, int pagesize) {
        return dao.page(PREFIX + ".page", params, current, pagesize);
    }

    @Override
    public int countRoleUserSize(String roleId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("roleId", roleId);
        return dao.get(PREFIX + ".countRoleUserSize", params);
    }

    @Override
    public <T, K, V> List<T> listAdmins(Map<K, V> params) {
        return dao.find(PREFIX + ".listAdmins", params);
    }

}
