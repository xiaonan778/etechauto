package com.etech.benchmark.backadmin.report.service;

import java.util.List;
import java.util.Map;

public interface ReportService {
    
    public int creatTable(Map<String, Object> params, String tableName);
    
    public int insert(Map<String, Object> params, String tableName);
    
    public Map<String, Object> getMaxTorqueByAlpha(Map<String, Object> params, String tableName);
    
    public <E, K, V> List<E> listByAlpha(Map<String, Object> params, String tableName);
    
    public int  addTableColumn(Map<String, Object> params, int table_fk, String tableName);
    
    public int getTableSchemaCount(String tableName);
    
}
