package com.etech.benchmark.backadmin.info.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etech.benchmark.backadmin.info.service.BmTreeService;
import com.etech.benchmark.data.info.dao.BmFileDao;
import com.etech.benchmark.data.info.dao.BmTreeDao;
import com.etech.benchmark.data.info.model.BmFile;
import com.etech.benchmark.data.info.model.BmTree;
import com.etech.benchmark.exception.ServiceException;

@Service
public class BmTreeServiceImpl implements BmTreeService {
    
    @Autowired private BmTreeDao bmTreeDao;
    @Autowired private BmFileDao bmFileDao;
    
    @Override
    public int insert(BmTree bmTree) throws ServiceException {
        return bmTreeDao.insert(bmTree);
    }

    @Override
    public int update(Map<String, Object> params) throws ServiceException{
        return bmTreeDao.update(params);
    }

    @Override
    public BmTree findOne(String id) {
        return bmTreeDao.findOne(id);
    }

    @Override
    public <E> List<E> listAll(Map<String, Object> params) throws ServiceException{
        return bmTreeDao.listAll(params);
    }

    @Override
    public int delete(String id) {
        return bmTreeDao.delete(id);
    }

    @Override
    public <K, V> List<Map< K, V>> getBmTreePermissions() {
        return bmTreeDao.getBmTreePermissions();
    }

    @Override
    public <K, V> List<Map<K, V>> getBmTreeParents() {
        return bmTreeDao.getBmTreeParents();
    }

    @Override
    public Map<String, Object> getBmTreePermissionById(String id) {
        return bmTreeDao.getBmTreePermissionById(id);
    }
    
    @Override
    public <E> List<E> find(Map<String, Object> params) {
        return bmTreeDao.find(params);
    }

	@Override
	public <E> List<E> findExcelAll() {
		return bmFileDao.find(null);
	}

	@Override
	public Map<String, Object> getConditions(String treeId) {
		return bmFileDao.getConditions(treeId);
	}
		
	@Override
	public boolean insertFile(BmFile bmFile) {
	    
	    
		return bmFileDao.insertExcel(bmFile);
	}

	@Override
	public boolean deleteFile(String treeId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", treeId);
		return bmFileDao.deleteFile(params);
	}

	@Override
	public <E> List<E> pageExcelAll() {
		return bmFileDao.page(null);
	}

	@Override
	public void updateExcelCondition(String treeId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("treeId", treeId);
		bmFileDao.updateExcelCondition(params);
	}

    @Override
    public List<BmFile> getExcelByTreeId(String treeId) {
        return bmFileDao.getExcelByTreeId(treeId);
    }

    @Override
    public BmFile findOneFileById(String fileId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", fileId);
        return bmFileDao.findOne(params);
    }
    
    @Override
    public List<BmFile> searchByName(String keywords) {
        return bmFileDao.searchByName(keywords);
    }


}
