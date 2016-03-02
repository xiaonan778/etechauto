package com.etech.benchmark.backadmin.sys.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.etech.benchmark.backadmin.sys.model.PermissionParam;
import com.etech.benchmark.backadmin.sys.service.PermissionService;
import com.etech.benchmark.constant.Constants;
import com.etech.benchmark.data.model.ResultEntity;
import com.etech.benchmark.data.model.ResultEntityHashMapImpl;
import com.etech.benchmark.data.page.Page;
import com.etech.benchmark.data.sys.model.Permission;
import com.etech.benchmark.data.ums.model.User;
import com.etech.benchmark.exception.ServiceException;


@Controller
@RequestMapping("/permission")
public class PermissionController {
    private Logger logger = Logger.getLogger(PermissionController.class);
    
    @Autowired
    private PermissionService permissionService;
    
    /**
     * 权限列表
     * @return
     */
    @RequestMapping("/list")
    public String tolist(){
        
        return "sys/permission_list";
    }
    
    /**
     * 权限分页
     * @param param
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/page", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity<ResultEntity> page(@RequestBody PermissionParam param, HttpServletResponse response, HttpServletRequest request){
        ResultEntity result = null;
        try {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("name", param.getName());
            params.put("isValid", param.getIsValid());
            params.put("type", param.getType());
            Page<Map<String, Object>> pageMap = permissionService.page(params, param.getPageNow() + 1, param.getPageSize());
            if (pageMap != null) {
                result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS, "success");
                result.addObject("list", pageMap.getRows());
                result.addObject("totalSize", pageMap.getTotal());
            } else {
                result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL, "search fail!");
            }
        } catch (ServiceException e) {
            logger.error(e);
            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL, "Internal Server Error!");
        }
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        return new ResponseEntity<ResultEntity>(result, headers, HttpStatus.OK);
    }
    
    /**
     * 新增权限
     * @return
     */
    @RequestMapping("/toAdd")
    public String toAddPermission(){
        
        return "sys/permission_add";
    }
    
    /**
     * 权限新增操作
     * @param model
     * @return
     */
    @RequestMapping(value = "/add", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity<String> add(@ModelAttribute Permission permission, HttpServletResponse response, HttpServletRequest request){
        JSONObject result = new JSONObject();
        User loginUser = (User) request.getSession().getAttribute(Constants.CURRENT_USER);
        permission.setCreator_fk(loginUser.getId());
        permission.setUpdater_fk(loginUser.getId());
        String msg = "";
        try {
            permissionService.insert(permission);
            msg = ResultEntity.KW_STATUS_SUCCESS;
        } catch (ServiceException e) {
            logger.error(e);
            msg = ResultEntity.KW_STATUS_FAIL;
        }
        
        result.put("msg", msg);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
    }
    
    /**
     * 权限详情
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/{id}/detail")
    public String detail(Model model, @PathVariable String id){
        try {
            Map<String, Object> permission = permissionService.findOne(id);
            model.addAttribute("permission", permission);
        } catch (ServiceException e) {
            logger.error(e);
            
        }
        
        return "sys/permission_detail";
    }
    
    /**
     * 编辑权限
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/{id}/toEdit")
    public String toEdit(Model model, @PathVariable String id){
        try {
            Map<String, Object> permission = permissionService.findOne(id);
            model.addAttribute("permission", permission);
        } catch (ServiceException e) {
            logger.error(e);
            
        }
        return "sys/permission_edit";
    }
    
    /**
     * 权限编辑操作
     * @param model
     * @return
     */
    @RequestMapping(value = "/edit", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity<String> edit(@ModelAttribute Permission permission, HttpServletResponse response, HttpServletRequest request){
        JSONObject result = new JSONObject();
        User loginUser = (User) request.getSession().getAttribute(Constants.CURRENT_USER);
        permission.setUpdater_fk(loginUser.getId());
        String msg = "";
        try {
            permissionService.update(permission);
            msg = ResultEntity.KW_STATUS_SUCCESS;
        } catch (ServiceException e) {
            logger.error(e);
            msg = ResultEntity.KW_STATUS_FAIL;
        }
        
        result.put("msg", msg);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
    }
}
