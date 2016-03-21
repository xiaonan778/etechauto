package com.etech.benchmark.backadmin.ums.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.transaction.annotation.Transactional;

import com.etech.benchmark.data.ums.model.User;
import com.etech.benchmark.exception.ServiceException;
import com.etech.benchmark.model.Page;

public interface UserService {
    /**
     * 分页查询用户
     * 
     * @param params
     * @param current
     * @param pagesize
     * @return
     */
    public Page<Map<String, Object>> grid(Map<String, Object> params, int current, int pagesize);

    /**
     * 保存用户
     * 
     * @param tbuser
     * @return
     */
    public boolean save(User tbUser) throws ServiceException;

    /**
     * 更新理财师和区域管理员
     * 
     * @param user
     * @return
     */
    public boolean saveFinancialPlanner(User user) throws ServiceException;

    /**
     * 更新理财师信息
     * 
     * @param user
     * @return
     */
    public boolean updateFinancialPlanner(User user);

    /**
     * 更改用户
     * 
     * @param tbuser
     * @return
     */
    public boolean update(User tbUser);
    
    /**
     * 通用更改用户方法（有些字段没加）
     * 
     * @param tbuser
     * @return
     */
    public boolean updateComment(User user);

    /**
     * 查询单个用户
     * 
     * @param userid
     * @return
     */
    public User findById(String id);

    /**
     * 通过账号查找角色
     * 
     * @param account
     * @return
     */
    public Set<String> findRoles(String account);

    /**
     * 通过账号查找权限
     * 
     * @param account
     * @return
     */
    public Set<String> findPermissions(String account);

    /**
     * 
     * @return
     */
    public Map<String, Object> findOne(String id);

    /**
     * 删除单个用户
     * 
     * @param userid
     * @return
     */
    public boolean deleteById(String id);

    /**
     * 修改用户密码
     * 
     * @param userid
     * @param password
     * @return
     */
    public boolean updatePassword(String id, String password, String updater_fk);

    /**
     * 按帐号查找用户
     * 
     * @param username
     * @return
     */
    public User getByUsername(String username, int status);

    /**
     * 列出指定区域的理财师
     * 
     * @param area_fk
     * @return
     */
    public List<Map<String, Object>> listFinancialByArea(String area_fk);

    /**
     * 给用户指定理财师
     * 
     * @param registeredUser
     * @param financialUser
     * @return
     */
    @Transactional
    public boolean userDistribution(User registeredUser, User financialUser);
    
    public boolean checkPhoneExist(String phone, String uId);

	public Set<String> findRolesName(String username);
}
