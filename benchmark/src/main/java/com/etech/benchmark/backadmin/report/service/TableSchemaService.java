package com.etech.benchmark.backadmin.report.service;

import java.util.Map;

public interface TableSchemaService {
    
    /**
     * 记录excel数据表列名信息
     * @param columns
     * @return
     */
    public int  addReportTableColumn (Map<String, Object> params, int table_fk, String tableName) ;
    
    /**
     * 判断excel数据表列名信息是否已导入
     * @param tableName
     * @return
     */
    public boolean checkTableSchemaIfExists (String tableName);
    
    /**
     * 判断表是否已存在
     * @param tableName
     * @return
     */
    public boolean checkTableIfExists (String tableName);
    
}
