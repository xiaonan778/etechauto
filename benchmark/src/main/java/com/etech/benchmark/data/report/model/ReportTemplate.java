package com.etech.benchmark.data.report.model;

import com.etech.benchmark.model.BasicModel;

/**
 * 
 * @author xiongfeng
 * 数据模板基本信息
 */
public class ReportTemplate extends BasicModel {
    /**
     * 
     */
    private static final long serialVersionUID = 1922468386570703330L;
    
    protected String id;
    /**
     * 模板名称
     */
    protected String template_name;
    
    /**
     * 模板类型
     */
    protected int template_type;
    
    /**
     * 数据表名称
     */
    protected String table_name;
    
    /**
     * 描述
     */
    protected String description;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTemplate_name() {
        return template_name;
    }

    public void setTemplate_name(String template_name) {
        this.template_name = template_name;
    }

    public String getTable_name() {
        return table_name;
    }

    public void setTable_name(String table_name) {
        this.table_name = table_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTemplate_type() {
        return template_type;
    }

    public void setTemplate_type(int template_type) {
        this.template_type = template_type;
    }
    
}
