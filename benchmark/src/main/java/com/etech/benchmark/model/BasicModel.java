package com.etech.benchmark.model;

import java.io.Serializable;
import java.util.Date;

public abstract class BasicModel implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = -5104098935056866767L;
    
    protected Date date_create;
    protected Date date_update;
    protected String creator_fk;
    protected String updater_fk;
    protected String creator;
    protected String updater;
    protected byte is_valid;
    public Date getDate_create() {
        return date_create;
    }
    public void setDate_create(Date date_create) {
        this.date_create = date_create;
    }
    public Date getDate_update() {
        return date_update;
    }
    public void setDate_update(Date date_update) {
        this.date_update = date_update;
    }
    public String getCreator_fk() {
        return creator_fk;
    }
    public void setCreator_fk(String creator_fk) {
        this.creator_fk = creator_fk;
    }
    public String getUpdater_fk() {
        return updater_fk;
    }
    public void setUpdater_fk(String updater_fk) {
        this.updater_fk = updater_fk;
    }
    public byte getIs_valid() {
        return is_valid;
    }
    public void setIs_valid(byte is_valid) {
        this.is_valid = is_valid;
    }
    public String getCreator() {
        return creator;
    }
    public void setCreator(String creator) {
        this.creator = creator;
    }
    public String getUpdater() {
        return updater;
    }
    public void setUpdater(String updater) {
        this.updater = updater;
    }
    
}