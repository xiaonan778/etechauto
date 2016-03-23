package com.etech.benchmark.data.report.dao;

import java.util.List;
import java.util.Map;

public interface ReportDao {
    
    public String PREFIX = ReportDao.class.getName();
    
    public int createTable(Map<String, Object> map);
    
    public int insert(Map<String, Object> map);
    
    public int  addTableColumn(List<Object> columns);
    
    public Map<String, Object> getMaxTorqueByAlpha(Map<String, Object> params);
    
    public <E, K, V> List<E> listByAlpha(Map<String, Object> params);
    
    public int getTableSchemaCount(String tableName);
}
