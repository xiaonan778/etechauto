package com.etech.benchmark.backadmin.report.service;

import java.util.List;
import java.util.Map;

public interface ReportService {
    
    /**
     * create table if not exists
     * @param params
     * @param tableName
     * @return
     */
    public int creatTable(Map<String, Object> params, String tableName);
    
    /**
     * 新增数据
     * @param params
     * @param tableName
     * @return
     */
    public int insert(Map<String, Object> params, String tableName);
    
    public Map<String, Object> getMaxTorqueByAlpha(Map<String, Object> params, String tableName);
    
    public <E, K, V> List<E> listByAlpha(Map<String, Object> params, String tableName);
    
}
