package com.etech.benchmark.data.report.dao;

import java.util.List;
import java.util.Map;

public interface ReportDao {
    
    public String PREFIX = ReportDao.class.getName();
    
    /**
     * create table if not exists
     * @param map
     * @return
     */
    public int createTable(Map<String, Object> map);
    
    /**
     * 新增数据
     * @param map
     * @return
     */
    public int insert(Map<String, Object> map);
    
    public Map<String, Object> getMaxTorqueByAlpha(Map<String, Object> params);
    
    public <E, K, V> List<E> listByAlpha(Map<String, Object> params);
    
    /**
     * 根据条件筛选数据
     * @param params
     * @return
     */
    public <E, K, V> List<E> search(Map<String, Object> params);
    
}
