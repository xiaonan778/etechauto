package com.etech.benchmark.backadmin.report.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
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
import com.etech.benchmark.backadmin.report.service.TableSchemaService;
import com.etech.benchmark.backadmin.sys.service.DictionaryService;
import com.etech.benchmark.constant.Constants;
import com.etech.benchmark.data.info.model.BmFile;
import com.etech.benchmark.data.report.model.ChartFactor;
import com.etech.benchmark.data.sys.model.SysDataDictionary;
import com.etech.benchmark.model.ResultEntity;
import com.etech.benchmark.model.ResultEntityHashMapImpl;
import com.etech.benchmark.util.StringUtil;

@Controller
@RequestMapping("/report")
public class ReportController {
    
    
    @Autowired 
    private DictionaryService dicService;
    @Autowired  
    private ReportService reportService;
    @Autowired  
    private BmTreeService bmTreeService;
    @Autowired  
    private TableSchemaService tableSchemaService;
    
    /**
     * 柱状图
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/bar")
    public String bar(HttpServletRequest request, Model model){
        List<SysDataDictionary> list = dicService.findDictionaryByCode(Constants.DataDictionary.REPORT);
        model.addAttribute("tableList", list);
        return "report/chart_bar";
    }
    
    /**
     * 柱状图 生成报表 数据
     * @param response
     * @param tableName
     * @param alpha_min
     * @param alpha_max
     * @return
     */
    @RequestMapping(value = "/getMaxTorqueByAlpha", method = RequestMethod.GET )
    public ResponseEntity<String> getMaxTorqueByAlpha(HttpServletResponse response, @RequestParam String[] tableName, @RequestParam String alpha_min,
            @RequestParam String alpha_max) {
        JSONObject result = new JSONObject();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        
        if (tableName == null || tableName.length ==0) {
            result.put("status", "F");
            result.put("msg", "数据标识不可为空");
            return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
        }
        alpha_min = "".equals(alpha_min) ? "0" :  alpha_min;
        alpha_max = "".equals(alpha_max) ? "100" :  alpha_max;
        
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("alpha_min", alpha_min);
        params.put("alpha_max", alpha_max);
        List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
        for (String table: tableName){
            Map<String, Object> record = reportService.getMaxTorqueByAlpha(params, table);
            record.put("tableName", table);
            results.add(record);
        }
        result.put("result", results);
        result.put("status", "S");
        result.put("msg", "success");
        return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
    }
    
    /**
     * 散点图
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/scatter")
    public String scatter(HttpServletRequest request, Model model){
        List<SysDataDictionary> list = dicService.findDictionaryByCode(Constants.DataDictionary.REPORT);
        model.addAttribute("tableList", list);
        return "report/chart_scatter";
    }
    
    /**
     * 散点图 生成报表 数据
     * @param response
     * @param tableName
     * @param alpha_min
     * @param alpha_max
     * @return
     */
    @RequestMapping(value = "/listByAlpha", method = RequestMethod.GET )
    public ResponseEntity<String> listByAlpha(HttpServletResponse response, @RequestParam String[] tableName, @RequestParam String alpha_min,
            @RequestParam String alpha_max) {
        JSONObject result = new JSONObject();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        
        if (tableName == null || tableName.length ==0) {
            result.put("status", "F");
            result.put("msg", "数据标识不可为空");
            return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
        }
        alpha_min = "".equals(alpha_min) ? "0" :  alpha_min;
        alpha_max = "".equals(alpha_max) ? "100" :  alpha_max;
        
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("alpha_min", alpha_min);
        params.put("alpha_max", alpha_max);
        List<Object> results = new ArrayList<Object>();
        for (String table: tableName){
            Map<String, Object> item = new HashMap<String, Object>();
            List<Map<String, Object>> records = reportService.listByAlpha(params, table);
            item.put("list", records);
            item.put("type", table);
            results.add(item);
        }
        result.put("result", results);
        result.put("status", "S");
        result.put("msg", "success");
        return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
    }
    
    /**
     * 报表展示页面
     * @param mdel
     * @return
     */
    @RequestMapping("/report_main")
    public String report_main (Model mdel) {
        
        
        return "report/report_main";
    }
    
    /**
     * 搜索关键字
     * @return
     */
    @RequestMapping(value="/searchKeywords", method=RequestMethod.GET)
    public ResponseEntity<Object> searchKeywords (@RequestParam String keywords,  HttpServletRequest request) {
        ResultEntity result = null;
        List<BmFile> excelList =  bmTreeService.searchByCondition(keywords);
        if (excelList != null && excelList.size() > 0) {
            Set<Integer> templateList = new HashSet<Integer>();
            for (BmFile file : excelList) {
                int dic = file.getDic_id();
                templateList.add(dic);
            }
          
            Set<String> columnSet = new HashSet<>();
            for (int dicId : templateList ) {
                SysDataDictionary dict = dicService.findSysDataDicById(dicId);
                String tableName = dict.getRule();
                if (!StringUtil.isEmpty(tableName)) {
                    if ( tableSchemaService.checkTableIfExists(tableName) ) {
                        List<String> columnTempList =  tableSchemaService.listColumnByTableFk(dicId);
                        if (columnSet.size() == 0) {
                            columnSet.addAll( columnTempList );
                        } else {
                            columnSet.retainAll(columnTempList);
                        }
                    }
                }
            }
            List<String> columnList = new ArrayList<>();
            columnList.addAll(columnSet);
            Collections.sort(columnList);
            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS,  "success");
            result.addObject("excelList", excelList);
            result.addObject("columnList", columnList);
        } else {
            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL,  "查无结果");
        }
        
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return new ResponseEntity<Object>(result, headers, HttpStatus.OK);
    }
    
    
    /**
     * 创建报表
     * @return
     */
    @RequestMapping(value="/buildChart", method=RequestMethod.POST)
    public ResponseEntity<Object> searchKeywords (@RequestParam("fileId") String[] fileIds, @RequestParam String[] queryAttribute, @ModelAttribute ChartFactor chartFactor,
            HttpServletRequest request) {
        ResultEntity result = null;
        String fields = getFields(chartFactor);
        Map<String, Object> params = new HashMap<>();
        List<Object> list = new ArrayList<>();
        List<String> conditionList = new ArrayList<>();
        String conditions = convertQueryParameters(queryAttribute, request);
        for (String fileId : fileIds) {
            BmFile excel = bmTreeService.findOneFileById(fileId);
            int tableId = excel.getDic_id();
            SysDataDictionary sysData = dicService.findSysDataDicById(tableId);
            String tableName = sysData.getRule();
            params.put("fields", fields);
            params.put("tableName", tableName);
            if ( !StringUtil.isEmpty(conditions)) {
                params.put("conditions", conditions);
            }
            List<Map<String, Object>> data = reportService.search(params);
            list.add(data);
            String condition = excel.getCondition();
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
