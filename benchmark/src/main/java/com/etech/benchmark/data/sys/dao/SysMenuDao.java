package com.etech.benchmark.data.sys.dao;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.sys.model.SysMenu;

public interface SysMenuDao {
    
    public final static String PREFIX = SysMenuDao.class.getName();
    
    int insert(SysMenu menu);
    
    int update(Map<String, Object> params);
    
    SysMenu findOne(String id);
    
    <E> List<E> listAll(Map<String, Object> params);
    
    int delete(String id);
    
    <E> List<E> getMenuPermissions();
    
    <E> List<E> getMenuParents();
    
    Map<String, Object> getMenuPermissionById(String id);
    
    <E> List<E> find(Map<String, Object> params);
}
