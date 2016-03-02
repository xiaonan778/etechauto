package com.etech.benchmark.backadmin.sys.model;

import com.etech.benchmark.data.model.PaginationParam;

/**
 * 角色查询参数
 * 
 * @author xiaoming
 * 
 */
public class RoleParam extends PaginationParam {

    private static final long serialVersionUID = -8117619171798881885L;

    
    /**
     * 角色名称
     */
    private String name;

    /**
     * 角色状态
     */
    private int valid = 2;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getValid() {
        return valid;
    }

    public void setValid(int valid) {
        this.valid = valid;
    }

}