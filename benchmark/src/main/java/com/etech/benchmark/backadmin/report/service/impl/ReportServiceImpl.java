package com.etech.benchmark.backadmin.report.service.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etech.benchmark.backadmin.report.service.ReportService;
import com.etech.benchmark.data.report.dao.ReportDao;

@Service
public class ReportServiceImpl implements ReportService {
    
    @Autowired
    private ReportDao reportDao;
    
    @Override
    public int creatTable(Map<String, Object> params, String tableName) {
        
        String[] keys = new String[params.size()];
        Set<String> sset = params.keySet();
        int i = 0;
        for (String os : sset) {
            keys[i++] = os;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tablename", tableName);
        map.put("keys", keys);
        
        return reportDao.createTable(map);
    }
    
    @Override
    public int insert(Map<String, Object> params, String tableName) {
        
        String[] keys = new String[params.size()];
        Set<String> sset = params.keySet();
        int i = 0;
        for (String os : sset) {
            keys[i++] = os;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tablename", tableName);
        map.put("keys", keys);
        map.put("params", params);
        
        return reportDao.insert(map);
    }

    @Override
    public Map<String, Object> getMaxTorqueByAlpha(Map<String, Object> params, String tableName) {
        params.put("tablename", tableName);
        
        return reportDao.getMaxTorqueByAlpha(params);
    }
    
}
