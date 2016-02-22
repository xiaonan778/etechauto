package com.etech.benchmark.backadmin.sys.service;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.sys.model.SysMenu;
import com.etech.benchmark.exception.ServiceException;

public interface SysMenuService {
    
    int insert(SysMenu menu) throws ServiceException;
    
    int update(Map<String, Object> params) throws ServiceException;
    
    SysMenu findOne(String id);
    
    <E> List<E> listAll(Map<String, Object> params) throws ServiceException;
    
    int delete(String id);
    
    <K, V> List<Map< K, V>> getMenuPermissions();
    
    <K, V> List<Map< K, V>> getMenuParents();
    
    Map<String, Object> getMenuPermissionById(String id);
    
    <E> List<E> find(Map<String, Object> params) throws ServiceException;
}
