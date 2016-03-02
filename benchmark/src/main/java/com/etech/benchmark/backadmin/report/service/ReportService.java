package com.etech.benchmark.backadmin.report.service;

import java.util.Map;

public interface ReportService {
    
    public int creatTable(Map<String, Object> params, String tableName);
    
    public int insert(Map<String, Object> params, String tableName);
    
    public Map<String, Object> getMaxTorqueByAlpha(Map<String, Object> params, String tableName);
    
}
