package com.etech.benchmark.data.report.dao;

import java.util.List;

public interface TableSchemaDao {
    
    public String PREFIX = TableSchemaDao.class.getName();
    
    /**
     * 记录excel数据表列名信息
     * @param columns
     * @return
     */
    public int  addReportTableColumn (List<Object> columns);
    
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
    
    /**
     * 列出一张表的字段信息
     * @param table_fk
     * @return
     */
    public  List<String> listColumnByTableFk (int table_fk);
}
