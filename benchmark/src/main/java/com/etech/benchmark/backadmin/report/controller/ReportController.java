package com.etech.benchmark.backadmin.report.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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

import com.etech.benchmark.backadmin.info.service.BmTreeService;
import com.etech.benchmark.constant.Constants;
import com.etech.benchmark.data.info.model.BmFile;
import com.etech.benchmark.model.ResultEntity;
import com.etech.benchmark.model.ResultEntityHashMapImpl;

@Controller
@RequestMapping("/report")
public class ReportController {
    
   
    @Autowired  
    private BmTreeService bmTreeService;
    
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
        List<BmFile> excelList =  bmTreeService.searchByName(keywords);
        if (excelList != null && excelList.size() > 0) {

            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS,  "success");
            result.addObject("excelList", excelList);
            result.addObject("filepath", Constants.FILEPATH_PREFIX);
        } else {
            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL,  "查无结果");
        }
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return new ResponseEntity<Object>(result, headers, HttpStatus.OK);
    }
    
}
