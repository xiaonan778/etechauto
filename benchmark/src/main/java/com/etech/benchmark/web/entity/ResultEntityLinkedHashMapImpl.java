package com.etech.benchmark.web.entity;

import java.util.LinkedHashMap;
import java.util.List;

public class ResultEntityLinkedHashMapImpl extends LinkedHashMap<String, Object> implements ResultEntity {
    private static final long serialVersionUID = -5275510246365872828L;
    protected static final String KW_KEY_STATUS = "status";
    protected static final String KW_KEY_MSG = "message";
    protected static final String KW_KEY_RESULT = "result";
    protected static final String KW_KEY_LIST = "list";

    public ResultEntityLinkedHashMapImpl() {
    }

    public ResultEntityLinkedHashMapImpl(String status, String msg) {
        put("status", status);
        put("message", msg);
    }

    public ResultEntityLinkedHashMapImpl(String status, String msg, Object entity) {
        put("status", status);
        put("message", msg);
        if (entity == null)
            return;
        put((entity instanceof List) ? "list" : "result", entity);
    }

    public void setStatus(String status) {
        put("status", status);
    }

    public void setMsg(String msg) {
        put("message", msg);
    }

    public void setResult(Object result) {
        put("result", result);
    }

    public void addObject(String key, Object value) {
        put(key, value);
    }

    public void removeObject(String key) {
        remove(key);
    }
}
