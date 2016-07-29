package com.etech.benchmark.backadmin.report.controller;

import java.util.List;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.etech.benchmark.backadmin.report.param.ReportTemplateParam;
import com.etech.benchmark.backadmin.report.service.ReportTemplateService;
import com.etech.benchmark.backadmin.sys.service.DictionaryService;
import com.etech.benchmark.constant.Constants;
import com.etech.benchmark.data.report.model.ReportTemplate;
import com.etech.benchmark.data.sys.model.SysDataDictionary;
import com.etech.benchmark.data.ums.model.User;
import com.etech.benchmark.exception.ServiceException;
import com.etech.benchmark.model.ResultEntity;
import com.etech.benchmark.model.ResultEntityHashMapImpl;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

@Controller
@RequestMapping("/template")
public class ReportTemplateController {
    
    @Resource
    private ReportTemplateService templateService;
    
    @Autowired
    private DictionaryService dicService;
    
    @RequestMapping( "/toList")
    public String toTemplateListPage(Model model) {
        List<SysDataDictionary> dicList = dicService.findDictionaryByCode(Constants.DataDictionary.TEMPLATE_TYPE);
        model.addAttribute("dicList", dicList);
        return "report/template_list";
    }
    
    @RequestMapping( value = "/list", method = RequestMethod.POST )
    public ResponseEntity<Object> templateListData (@RequestBody ReportTemplateParam param) {
        ResultEntity result = null;
        PageList<ReportTemplate> list =  templateService.listTemplate(param);
        
        result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS,  "success");
        result.addObject("recordsTotal", list.getPaginator().getTotalCount());
        result.addObject("recordsFiltered", list.getPaginator().getTotalCount());
        result.addObject("data", list);
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return new ResponseEntity<Object>(result, headers, HttpStatus.OK);
    } 
    
    @RequestMapping( value = "/upload", method = RequestMethod.POST )
    public ResponseEntity<Object> template_upload (@RequestParam(value="template_excel") MultipartFile file, @ModelAttribute ReportTemplate template, HttpServletRequest request) {
        ResultEntity result = null;
        try {
            User loginUser = (User) request.getSession().getAttribute(Constants.CURRENT_USER);
            template.setCreator_fk(loginUser.getId());
            template.setUpdater_fk(loginUser.getId());
            templateService.importTemplateData(file, template);
            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS,  "success");
        } catch (ServiceException e) {
            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL,  e.getMessage());
            e.printStackTrace();
        }  catch (Exception e) {
            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL,  "Internal Server Error");
            e.printStackTrace();
        }
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return new ResponseEntity<Object>(result, headers, HttpStatus.OK);
    }
}
