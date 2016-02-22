package com.etech.benchmark.backadmin.sys.controller;


import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import com.etech.benchmark.backadmin.sys.model.RoleParam;
import com.etech.benchmark.backadmin.sys.service.DictionaryService;
import com.etech.benchmark.data.sys.model.SysData;
import com.etech.benchmark.data.sys.model.SysDataDictionary;
import com.etech.benchmark.page.Page;
import com.etech.benchmark.util.StringUtil;
import com.etech.benchmark.web.entity.ResultEntity;
import com.etech.benchmark.web.entity.ResultEntityHashMapImpl;


/**
 * 
 * @author DCJ
 */
@Controller
@RequestMapping(value="/dic")
public class DictionaryController {
	
	@Autowired
    private DictionaryService dicService;
	
	/**
	 * 数据字典父类
	 * @return
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(){
		ModelAndView mav = new ModelAndView("/sys/dic_father_list");
		return mav;
	}
	
    /**
     * 获取数据字典有效父类
     * @param param
     * @param request
     * @param builder
     * @return
     */
    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public ResponseEntity<ResultEntity> search(@RequestBody RoleParam param, HttpServletRequest request, UriComponentsBuilder builder) {
        ResultEntity result = null;
        try {
            Page<Map<String, Object>> pageMap = dicService.page( param.getPageNow() + 1, param.getPageSize());
            if (pageMap != null) {
                result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS, "success");
                result.addObject("list", pageMap.getRows());
                result.addObject("totalSize", pageMap.getTotal());
            } else {
                result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL, "search fail!");
            }

        } catch (Exception e) {
            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL, "Internal Server Error!");
            e.printStackTrace();
        }
        
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(builder.path("/dic/search").buildAndExpand().toUri());
        return new ResponseEntity<ResultEntity>(result, headers, HttpStatus.OK);
    }
    
    /**
     * 字典数据
     */
    
    @RequestMapping(value = "/{id}/sonlist")
	public ModelAndView sonlist(@PathVariable String id){
		ModelAndView mv = new ModelAndView("/sys/dic_son_list");
		SysData sysdata = dicService.findSysDataById(Integer.parseInt(id));
		mv.addObject("sysdata", sysdata);
		return mv;
	}
    
    /**
     * 单笔数据
     */ 
    @RequestMapping(value = "/son/search/{id}", method = RequestMethod.POST)
    public ResponseEntity<ResultEntity> sonsearch(@PathVariable String id, @RequestBody RoleParam param, HttpServletRequest request, UriComponentsBuilder builder) {
        ResultEntity result = null;
        try {
        	Map<String, Object> params = new HashMap<String, Object>();
            params.put("data_fk", id);
            Page<Map<String, Object>> pageMap = dicService.sonpage( params ,param.getPageNow() + 1, param.getPageSize());
            if (pageMap != null) {
                result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS, "success");
                result.addObject("list", pageMap.getRows());
                result.addObject("totalSize", pageMap.getTotal());
            } else {
                result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL, "search fail!");
            }

        } catch (Exception e) {
            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL, "Internal Server Error!");
            e.printStackTrace();
        }
        
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(builder.path("/son/search/"+id).buildAndExpand().toUri());
        return new ResponseEntity<ResultEntity>(result, headers, HttpStatus.OK);
    }
    
    
    
    /**
     * 新建数据
     */
    @RequestMapping(value = "/{id}/soncreate")
    public ModelAndView create(@PathVariable String id, HttpServletRequest request) throws IOException {
        ModelAndView mv = new ModelAndView("sys/dic_son");
        int dicId = Integer.parseInt(id);
        SysData sysdata = dicService.findSysDataById(dicId);
        Map<String,Object> maxMap = dicService.findMaxIdSort(dicId);
        SysDataDictionary dicdata = new SysDataDictionary();
        dicdata.setValid((byte) 1);
        dicdata.setId(Integer.parseInt(maxMap.get("max_id").toString()));
        dicdata.setSort(Integer.parseInt(maxMap.get("max_sort").toString()));
        mv.addObject("sysdata", sysdata);
        mv.addObject("dicdata", dicdata);
        mv.addObject("action", "SAVE");
        return mv;
    }
    
    /**
     * 编辑数据
     */
    @RequestMapping(value = "/{id}/sonedit")
    public ModelAndView edit(@PathVariable String id, HttpServletRequest request, HttpServletResponse response) throws IOException {
    	SysDataDictionary dicdata = new SysDataDictionary();
        ModelAndView mv = new ModelAndView("sys/dic_son");
        if (StringUtil.notEmpty(id)) {
        	dicdata = dicService.findSysDataDicById(Integer.parseInt(id));
            if (dicdata == null) {
                response.sendError(HttpStatus.NOT_FOUND.value());
                return null;
            }
        } else {
            response.sendError(HttpStatus.NOT_FOUND.value());
            return null;
        }
        SysData sysdata = dicService.findSysDataById(dicdata.getDataFk());
        mv.addObject("sysdata", sysdata);
        mv.addObject("dicdata", dicdata);
        mv.addObject("action", "EDIT");
        return mv;
    }
    
    
    /**
     * insert
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ResponseEntity<ResultEntity> save(SysDataDictionary dicdata, HttpServletRequest request, UriComponentsBuilder builder) {
        ResultEntity result = null;
        int flag = dicService.dicDataInsert(dicdata);
        if(flag>0){
        	result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS, "新增数据成功");
        }else{
        	result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL, "新增数据失败");
        }
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(builder.path("/dic/save").buildAndExpand().toUri());
        return new ResponseEntity<ResultEntity>(result, headers, HttpStatus.OK);
    }
    
    
    /**
     * update
     */
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public ResponseEntity<ResultEntity> edit(SysDataDictionary dicdata, HttpServletRequest request, UriComponentsBuilder builder) {
        ResultEntity result = null;
        int flag = dicService.dicDataUpdate(dicdata);
        if(flag>0){
        	result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS, "数据更新成功");
        }else{
        	result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL, "数据更新失败");
        }
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(builder.path("/dic/edit").buildAndExpand().toUri());
        return new ResponseEntity<ResultEntity>(result, headers, HttpStatus.OK);
    }
	
	
	
}
