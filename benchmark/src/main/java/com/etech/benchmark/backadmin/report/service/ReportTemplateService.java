package com.etech.benchmark.backadmin.report.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.etech.benchmark.backadmin.report.param.ReportTemplateParam;
import com.etech.benchmark.constant.Constants;
import com.etech.benchmark.data.report.dao.ReportTemplateDao;
import com.etech.benchmark.data.report.model.ReportTemplate;
import com.etech.benchmark.exception.ServiceException;
import com.etech.benchmark.exception.UtilException;
import com.etech.benchmark.util.ExcelUtil;
import com.etech.benchmark.util.StringUtil;
import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

@Service
public class ReportTemplateService {
    
    @Resource
    private ReportTemplateDao dao;
    
    @Autowired  
    private ReportService reportService;
    
    @Autowired  
    private TableSchemaService tableSchemaService;
    
    
    /**
     * 根据id获取模板
     * @param id
     * @return
     */
    public ReportTemplate getById(String id) {
        return dao.getById(id);
    }
    
    /**
     * 新增模板
     * @param template
     * @return
     */
   public int addTemplate (ReportTemplate template) {
       return dao.addTemplate(template);
   }
   
   /**
    * 模板分页
    * @param template
    * @param pageBounds
    * @return
    */
   public PageList<ReportTemplate> listTemplate (ReportTemplateParam param) {
       PageBounds pageBounds = new PageBounds();
       pageBounds.setLimit(param.getPageSize());
       pageBounds.setPage(param.getPageNow() + 1);
       if ( !StringUtil.isEmpty(param.getSortString()) ) {
           pageBounds.setOrders(Order.formString(param.getSortString()));
       }
       return dao.listTemplate(param, pageBounds);
   }
   
   /**
    * 获取所有模板数据
    * @param template
    * @return
    */
   public List<ReportTemplate> listTemplate () {
       return dao.listTemplate();
   }
   
   /**
    * 获取所有试验数据模板
    * @param template
    * @return
    */
   public List<ReportTemplate> listDataTemplate () {
       ReportTemplateParam param = new ReportTemplateParam();
       param.setTemplate_type(Constants.DataDictionary.EXPERIMENT_DATA);
       return dao.listTemplate(param);
   }
   
   
   /**
    * 更新模板
    * @param template
    * @return
    */
   public int updateTemplate (ReportTemplate template) {
       return dao.updateTemplate(template);
   }
   
   /**
    * 模板数据导入
    * @param file
    * @param template
 * @throws ServiceException 
    */
   public void importTemplateData (MultipartFile file, ReportTemplate template) throws ServiceException {
       try {
           template.setId(StringUtil.createUUID());
           template.setTable_name("rpt_" + StringUtil.createQUID(16).toLowerCase());
           int type = template.getTemplate_type();
           if (type == 1001) {
               List<Row>  rowList = ExcelUtil.readExcel(file.getInputStream(), file.getOriginalFilename(), 0);
               Map<String, Object> params = ExcelUtil.rowToMap(rowList.get(0), rowList.get(1));
               tableSchemaService.addReportTableColumn(params, template.getId(), template.getTable_name());
               params.put("id", "id");
               params.put("treeId", "treeId");
               params.put("templateId", "templateId");
               params.put("fileId", "fileId");
               reportService.creatTable(params, template.getTable_name());
               dao.addTemplate(template);  
           } else if (type == 1002) {
               List<Row>  rowList = ExcelUtil.readExcel(file.getInputStream(), file.getOriginalFilename(), 0);
               Map<String, Object> params = ExcelUtil.rowToMap(rowList.get(0), rowList.get(1));
               tableSchemaService.addReportTableColumn(params, template.getId(), template.getTable_name());
               params.put("id", "id");
               params.put("treeId", "treeId");
               reportService.creatTable(params, template.getTable_name());
               dao.addTemplate(template);  
           }
           
       } catch (IOException | UtilException e) {
            throw new ServiceException("Excel读取失败");
       }
       
   }
   
   
}
