package com.etech.benchmark.data.info.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.etech.benchmark.data.DaoSupport;
import com.etech.benchmark.data.info.dao.BmExcelDao;
import com.etech.benchmark.data.info.model.BmExcel;


@Repository
public class BmExcelDaoImpl implements BmExcelDao {

    @Autowired
    private DaoSupport dao;
    
    @Override
    public BmExcel findOne(Map<String, Object> params) {
        return dao.get(PREFIX + ".findOne", params);
    }
    
	@Override
	public <E> List<E> find(Map<String, Object> params) {
		 return dao.find(PREFIX + ".find", params);
	}
	
	@Override
	public <E> List<E> page(Map<String, Object> params) {
		 return dao.find(PREFIX + ".page", params);
	}

	@Override
	public Map<String, Object> getConditions(String treeId) {
		Map<String, Object> params = new HashMap<String, Object>();
	    params.put("treeId", treeId);
		return dao.get(PREFIX + ".getConditions", params);
	}
	
	@Override
	public boolean insertExcel(BmExcel bmExcel) {
		return dao.insert(PREFIX + ".insertExcel",bmExcel)>0;
	}

	@Override
	public boolean deleteFile(Map<String, Object> params) {
		return dao.delete(PREFIX +  ".deleteFile", params)>0;
	}

	@Override
	public void updateExcelCondition(Map<String, Object> params) {
		 dao.update(PREFIX +  ".updateExcelCondition", params);
	}


}
