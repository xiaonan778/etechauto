package com.etech.benchmark.backadmin.report.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etech.benchmark.backadmin.report.service.TableSchemaService;
import com.etech.benchmark.data.report.dao.TableSchemaDao;
import com.etech.benchmark.util.StringUtil;

@Service
public class TableSchemaServiceImpl implements TableSchemaService {
    
    @Autowired
    private TableSchemaDao  tableSchemaDao;
    
    @Override
    public int addReportTableColumn (Map<String, Object> params, int table_fk, String tableName) {
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
        
        return tableSchemaDao.addReportTableColumn(columns);
    }

    @Override
    public boolean checkTableSchemaIfExists(String tableName) {
        return tableSchemaDao.checkTableSchemaIfExists(tableName);
    }

    @Override
    public boolean checkTableIfExists(String tableName) {
        return tableSchemaDao.checkTableIfExists(tableName);
    }

    @Override
    public List<String> listColumnByTableFk(int table_fk) {
        return tableSchemaDao.listColumnByTableFk(table_fk);
    }

    @Override
    public String getUnit(String columnName) {
        return tableSchemaDao.getUnit(columnName);
    }

}
