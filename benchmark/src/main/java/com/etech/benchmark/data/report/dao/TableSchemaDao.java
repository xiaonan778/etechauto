package com.etech.benchmark.data.report.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.etech.benchmark.data.MybatisRepository;

@MybatisRepository
public interface TableSchemaDao {
    
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
    public int checkTableSchemaIfExists (@Param("tableName") String tableName);
    
    /**
     * 判断表是否已存在
     * @param tableName
     * @return
     */
    public int checkTableIfExists (@Param("tableName") String tableName);
    
    /**
     * 列出一张表的字段信息
     * @param table_fk
     * @return
     */
    public  List<String> listColumnByTableFk (@Param("table_fk") String table_fk);
    
    /**
     * 获取单位
     * @param columnName
     * @return
     */
    public String getUnit(@Param("columnName") String columnName);
}
