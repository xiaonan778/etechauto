package com.etech.benchmark.data.info.dao;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.info.model.BmFile;



public interface BmFileDao {
    
    public final static String PREFIX = BmFileDao.class.getName();
    
    BmFile findOne(Map<String, Object> params);
    
    <E> List<E> find(Map<String, Object> params);

	Map<String, Object> getConditions(String treeId);

	boolean insertExcel(BmFile bmExcel);

	boolean deleteFile(Map<String, Object> params);
	
	<E> List<E> page(Map<String, Object> params);

	void updateExcelCondition(Map<String, Object> params);
    
}
