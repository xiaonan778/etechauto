package com.etech.benchmark.backadmin.info.service;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.info.model.BmFile;
import com.etech.benchmark.data.info.model.BmTree;
import com.etech.benchmark.exception.ServiceException;


public interface BmTreeService {
    
    int insert(BmTree bmTree) throws ServiceException;
    
    int update(Map<String, Object> params) throws ServiceException;
    
    BmTree findOne(String id);
    
    <E> List<E> listAll(Map<String, Object> params) throws ServiceException;
    
    int delete(String id);
    
    <K, V> List<Map< K, V>> getBmTreePermissions();
    
    <K, V> List<Map< K, V>> getBmTreeParents();
    
    Map<String, Object> getBmTreePermissionById(String id);
    
    <E> List<E> find(Map<String, Object> params) throws ServiceException;

    <E> List<E> findExcelAll();

    Map<String, Object> getConditions(String treeId);

	boolean insertFile(BmFile bmFile);

	boolean deleteFile(String treeId);
	  	
	BmFile findOneFileById(String treeId);
	
	<E> List<E> pageExcelAll();

	void updateExcelCondition(String id);
}
