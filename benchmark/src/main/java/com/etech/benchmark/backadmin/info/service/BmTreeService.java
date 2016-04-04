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
	  	
	<E> List<E> pageExcelAll();

	void updateExcelCondition(String id);
	
	/**
	 * 获取一个树节点下的文件列表
	 * @param treeId
	 * @return
	 */
	List<BmFile> getExcelByTreeId (String treeId);
	
	/**
	 * 根据ID获取文件信息
	 * @param fileId
	 * @return
	 */
	BmFile findOneFileById(String fileId);
	
	/**
     * 根据关键字搜索文件
     * @param keywords
     * @return
     */
    List<BmFile> searchByCondition(String keywords);
}
