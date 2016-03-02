package com.etech.benchmark.data.ums.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.etech.benchmark.data.DaoSupport;
import com.etech.benchmark.data.page.Page;
import com.etech.benchmark.data.ums.dao.UserDao;
import com.etech.benchmark.data.ums.model.User;


/**
 * 
 * @author LIUQIANG
 * @date 2015-3-18上午9:47:08
 * @version 0.0.1
 * @description
 */
@Repository
public class UserDaoImpl implements UserDao {

    @Autowired
    private DaoSupport dao;

    @Override
    public User get(Map<String, Object> params) {
        return dao.get(PREFIX + ".get", params);
    }

    @Override
    public int insert(User user) {
        return dao.insert(PREFIX + ".insert", user);
    }

    @Override
    public int update(User user) {
        return dao.update(PREFIX + ".update", user);
    }

    @Override
    public int updateComment(User user) {
        return dao.update(PREFIX + ".updateComment", user);
    }

    @Override
    public <E, K, V> Page<E> page(Map<K, V> params, int current, int pagesize) {
        return dao.page(PREFIX + ".page", params, current, pagesize);
    }

    @Override
    public User getByUsername(String username, Integer status) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("username", username);
        params.put("status", status);
        return dao.get(PREFIX + ".getByUsername", params);
    }

    @Override
    public User getByPhone(String phone, Integer type, Integer status) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("phone", phone);
        params.put("type", type);
        params.put("status", status);
        return dao.get(PREFIX + ".getByPhone", params);
    }

    @Override
    public boolean checkUserExist(String username, String phone) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("username", username);
        params.put("phone", phone);
        int count = dao.get(PREFIX + ".checkUserExist", params);
        return count > 0;
    }


    @Override
    public int delete(String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        User user = get(params);
        if (user != null) {
            user.setIsValid((short) 0);
            return update(user);
        }
        return 0;
    }

    @Override
    public List<String> listRolesByUsername(String username) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("username", username);
        return dao.find(PREFIX + ".listRolesByUsername", params);
    }

    @Override
    public List<String> listPermissionsByUsername(String username) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("username", username);
        return dao.find(PREFIX + ".listPermissionsByUsername", params);
    }

    @Override
    public Map<String, Object> findOne(Map<String, Object> params) {
        return dao.findOne(PREFIX + ".findById", params);
    }

    @Override
    public boolean updateFinancialPlanner(User user) {
        return dao.update(PREFIX + ".updateFinancialPlanner", user) > 0;
    }

    @Override
    public List<Map<String, Object>> listFinancialByArea(Map<String, Object> params) {
        return dao.find(PREFIX + ".listFinancialByArea", params);
    }

    @Override
    public User getByRecommendedCode(String recommendedCode) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("recommendedCode", recommendedCode);
        return dao.get(PREFIX + ".getByRecommendedCode", params);
    }

    @Override
    public int realNameAuth(User user) {
        return dao.update(PREFIX + ".realNameAuth", user);
    }

    @Override
    public int changeYeepayStatus(Map<String, Object> params) {
        return dao.update(PREFIX + ".changeYeepayStatus", params);
    }

	@Override
	public List<String> findRolesName(String username) {
	     Map<String, Object> params = new HashMap<String, Object>();
        params.put("username", username);
        return dao.find(PREFIX + ".findRolesName", params);
	}

}
