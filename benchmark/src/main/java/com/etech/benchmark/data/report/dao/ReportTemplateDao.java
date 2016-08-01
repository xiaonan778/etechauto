package com.etech.benchmark.data.report.dao;

import java.util.List;

import com.etech.benchmark.backadmin.report.param.ReportTemplateParam;
import com.etech.benchmark.data.MybatisRepository;
import com.etech.benchmark.data.report.model.ReportTemplate;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

@MybatisRepository
public interface ReportTemplateDao {
    
    /**
     * 新增模板
     * @param template
     * @return
     */
   public int addTemplate (ReportTemplate template);  
   
   /**
    * 模板分页
    * @param template
    * @param pageBounds
    * @return
    */
   public PageList<ReportTemplate> listTemplate (ReportTemplateParam param, PageBounds pageBounds);
   
   /**
    * 获取所有模板数据
    * @param template
    * @return
    */
   public List<ReportTemplate> listTemplate ();
   
   /**
    * 按条件获取模板
    * @param param
    * @return
    */
   public List<ReportTemplate> listTemplate (ReportTemplateParam param);
   
   /**
    * 更新模板
    * @param template
    * @return
    */
   public int updateTemplate (ReportTemplate template);
   
   /**
    * 根据id获取模板
    * @param id
    * @return
    */
   public ReportTemplate getById(String id);
}
