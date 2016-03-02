package com.etech.benchmark.backadmin.report.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.etech.benchmark.backadmin.report.service.ReportService;
import com.etech.benchmark.backadmin.sys.service.DictionaryService;
import com.etech.benchmark.constant.Constants;
import com.etech.benchmark.data.sys.model.SysDataDictionary;
import com.etech.benchmark.exception.UtilException;
import com.etech.benchmark.util.ExcelUtil;

@Controller
@RequestMapping("/report")
public class ReportController {
    
    private Logger logger = LoggerFactory.getLogger(ReportController.class);
    
    @Autowired 
    private DictionaryService dicService;
    
    @Autowired  
    private ReportService reportService;
    
    /**
     * 数据导入 页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/toDataImport")
    public String toDataImport(HttpServletRequest request, Model model) {
        List<SysDataDictionary> list = dicService.findDictionaryByCode(Constants.DataDictionary.REPORT);
        model.addAttribute("tableList", list);
        return "report/data_import";
    }
    
    /**
     * 数据导入
     * @param myfiles
     * @param response
     * @param tableName
     * @return
     * @throws UtilException
     */
    @RequestMapping(value = "/dataImport", method = RequestMethod.POST )
    public ResponseEntity<String> dataImport(@RequestParam("excel") MultipartFile[] myfiles, HttpServletResponse response, @RequestParam String tableName) throws UtilException{
        JSONObject result = new JSONObject();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        for (int i = 0; i < myfiles.length; i++) {
            MultipartFile file = myfiles[i];
            String filename = file.getOriginalFilename();
            if (!file.isEmpty()) {
                try {
                    Row rowTitle = ExcelUtil.readRow(file.getInputStream(), filename, 0, 0);
                    
                    if(rowTitle==null){
                        result.put("msg", "无数据或不是Excel文件!");
                        result.put("status", "F");
                        return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
                    }
                    List<Row>  rowList = ExcelUtil.readExcel(file.getInputStream(), filename, 0);
                    for ( int j = 0; j < rowList.size(); j++) {
                        if (j <= 1 ) {
                            continue;
                        }
                        Map<String, Object> params = ExcelUtil.rowToMap(rowTitle, rowList.get(j));
                        reportService.creatTable(params, tableName);
                        
                        reportService.insert(params, tableName);
                    }
                } catch (IOException e) {
                    logger.error(e.getMessage());
                }
            }
        }
        result.put("status", "S");
        result.put("msg", "success");
        return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
    }
    
    
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
}
