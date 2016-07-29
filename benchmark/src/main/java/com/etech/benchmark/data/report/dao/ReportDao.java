package com.etech.benchmark.data.report.dao;

import java.util.List;
import java.util.Map;

import com.etech.benchmark.data.MybatisRepository;

@MybatisRepository
public interface ReportDao {
    
    /**
     * create table if not exists
     * @param map
     * @return
     */
    public int createTable(Map<String, Object> map);
    
    /**
     * 新增数据
     * @param map
     * @return
     */
    public int insert(Map<String, Object> map);
    
    /**
     * 根据条件筛选数据
     * @param params
     * @return
     */
    public <E, K, V> List<E> search(Map<String, Object> params);
    
    /**
     * 根据FileId查找数据
     * @param params
     * @return
     */
    public <E, K, V> List<E> findAllByFileId(Map<String, Object> params);
    
    /**
     * 更新Execl数据
     * @param params
     * @return
     */
    public int updateExcelData (Map<String, Object> params);
    
}
