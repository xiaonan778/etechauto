package com.etech.benchmark.data.report.model;

import com.etech.benchmark.model.PaginationParam;

public class TableSchema extends PaginationParam {

    /**
     * 
     */
    private static final long serialVersionUID = 2211496353261885000L;
    
    /**
     * 主键
     */
    private String id;
    
    /**
     * 表信息外键
     */
    private Integer table_fk;
    
    /**
     * 表名
     */
    private String tableName;
    
    /**
     * 列名
     */
    private String columnName;
    
    /**
     * 单位
     */
    private String unit;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getTable_fk() {
        return table_fk;
    }

    public void setTable_fk(Integer table_fk) {
        this.table_fk = table_fk;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }
    
}
