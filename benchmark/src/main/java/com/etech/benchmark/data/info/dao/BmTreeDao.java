package com.etech.benchmark.data.info.dao;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.info.model.BmTree;


public interface BmTreeDao {
    
    public final static String PREFIX = BmTreeDao.class.getName();
    
    int insert(BmTree bmTree);
    
    int update(Map<String, Object> params);
    
    BmTree findOne(String id);
    
    <E> List<E> listAll(Map<String, Object> params);
    
    int delete(String id);
    
    <E> List<E> getBmTreePermissions();
    
    <E> List<E> getBmTreeParents();
    
    Map<String, Object> getBmTreePermissionById(String id);
    
    <E> List<E> find(Map<String, Object> params);
    
    
   List<BmTree> searchBykeywords (String keywords);

}
