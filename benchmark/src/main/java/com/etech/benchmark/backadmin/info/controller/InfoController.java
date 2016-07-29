package com.etech.benchmark.backadmin.info.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.json.JSONArray;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.etech.benchmark.backadmin.info.service.BmTreeService;
import com.etech.benchmark.backadmin.report.service.ReportService;
import com.etech.benchmark.backadmin.report.service.ReportTemplateService;
import com.etech.benchmark.backadmin.report.service.TableSchemaService;
import com.etech.benchmark.backadmin.sys.service.DictionaryService;
import com.etech.benchmark.constant.Constants;
import com.etech.benchmark.data.info.model.BmFile;
import com.etech.benchmark.data.info.model.BmTree;
import com.etech.benchmark.data.report.model.ReportTemplate;
import com.etech.benchmark.data.ums.model.User;
import com.etech.benchmark.exception.ServiceException;
import com.etech.benchmark.model.ResultEntity;
import com.etech.benchmark.model.ResultEntityHashMapImpl;
import com.etech.benchmark.model.ResultEntityLinkedHashMapImpl;
import com.etech.benchmark.util.ExcelUtil;
import com.etech.benchmark.util.FileUtil;
import com.etech.benchmark.util.StringUtil;


/** 
 * @Description 
 * @author DCJ
 * @date 2015-9-28 下午4:57:12 
 * @version V1.0
 */

@Controller
@RequestMapping("/info")
public class InfoController {

	 private Logger logger = Logger.getLogger(InfoController.class);
	 @Autowired	 
	 private BmTreeService bmTreeService;
	 @Autowired 
	 private DictionaryService dicService;
	 @Autowired  
     private ReportService reportService;
	 @Autowired  
	 private TableSchemaService tableSchemaService;
	 
	 @Resource
     private ReportTemplateService templateService;
	
	 
	 /** 
     *  数据导入页面
     */
    @RequestMapping("/toTree")
    public String toTree(Model model){
        
        List<ReportTemplate> templateList = templateService.listTemplate();
        model.addAttribute("templateList",templateList);
        return "info/tree_view";
    }
    
