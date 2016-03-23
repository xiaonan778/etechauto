package com.etech.benchmark.backadmin.report.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etech.benchmark.backadmin.report.service.ReportService;
import com.etech.benchmark.data.report.dao.ReportDao;
import com.etech.benchmark.util.StringUtil;

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
    
    @Override
    public <E, K, V> List<E> listByAlpha(Map<String, Object> params, String tableName) {
        params.put("tablename", tableName);
        
        return reportDao.listByAlpha(params);
    }

    @Override
    public int addTableColumn(Map<String, Object> params, int table_fk, String tableName) {
        List<Object> columns = new ArrayList<Object>();
        Set<String> keys = params.keySet();
        for (String key : keys) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", StringUtil.createUUID());
            map.put("table_fk", table_fk);
            map.put("tableName", tableName);
            map.put("columnName", key);
            map.put("unit", params.get(key));
            columns.add(map);
        }
        
        return reportDao.addTableColumn(columns);
    }

    @Override
    public int getTableSchemaCount(String tableName) {
        return reportDao.getTableSchemaCount(tableName);
    }
}
