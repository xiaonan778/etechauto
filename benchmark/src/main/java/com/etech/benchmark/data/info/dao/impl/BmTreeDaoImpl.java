package com.etech.benchmark.data.info.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.etech.benchmark.data.DaoSupport;
import com.etech.benchmark.data.info.dao.BmTreeDao;
import com.etech.benchmark.data.info.model.BmTree;


@Repository
public class BmTreeDaoImpl implements BmTreeDao {

    @Autowired
    private DaoSupport dao;
    
    @Override
    public int insert(BmTree tree) {
        return dao.insert(PREFIX + ".insert", tree);
    }

    @Override
    public int update(Map<String, Object> params) {
        return dao.update(PREFIX + ".update", params);
    }

    @Override
    public BmTree findOne(String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return dao.get(PREFIX + ".findOne", params);
    }

    @Override
    public <E> List<E> listAll(Map<String, Object> params) {
        return dao.find(PREFIX + ".listAll", params);
    }

    @Override
    public int delete(String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return dao.delete(PREFIX + ".delete", params);
    }

    @Override
    public <E> List<E> getBmTreePermissions() {
        
        return dao.find(PREFIX + ".getBmTreePermissions");
    }

    @Override
    public <E> List<E> getBmTreeParents() {
        return dao.find(PREFIX + ".getBmTreeParents");
    }

    @Override
    public Map<String, Object> getBmTreePermissionById(String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return dao.get(PREFIX + ".getBmTreePermissionById", params);
    }

    @Override
    public <E> List<E> find(Map<String, Object> params) {
        return dao.find(PREFIX + ".find", params);
    }

}
