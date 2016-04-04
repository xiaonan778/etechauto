package com.etech.benchmark.data.report.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.etech.benchmark.data.DaoSupport;
import com.etech.benchmark.data.report.dao.TableSchemaDao;

@Repository
public class TableSchemaDaoImpl implements TableSchemaDao {
    
    @Autowired
    private DaoSupport dao;
    
    @Override
    public int addReportTableColumn(List<Object> columns) {
        return dao.insert(PREFIX + ".addReportTableColumn", columns);
    }

    @Override
    public boolean checkTableSchemaIfExists(String tableName) {
        Map<String, Object> params = new HashMap<>();
        params.put("tableName", tableName);
        int flag = dao.get(PREFIX +".checkTableSchemaIfExists", params);
        if (flag >0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public boolean checkTableIfExists(String tableName) {
        Map<String, Object> params = new HashMap<>();
        params.put("tableName", tableName);
        int flag = dao.get(PREFIX +".checkTableIfExists", params);
        if (flag >0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public List<String> listColumnByTableFk(int table_fk) {
        Map<String, Object> params = new HashMap<>();
        params.put("table_fk", table_fk);
        return dao.find(PREFIX + ".listColumnByTableFk", params);
    }

    @Override
    public String getUnit(String columnName) {
        Map<String, Object> params = new HashMap<>();
        params.put("columnName", columnName);
        return dao.get(PREFIX + ".getUnit", params);
    }

}
