package com.etech.benchmark.backadmin.sys.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etech.benchmark.backadmin.sys.service.PermissionService;
import com.etech.benchmark.data.sys.dao.PermissionDao;
import com.etech.benchmark.data.sys.model.Permission;
import com.etech.benchmark.exception.ServiceException;
import com.etech.benchmark.model.Page;
import com.etech.benchmark.util.StringUtil;

@Service
public class PermissionServiceImpl implements PermissionService {
    
    @Autowired
    private PermissionDao permissionDao;
    
    @Override
    public Permission get(String id) throws ServiceException {
        return permissionDao.get(id);
    }

    @Override
    public <K, V> Map<K, V> findOne(String id) throws ServiceException {
        return permissionDao.findOne(id);
    }

    @Override
    public <T, K, V> List<T> find(Map<K, V> params) throws ServiceException {
        return permissionDao.find(params);
    }

    @Override
    public int insert(Permission permission) throws ServiceException {
        permission.setId(StringUtil.createUUID());
        return permissionDao.insert(permission);
    }

    @Override
    public int update(Permission permission) throws ServiceException {
        return permissionDao.update(permission);
    }

    @Override
    public int delete(String id) throws ServiceException {
        return permissionDao.delete(id);
    }

    @Override
    public <E, K, V> Page<E> page(Map<K, V> params, int current, int pagesize) throws ServiceException {
        return permissionDao.page(params, current, pagesize);
    }

}
