package com.etech.benchmark.data.report.dao;

import java.util.Map;

public interface ReportDao {
    
    public String PREFIX = ReportDao.class.getName();
    
    public int createTable(Map<String, Object> map);
    
    public int insert(Map<String, Object> map);
    
    public Map<String, Object> getMaxTorqueByAlpha(Map<String, Object> params);
}
