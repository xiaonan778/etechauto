package com.etech.benchmark.backadmin.ums.service.impl;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etech.benchmark.backadmin.page.Page;
import com.etech.benchmark.backadmin.ums.service.PasswordHelper;
import com.etech.benchmark.backadmin.ums.service.UserService;
import com.etech.benchmark.data.ums.dao.UserDao;
import com.etech.benchmark.data.ums.model.User;
import com.etech.benchmark.exception.ServiceException;
import com.etech.benchmark.util.StringUtil;

@Service(value = "adminUserService")
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public Page<Map<String, Object>> grid(Map<String, Object> params, int current, int pagesize) {
        return userDao.page(params, current, pagesize);
    }

    @Override
    public boolean save(User user) throws ServiceException {
        boolean b = userDao.checkUserExist(user.getUsername(), user.getPhone());
        String msg = "";
        if (b) {
            if (StringUtil.notEmpty(user.getUsername()) && StringUtil.notEmpty(user.getPhone())) {
                msg = "账号为 [" + user.getUsername() + "] 的用户或 [" + user.getPhone() + "]手机号已经存在";
            } else if (StringUtil.notEmpty(user.getUsername())) {
                msg = "账号为 [" + user.getUsername() + "] 的用户已经存在";
            } else {
                msg = "手机号为[" + user.getPhone() + "] 的用户已经存在";
            }
            throw new ServiceException(msg);
        }
        user.setId(StringUtil.createUUID());
        PasswordHelper passwordHelper = new PasswordHelper();
        passwordHelper.encryptPassword(user);
        return userDao.insert(user) > 0;
    }

    @Override
    public boolean saveFinancialPlanner(User user) throws ServiceException{
        user.setId(StringUtil.createUUID());
        boolean b = userDao.checkUserExist(user.getUsername(), user.getPhone());
        String msg = "";
        if (b) {
            if (StringUtil.notEmpty(user.getUsername()) && StringUtil.notEmpty(user.getPhone())) {
                msg = "账号为 [" + user.getUsername() + "] 的用户或 [" + user.getPhone() + "]手机号已经存在";
            } else if (StringUtil.notEmpty(user.getUsername())) {
                msg = "账号为 [" + user.getUsername() + "] 的用户已经存在";
            } else {
                msg = "手机号为[" + user.getPhone() + "] 的用户已经存在";
            }
            throw new ServiceException(msg);
        }
        return userDao.insert(user) > 0;
    }

    @Override
    public boolean updateFinancialPlanner(User user) {
        return userDao.updateFinancialPlanner(user);
    }

    @Override
    public boolean update(User tbUser) {
        return userDao.update(tbUser) > 0;
    }

    @Override
    public User findById(String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return userDao.get(params);
    }

    @Override
    public boolean deleteById(String id) {
        return userDao.delete(id) > 0;
    }

    @Override
    public boolean updatePassword(String id, String password, String updater_fk) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        User user = userDao.get(params);
        if (user != null && StringUtil.notEmpty(password)) {
            user.setUpdater_fk(updater_fk);
            user.setPassword(password);
            PasswordHelper passwordHelper = new PasswordHelper();
            passwordHelper.encryptPassword(user);
            return userDao.update(user) > 0;
        }
        return false;
    }

    @Override
    public User getByUsername(String username, int status) {
        User user = userDao.getByUsername(username, status);
        return user;
    }

    @Override
    public Set<String> findRoles(String account) {
        Set<String> roles = new HashSet<String>();
        roles.addAll((List<String>) userDao.listRolesByUsername(account));
        // --------------------------------------------------------------------------------------------------
        return roles;
    }

    @Override
    public Set<String> findPermissions(String account) {
        Set<String> permissions = new HashSet<String>();
        permissions.addAll((List<String>) userDao.listPermissionsByUsername(account));
        // --------------------------------------------------------------------------------------------------
        return permissions;
    }

    @Override
    public Map<String, Object> findOne(String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return userDao.findOne(params);

    }

    @Override
    public List<Map<String, Object>> listFinancialByArea(String area_fk) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("area_fk", area_fk);
        return userDao.listFinancialByArea(params);
    }

    @Override
    public boolean userDistribution(User registeredUser, User financialUser) {
        int count = userDao.update(registeredUser);
        count = count + userDao.update(financialUser);
        return count > 1;
    }

	@Override
	public boolean updateComment(User user) {
		return userDao.updateComment(user)>0;
	}
	
    @Override
    public boolean checkPhoneExist(String phone, String uId) {
        User user = userDao.getByPhone(phone, null, null);
        if (user == null || user.getId().equals(uId)) {
            return false;
        }
        return true;
    }

	@Override
	public Set<String> findRolesName(String username) {
		   Set<String> roles = new HashSet<String>();
	        roles.addAll((List<String>) userDao.findRolesName(username));
		return roles;
	}
}
