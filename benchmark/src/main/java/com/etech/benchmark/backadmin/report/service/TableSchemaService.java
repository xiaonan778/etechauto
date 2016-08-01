package com.etech.benchmark.backadmin.report.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etech.benchmark.data.report.dao.TableSchemaDao;
import com.etech.benchmark.util.StringUtil;

@Service
public class TableSchemaService {
    
    @Autowired
    private TableSchemaDao  tableSchemaDao;
    
    /**
     * 记录excel数据表列名信息
     * @param columns
     * @return
     */
    public int addReportTableColumn (Map<String, Object> params, String table_fk, String tableName) {
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

    /**
     * 判断excel数据表列名信息是否已导入
     * @param tableName
     * @return
     */
    public boolean checkTableSchemaIfExists(String tableName) {
        return tableSchemaDao.checkTableSchemaIfExists(tableName) > 0;
    }

    /**
     * 判断表是否已存在
     * @param tableName
     * @return
     */
    public boolean checkTableIfExists(String tableName) {
        return tableSchemaDao.checkTableIfExists(tableName) > 0;
    }

    /**
     * 列出一张表的字段信息
     * @param table_fk
     * @return
     */
    public List<String> listColumnByTableFk(String table_fk) {
        return tableSchemaDao.listColumnByTableFk(table_fk);
    }

    /**
     * 获取单位
     * @param columnName
     * @return
     */
    public String getUnit(String columnName) {
        return tableSchemaDao.getUnit(columnName);
    }

}