    /**
     *  树形结构数据
     * @param response
     * @return
     */
    @RequestMapping(value = "/listTree", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity<ResultEntity> listTree(HttpServletResponse response, HttpServletRequest request){
        ResultEntity result = new ResultEntityLinkedHashMapImpl();
        List<Map<String, Object>> content = new ArrayList<Map<String, Object>>();
        try {
            List<BmTree> bmTrees = bmTreeService.find(null);
            if (bmTrees != null) {
                for (BmTree bmTree :bmTrees) {
                    Map<String, Object> node = new HashMap<String, Object>();
                    node.put("id", bmTree.getId());
                    node.put("pId", bmTree.getParent_fk());
                    node.put("name", bmTree.getName());
                    node.put("treeFlag", true);
                    content.add(node);
                }
                
            }
            result.setStatus(ResultEntity.KW_STATUS_SUCCESS);
        } catch (ServiceException e) {
            result.setStatus( ResultEntity.KW_STATUS_FAIL);
            logger.error(e);
        }
        result.setResult(content);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        return new ResponseEntity<ResultEntity>(result, headers, HttpStatus.OK);
    }
	    
	 /**
	  * 实验数据上传
	  * @param file
	  * @param template
	  * @param request
	  * @return
	  */
    @RequestMapping( value = "/data/upload", method = RequestMethod.POST )
    public ResponseEntity<Object> experiment_data_upload (@RequestParam(value="excelFile", required=false) MultipartFile[] excelFiles, 
            @RequestParam(value="template", required=false) String[] templates, 
            @RequestParam(value="otherFile", required=false) MultipartFile[] otherFiles, @RequestParam("categoryId") String categoryId, 
            @RequestParam("categoryName") String categoryName, HttpServletRequest request) {
        ResultEntity result = null;
        try {
            String path = Constants.UPLOAD_PATH;
            User loginUser = (User) request.getSession().getAttribute(Constants.CURRENT_USER);
            
            if (otherFiles != null) {
                for (MultipartFile otherFile : otherFiles) {
                    String filename = otherFile.getOriginalFilename();
                    String ext = filename.substring(filename.lastIndexOf(".") + 1);
                    String filepath =  FileUtil.upload(otherFile, categoryName + "_" +filename, path);
                    
                    BmFile bmFile = new BmFile();
                    bmFile.setId(StringUtil.createUUID());
                    bmFile.setName(categoryName + "_" +filename);
                    bmFile.setTree_id(categoryId);
                    bmFile.setDic_id(0);
                    bmFile.setSave_path(filepath);
                    bmFile.setType(ext);
                    bmFile.setCondition(bmTreeService.getConditions(categoryId).get("conditions").toString());
                    bmFile.setUpdater_fk(loginUser.getId());
                    bmFile.setCreator_fk(loginUser.getId());
                    bmTreeService.insertFile(bmFile);
                }
            }
            
            if (excelFiles != null && templates != null) {
                for (int i = 0; i < excelFiles.length; i++ ) {
                    MultipartFile excelFile = excelFiles[i];
                    String templateId = templates[i];
                    String filename = excelFile.getOriginalFilename();
                    String fileId = StringUtil.createUUID();
                    ReportTemplate template = templateService.getById(templateId);
                    List<Row> rows = ExcelUtil.readExcel(excelFile.getInputStream(), filename, 0);
                    for (int j = 2; j < rows.size(); j++) {
                        Row row = rows.get(j);
                        Row title = rows.get(0);
                        Map<String, Object>  map =  ExcelUtil.rowToMap(title, row, categoryId, templateId, fileId);
                        
                        reportService.insert(map, template.getTable_name());
                    }
                    
                    String ext = filename.substring(filename.lastIndexOf(".") + 1);
                    String filepath =  FileUtil.upload(excelFile, categoryName + "_" +filename, path);
                    
                    BmFile bmFile = new BmFile();
                    bmFile.setId(fileId);
                    bmFile.setName(categoryName + "_" +filename);
                    bmFile.setTree_id(categoryId);
                    bmFile.setOther(templateId);
                    bmFile.setDic_id(template.getTemplate_type());
                    bmFile.setSave_path(filepath);
                    bmFile.setType(ext);
                    bmFile.setCondition(bmTreeService.getConditions(categoryId).get("conditions").toString());
                    bmFile.setUpdater_fk(loginUser.getId());
                    bmFile.setCreator_fk(loginUser.getId());
                    bmTreeService.insertFile(bmFile);
                   
                }
            }
            
            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS,  "success");
        } catch (Exception e) {
            result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_FAIL,  "Internal Server Error");
            e.printStackTrace();
        }
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return new ResponseEntity<Object>(result, headers, HttpStatus.OK);
    }
    
	 /**
     * Excel 数据详情
     * @return
     */
   @RequestMapping("/detail/{id}")
   public String showDetail(@PathVariable String id, Model model){
       BmFile file = bmTreeService.findOneFileById(id);
       ReportTemplate template = templateService.getById(file.getOther());
       Map<String, Object> params = new HashMap<>();
       params.put("treeId", file.getTree_id());
       params.put("fileId", id);
       params.put("tableName", template.getTable_name());
       List<Map<String, Object>> dataList =  reportService.findAllByFileId(params);
       model.addAttribute("dataList", dataList);
       model.addAttribute("tableName", template.getTable_name());
       model.addAttribute("fileId", id);
       model.addAttribute("fileName", file.getName());
       model.addAttribute("category", file.getCondition());
       return "info/info_detail";
   }
   
   /**
    * 更新或新增Execl数据
    * @param response
    * @param treeId
    * @return
    */
   @RequestMapping(value="/excel/update", method=RequestMethod.POST)
   public ResponseEntity<ResultEntity> updateExcelData(@RequestBody Map<String, Object> params){
       ResultEntity result = null;
       HttpHeaders headers = new HttpHeaders();
       headers.setContentType(MediaType.APPLICATION_JSON);
       String tableName = String.valueOf(params.get("tableName"));
       params.remove("tableName");
       String id = String.valueOf( params.get("id") );
       if (StringUtil.isEmpty(id)) {
           params.put("id", StringUtil.createUUID());
           reportService.insert(params, tableName);
           result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS, "新增成功");
       } else {
           reportService.updateExcelData(params, tableName);
           result = new ResultEntityHashMapImpl(ResultEntity.KW_STATUS_SUCCESS, "更新成功");
       }
       
       return new ResponseEntity<ResultEntity>(result, headers, HttpStatus.OK);
   }
	
	/**
	 * 删除文件
	 * @param response
	 * @param treeId
	 * @return
	 */
	@RequestMapping("/{treeId}/deleteFile")
	public ResponseEntity<String> deleteFile(HttpServletResponse response,@PathVariable String treeId){
		JSONObject result = new JSONObject();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        BmFile bmFile = bmTreeService.findOneFileById(treeId);
        boolean flag = bmTreeService.deleteFile(treeId);
        if(flag){
        	FileUtil.deleteFile(Constants.UPLOAD_PATH+File.separatorChar+bmFile.getSave_path());
        	result.put("msg", "success");
        }else{
        	result.put("msg", "删除文件ID："+treeId+"错误！");
        }
		return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
	}
	 
	/**
	 * 新增分类
	 * @param treeId
	 * @param request
	 * @return
	 */
	@RequestMapping("/{treeId}/addCategory")
	public ResponseEntity<String> addCategory(@PathVariable("treeId") String treeId, HttpServletRequest request, @RequestParam(value="category") String category){
	    User loginUser = (User) request.getSession().getAttribute(Constants.CURRENT_USER);
		JSONObject result = new JSONObject();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        try {
            BmTree treeNode = new BmTree();
            treeNode.setId(StringUtil.createUUID());
            treeNode.setParent_fk(treeId);
            treeNode.setName(category);
            treeNode.setUpdater_fk(loginUser.getId());
            treeNode.setCreator_fk(loginUser.getId());
            treeNode.setLevel("-1");
            bmTreeService.insert(treeNode);
            
            Map<String, Object> node = new HashMap<String, Object>();
            node.put("id", treeNode.getId());
            node.put("pId", treeNode.getParent_fk());
            node.put("name", treeNode.getName());
            node.put("treeFlag", true);
            result.put("node", node);
            result.put("status", ResultEntity.KW_STATUS_SUCCESS);
        } catch (ServiceException e) {
            e.printStackTrace();
            result.put("status", ResultEntity.KW_STATUS_FAIL);
        }
       
		return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
	}
	
	
    /**
     * 增加树节点
     * @param model
     * @return
     * @throws ServiceException 
     */
    @RequestMapping("/toAddTree")
    public String toAddTree(Model model) throws ServiceException{
        List<Map<String, Object>> parents = bmTreeService.find(null);
        model.addAttribute("parents", parents);
        return "info/tree_add";
    }
    
    /**
     * 增加树节点操作
     * @param model
     * @return
     */
    @RequestMapping(value = "/addTree", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity<String> addTree(@ModelAttribute BmTree bmTree, HttpServletResponse response, HttpServletRequest request){
        JSONObject result = new JSONObject();
        User loginUser = (User) request.getSession().getAttribute(Constants.CURRENT_USER);
        bmTree.setUpdater_fk(loginUser.getId());
        bmTree.setCreator_fk(loginUser.getId());
        String msg = "";
        try {
        	bmTree.setId(StringUtil.createUUID());
            bmTreeService.insert(bmTree);
            msg = ResultEntity.KW_STATUS_SUCCESS;
        } catch (ServiceException e) {
            msg = ResultEntity.KW_STATUS_FAIL;
            logger.error(e);
        }
        result.put("msg", msg);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
    }  
    
    /**
     * 树 编辑页面
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/{id}/toTreeEdit")
    public String toTreeEdit(Model model, @PathVariable String id){
        BmTree bmTree = bmTreeService.findOne(id);
        model.addAttribute("tree", bmTree);
        return "info/tree_edit";
    }
    
    /**
     * 树 编辑操作
     * @param model
     * @return
     */
    @RequestMapping(value = "/editTree", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity<String> editTree(@ModelAttribute BmTree bmTree, HttpServletResponse response, HttpServletRequest request){
        JSONObject result = new JSONObject();
        User loginUser = (User) request.getSession().getAttribute(Constants.CURRENT_USER);
        String msg = "";
        try {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("name", bmTree.getName());
            params.put("parent_fk", bmTree.getParent_fk());
            params.put("level", bmTree.getLevel());
            params.put("sorter", bmTree.getSorter());
            params.put("updater_fk", loginUser.getId());
            params.put("id", bmTree.getId());
            bmTreeService.update(params);
            bmTreeService.updateExcelCondition(bmTree.getId());
            msg = ResultEntity.KW_STATUS_SUCCESS;
        } catch (ServiceException e) {
            msg = ResultEntity.KW_STATUS_FAIL;
            logger.error(e);
        }
        result.put("msg", msg);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
    }
    
    /***********************************************************************************************************************
     **********************************************************************************************************************/
    /**
     * 多级树形结构数据 (递归)
     * @param response
     * @return
     */
    @RequestMapping(value = "/comboTree", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity<String> comboTree(HttpServletResponse response, HttpServletRequest request){
        JSONArray list = new JSONArray();
        JSONObject result = new JSONObject();
        List<Map<String, Object>> content = new ArrayList<Map<String, Object>>();
       
        try {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("level", 1);
            List<BmTree> menus = bmTreeService.find(params);
            if (menus != null) {
                int size = menus.size();
                
                for (int i = 0; i < size; i++) {
                    Map<String, Object> parent = new HashMap<String, Object>();
                    BmTree menu_1 = menus.get(i);
                    String id = menu_1.getId();
                    String name = menu_1.getName();
                    params.clear();
                    params.put("id", id);
                    List<BmTree> childList = bmTreeService.find(params);
                    parent.put("id", id);
                    parent.put("text", name);
                    if (childList != null && childList.size() > 0) {
                        List<Map<String, Object>> xs = new ArrayList<Map<String, Object>>();
                        findSubTree(childList, xs);
                        parent.put("children", xs);
                    }
                    content.add(parent);
                }
            }
        } catch (ServiceException e) {
            logger.error(e);
        }
        result.put("id", "");
        result.put("text", "请选择父级分类");
        result.put("iconCls","icon-save");
        result.put("children", content);
        list.put(result);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        return new ResponseEntity<String>(list.toString(), headers, HttpStatus.OK);
    }
    
    /**
     * 递归 遍历树子节点
     * @param menus
     * @param sonsMap
     * @throws ServiceException
     */
    private void findSubTree(List<BmTree> menus, List<Map<String, Object>> sonList) throws ServiceException{
         Map<String, Object> params = new HashMap<String, Object>();
         if (menus != null && menus.size() > 0) {
             int size = menus.size();
             for (int i = 0; i < size; i++) {
            	 BmTree menu = menus.get(i);
                 Map<String, Object> son = new HashMap<String, Object>();
                 params.clear();
                 params.put("id", menu.getId());
                 List<BmTree> subs = bmTreeService.find(params); // 判断是否还有子节点
                 son.put("id", menu.getId());
                 son.put("text", menu.getName());
                 if (subs != null && subs.size() != 0) {
                     List<Map<String, Object>> xs = new ArrayList<Map<String, Object>>();
                     findSubTree(subs, xs);
                     son.put("children", xs);
                 }
                 sonList.add(son);
             }
         }
         
    }
	 
}
