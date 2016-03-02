package com.etech.benchmark.data.report.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.etech.benchmark.data.DaoSupport;
import com.etech.benchmark.data.report.dao.ReportDao;

@Repository
public class ReportDaoImpl  implements ReportDao {
    
    @Autowired
    private DaoSupport dao;
    
    @Override
    public int createTable(Map<String, Object> map) {
        return dao.update(PREFIX + ".createTable", map);
    }
    
    @Override
    public int insert(Map<String, Object> map) {
        return dao.insert(PREFIX + ".insert", map);
    }

    @Override
    public Map<String, Object> getMaxTorqueByAlpha(Map<String, Object> params) {
        return dao.get(PREFIX + ".getMaxTorqueByAlpha", params);
    }
    
    @Override
    public <E, K, V> List<E> listByAlpha(Map<String, Object> params) {
        return dao.find(PREFIX + ".listByAlpha", params);
    }

}
