package com.etech.benchmark.backadmin.report.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.etech.benchmark.backadmin.info.service.BmTreeService;
import com.etech.benchmark.backadmin.report.service.ReportService;
import com.etech.benchmark.backadmin.report.service.ReportTemplateService;
import com.etech.benchmark.backadmin.report.service.TableSchemaService;
import com.etech.benchmark.data.report.model.ChartFactor;
import com.etech.benchmark.data.report.model.ReportTemplate;
import com.etech.benchmark.model.ResultEntity;
import com.etech.benchmark.model.ResultEntityHashMapImpl;
import com.etech.benchmark.util.StringUtil;

@Controller
@RequestMapping("/chart")
public class ChartController {
    @Autowired  
    private TableSchemaService tableSchemaService;
    @Autowired 
    private ReportTemplateService reportTemplateService;
    @Autowired  
    private BmTreeService bmTreeService;
    @Resource
    private ReportTemplateService templateService;
    @Autowired  
    private ReportService reportService;
    
    @RequestMapping("/show")
    public String chart_main (Model model, HttpServletRequest request) {
        List<ReportTemplate> templateList = reportTemplateService.listDataTemplate();
        model.addAttribute("templateList", templateList);
        
        if (templateList != null && templateList.size() > 0) {
            List<String> columnList = tableSchemaService.listColumnByTableFk(templateList.get(0).getId());
            
            model.addAttribute("columnList", columnList);
        }
        
        return "report/chart_main";
    }
    
    
    /**
     * 创建报表
     * @return
     */
    @RequestMapping(value="/buildChart", method=RequestMethod.POST)
    public ResponseEntity<Object> searchKeywords (@RequestParam("template") String templateId, @RequestParam String[] queryAttribute, @ModelAttribute ChartFactor chartFactor,
            HttpServletRequest request) {
        ResultEntity result = null;
        String fields = getFields(chartFactor);
        Map<String, Object> params = new HashMap<>();
        List<Object> list = new ArrayList<>();
        List<String> conditionList = new ArrayList<>();
        String conditions = convertQueryParameters(queryAttribute, request);

        ReportTemplate tempalte = templateService.getById(templateId);
        String tableName = tempalte.getTable_name();
        params.put("fields", fields);
        params.put("tableName", tableName);
        if ( !StringUtil.isEmpty(conditions)) {
            params.put("conditions", conditions);
        }
        List<Map<String, Object>> groups = reportService.searchGroup(params);
        
        for (Map<String, Object> map : groups) {
            String treeId = String.valueOf(map.get("treeId"));
            params.put("treeId", treeId);
            List<Map<String, Object>> data = reportService.search(params);
            list.add(data);
            String condition = String.valueOf( bmTreeService.getConditions(treeId).get("conditions") );
            conditionList.add(condition);
        }
      
        
        
        
        result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS,  "success");
        result.addObject("list", list);
        result.addObject("conditionList", conditionList);
        result.addObject("chartFactor", chartFactor);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return new ResponseEntity<Object>(result, headers, HttpStatus.OK);
    }
    
    /**
     * 拼接查询条件
     * @param queryAttribute
     * @param request
     * @return
     */
    private String convertQueryParameters(String[] queryAttribute, HttpServletRequest request) {
        String conditions = null;
        for (String attr : queryAttribute) {
            String rule = request.getParameter(attr + "_rule");
            if ("1".equals(rule)) {
                String eq = request.getParameter(attr + "_eq");
                if ( !StringUtil.isEmpty(eq) ) {
                    conditions = conditions != null ? conditions + " and " + attr + "='" + eq + "'":  attr + "='" + eq + "'";
                } else {
                    continue;
                }
            } else if ( "2".equals(rule)) {
                String gt = request.getParameter(attr + "_gt");
                String lt = request.getParameter(attr + "_lt");
                
                if ( !StringUtil.isEmpty(gt) && StringUtil.isEmpty(lt) ) {
                    conditions = conditions != null ? conditions + " and " + attr + ">'" + gt + "'":  attr + ">'" + gt + "'";
                } else if ( StringUtil.isEmpty(gt) && !StringUtil.isEmpty(lt) ) {
                    conditions = conditions != null ? conditions + " and " + attr + "<'" + lt + "'":  attr + "<'" + lt + "'";
                } else if ( !StringUtil.isEmpty(gt) && !StringUtil.isEmpty(lt) ) {
                    conditions = conditions != null ? conditions + " and " + attr + ">'" + gt + "'  and " + attr + "<'" + lt + "'": 
                        attr + ">'" + gt + "'  and " + attr + "<'" + lt + "'";
                } else {
                    continue;
                }
            }
        }
        
        return conditions;
    }
    
    /**
     * 获取查询字段拼接
     * @param chartFactor
     * @return
     */
    private String getFields (ChartFactor chartFactor) {
        String result = "";
        if (chartFactor != null ) {
            if (StringUtil.notEmpty(chartFactor.getxAxis()) ) {
                result = chartFactor.getxAxis();
                chartFactor.setxAxisUnit(tableSchemaService.getUnit(chartFactor.getxAxis()));
                if (StringUtil.notEmpty(chartFactor.getyAxis()) ) {
                    result = result + ", " + chartFactor.getyAxis() ;
                    chartFactor.setyAxisUnit(tableSchemaService.getUnit(chartFactor.getyAxis()));
                    if (StringUtil.notEmpty(chartFactor.getzAxis()) ) {
                        chartFactor.setzAxisUnit(tableSchemaService.getUnit(chartFactor.getzAxis()));
                        result = result + ", " + chartFactor.getzAxis() ;
                    }
                }
            }
        }
        return result;
    }
}
