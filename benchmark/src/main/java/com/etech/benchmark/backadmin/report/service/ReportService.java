package com.etech.benchmark.backadmin.report.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etech.benchmark.data.report.dao.ReportDao;

@Service
public class ReportService {
    
    @Autowired
    private ReportDao reportDao;
    
    /**
     * create table if not exists
     * @param params
     * @param tableName
     * @return
     */
    public int creatTable(Map<String, Object> params, String tableName) {
        
        String[] keys = new String[params.size()];
        Set<String> sset = params.keySet();
        int i = 0;
        for (String os : sset) {
            keys[i++] = os;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tablename", tableName);
        map.put("keys", keys);
        
        return reportDao.createTable(map);
    }
    
    /**
     * 新增数据
     * @param params
     * @param tableName
     * @return
     */
    public int insert(Map<String, Object> params, String tableName) {
        
        String[] keys = new String[params.size()];
        Set<String> sset = params.keySet();
        int i = 0;
        for (String os : sset) {
            keys[i++] = os;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tablename", tableName);
        map.put("keys", keys);
        map.put("params", params);
        
        return reportDao.insert(map);
    }
   
    /**
     * 根据条件筛选数据
     * @param params
     * @return
     */
    public <E, K, V> List<E> search(Map<String, Object> params) {
        return reportDao.search(params);
    }
    
    /**
     * 根据条件筛选数据
     * @param params
     * @return
     */
    public <E, K, V> List<E> searchGroup(Map<String, Object> params) {
        return reportDao.searchGroup(params);
    }

    /**
     * 根据FileId查找数据
     * @param params
     * @return
     */
    public <E, K, V> List<E> findAllByFileId(Map<String, Object> params) {
        return reportDao.findAllByFileId(params);
    }

    /**
     * 更新Execl数据
     * @param params
     * @return
     */
    public int updateExcelData(Map<String, Object> params, String tableName) {
        String[] keys = new String[params.size() - 2];
        Set<String> fieldSet = params.keySet();
        int i = 0;
        for (String field : fieldSet) {
            if ("id".equals(field)) {
                continue;
            }
            if ("fileId".equals(field)) {
                continue;
            }
            keys[i++] = field;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tablename", tableName);
        map.put("keys", keys);
        map.put("params", params);
        map.put("id", params.get("id"));
        return reportDao.updateExcelData(map);
    }

}
