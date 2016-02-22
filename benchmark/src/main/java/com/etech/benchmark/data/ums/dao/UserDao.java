package com.etech.benchmark.data.ums.dao;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.ums.model.User;
import com.etech.benchmark.page.Page;


/**
 * 鏁版嵁璁块棶鎺ュ彛
 * 
 */
public interface UserDao {
    public final static String PREFIX = UserDao.class.getName();

    public User get(Map<String, Object> params);

    public Map<String, Object> findOne(Map<String, Object> params);

    public int insert(User user);

    public int update(User user);
    
    public int updateComment(User user);

    public int delete(String id);

    public <E, K, V> Page<E> page(Map<K, V> params, int current, int pagesize);

    /**
     * 鎸夌敤鎴峰悕鏌ユ壘鐢ㄦ埛
     * 
     * @param username 鐢ㄦ埛鍚?
     * @param type
     * @param status 0锛氬仠鐢?1锛氬惎鐢?
     * @return
     */
    public User getByUsername(String username, Integer status);

    /**
     * 鎸夋墜鏈哄彿鐮佹煡鎵剧敤鎴?
     * 
     * @param phone 鎵嬫満鍙风爜
     * @param type
     * @param status 0锛氬仠鐢?1锛氬惎鐢?
     * @return
     */
    public User getByPhone(String phone, Integer type, Integer status);

    /**
     * 鏍规嵁鐢ㄦ埛鍚嶆垨鑰呮墜鏈哄彿鏄惁瀛樺湪
     * 
     * @param username
     * @param phone
     * @return true:瀛樺湪 false:涓嶅瓨鍦?
     */
    public boolean checkUserExist(String username, String phone);

    public List<String> listRolesByUsername(String username);

    public List<String> listPermissionsByUsername(String username);

    public boolean updateFinancialPlanner(User user);

    public List<Map<String, Object>> listFinancialByArea(Map<String, Object> params);

    /**
     * 鎺ㄨ崘鐮佽璇?
     * 
     * @param recommendedCode
     * @return
     */
    public User getByRecommendedCode(String recommendedCode);

    /**
     * 瀹炲悕璁よ瘉
     */
    public int realNameAuth(User user);

    /**
     * 鏄撳疂鐩稿叧鐘舵?鏇存敼
     * 
     * @param params
     * @return
     */
    public int changeYeepayStatus(Map<String, Object> params);

	public List<String> findRolesName(String username);
}
