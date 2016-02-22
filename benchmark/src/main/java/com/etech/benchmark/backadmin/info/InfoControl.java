
/**   
 * @Title: InfoCateControl.java 
 * @Package: com.etech.benchmark.backadmin.info 
 * @Description: TODO
 * @author DCJ  
 * @date 2015-9-28 下午4:57:12 
 * @version 1.0 
 */


package com.etech.benchmark.backadmin.info;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.etech.benchmark.backadmin.info.service.BmTreeService;
import com.etech.benchmark.backadmin.sys.service.DictionaryService;
import com.etech.benchmark.constant.Constants;
import com.etech.benchmark.data.info.model.BmExcel;
import com.etech.benchmark.data.info.model.BmTree;
import com.etech.benchmark.data.sys.model.SysDataDictionary;
import com.etech.benchmark.data.ums.model.User;
import com.etech.benchmark.exception.ServiceException;
import com.etech.benchmark.util.DateUtil;
import com.etech.benchmark.util.ExcelUtil;
import com.etech.benchmark.util.FileUtil;
import com.etech.benchmark.util.StringUtil;
import com.etech.benchmark.web.entity.ResultEntity;
import com.etech.benchmark.web.entity.ResultEntityLinkedHashMapImpl;


/** 
 * @Description 
 * @author DCJ
 * @date 2015-9-28 下午4:57:12 
 * @version V1.0
 */

@Controller
@RequestMapping("/info")
public class InfoControl {

	 private Logger logger = Logger.getLogger(InfoControl.class);
	 @Autowired	 private BmTreeService bmTreeService;
	 @Autowired private DictionaryService dicService;
	 
	 
	@RequestMapping("/listall")
    public String listall(){
//		List<SysDataDictionary> dicList = dicService.findDictionaryByCode(Constants.DataDictionary.EXML);
//		model.addAttribute("dicList",dicList);
        return "info/info_list";
    }
	
//    @RequestMapping(value = "/list", produces = MediaType.APPLICATION_JSON_VALUE)
	@RequestMapping(value = "/list")
    public ResponseEntity<Map<String, Object>> getData(){
        Map<String, Object> result = new HashMap<String, Object>();
        List<Object> all = new ArrayList<Object>();
        List<BmExcel> bmList  = bmTreeService.pageExcelAll();
        for (BmExcel bmExcel : bmList) {
        	Map<String, Object> row = new HashMap<String, Object>();
        	row.put("name", bmExcel.getName());
        	row.put("modal", bmExcel.getModal());
        	row.put("path", Constants.UPLOAD_PATH+"/"+bmExcel.getSave_path());
        	row.put("type", bmExcel.getType());
        	row.put("condition", bmExcel.getCondition());
        	row.put("addtime", DateUtil.dateToStringFull(bmExcel.getDate_create()));
        	row.put("fileuri", Constants.FILEPATH_PREFIX+File.separator+bmExcel.getSave_path());
        	all.add(row);
		}
        result.put("data", all);
        HttpHeaders header = new HttpHeaders();
        header.setContentType(MediaType.APPLICATION_JSON);
        ResponseEntity<Map<String, Object>> entity = new ResponseEntity<Map<String, Object>>(result, header, HttpStatus.OK);
        return entity;
    }
	 
	@RequestMapping("/{treeId}/deleteFile")
	public ResponseEntity<String> deleteFile(HttpServletResponse response,@PathVariable String treeId){
		JSONObject result = new JSONObject();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        BmExcel bmExcel = bmTreeService.findOneFileById(treeId);
        boolean flag = bmTreeService.deleteFile(treeId);
        if(flag){
        	FileUtil.deleteFile(Constants.UPLOAD_PATH+File.separatorChar+bmExcel.getSave_path());
        	result.put("msg", "success");
        }else{
        	result.put("msg", "删除文件ID："+treeId+"错误！");
        }
		return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
	}
	 
	@RequestMapping("/{treeId}/fileUpload")
	public ResponseEntity<String> fileUpload(@RequestParam("excel") MultipartFile[] myfiles, HttpServletResponse response,@PathVariable String treeId,HttpServletRequest request){
		JSONObject result = new JSONObject();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        response.setCharacterEncoding("UTF-8");
        User loginUser = (User) request.getSession().getAttribute(Constants.CURRENT_USER);
        String filePath = "";
        Integer son_id = 0;
		for (int i = 0; i < myfiles.length; i++) {
			MultipartFile file = myfiles[i];
			String filename = file.getOriginalFilename();
			// 获取扩展名
			String ext = filename.substring(filename.lastIndexOf(".") + 1);
			if(ExcelUtil.isExcel(filename)){
				try {
					Row rowTitle = ExcelUtil.readRow(file.getInputStream(), filename, 0, 0);
					List<SysDataDictionary> dicList = dicService.findDicList(Constants.DataDictionary.EXML,formatRow(rowTitle));
					if(dicList.size()<1){
						Map<String, Object> dicMap = dicService.findOneByCode(Constants.DataDictionary.EXML);
						int data_fk = (int)dicMap.get("id");
						Map<String, Object> maxMap = dicService.findMaxIdSort(data_fk);
						son_id = ((Long)maxMap.get("max_id")).intValue();
						SysDataDictionary sysData = new SysDataDictionary();
						sysData.setId(son_id);
						sysData.setDataFk(data_fk);
						sysData.setName(filename.substring(0,filename.indexOf(".")));
						Row rowUnit= ExcelUtil.readRow(file.getInputStream(), filename, 0, 1);
						sysData.setMemo(formatRow(rowUnit));
						sysData.setRule(formatRow(rowTitle));
						sysData.setSort(((Long)maxMap.get("max_sort")).intValue());
						sysData.setValid(Constants.VALID);
						dicService.dicDataInsert(sysData);
					}else{
						SysDataDictionary sysData = dicList.get(0);
						son_id = sysData.getId();
					}
				} catch (IOException e) {
					logger.error(e.getMessage());
					e.printStackTrace();
				}
			}
			//upload
			FileUtil fileUtil = new FileUtil();
			filePath = fileUtil.upload(file, Constants.UPLOAD_PATH);
			//insert bm_tree			
			BmExcel bmExcel = new BmExcel();
			bmExcel.setId(StringUtil.createUUID());
			bmExcel.setName(filename);
			bmExcel.setTree_id(treeId);
			bmExcel.setDic_id(son_id);
			bmExcel.setSave_path(filePath);
			bmExcel.setType(ext);
			bmExcel.setCondition(bmTreeService.getConditions(treeId).get("conditions").toString());
			bmExcel.setUpdater_fk(loginUser.getId());
			bmExcel.setCreator_fk(loginUser.getId());
			if(!bmTreeService.insertExcel(bmExcel)){
				result.put("msg", "INSERT BM EXCEL TABLE ERROR!");
				return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
			}
			Map<String, Object> node = new HashMap<String, Object>();
            node.put("id", bmExcel.getId());
            node.put("pId", bmExcel.getTree_id());
            node.put("name", bmExcel.getName());
            node.put("treeFlag", false);
            node.put("fileUrl",Constants.FILEPATH_PREFIX+File.separator+bmExcel.getSave_path());
            result.put("node", node);
		}
		if(filePath.equals("error")){
			result.put("status", ResultEntity.KW_STATUS_FAIL);
		}else{
			result.put("status", ResultEntity.KW_STATUS_SUCCESS);
		}
		return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
	}
	 
	 /** 
	 * @Description 树形结构显示页面
	 * @author DCJ  
	 */

	@RequestMapping("/toTree")
    public String toTree(Model model){
		List<SysDataDictionary> dicList = dicService.findDictionaryByCode(Constants.DataDictionary.EXML);
		model.addAttribute("dicList",dicList);
        return "info/tree_view";
    }
	
    /**
     * 多级树形结构
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
                List<BmExcel> exList = bmTreeService.findExcelAll();
                for (BmExcel bmExcel:exList) {
                	Map<String, Object> node = new HashMap<String, Object>();
                    node.put("id", bmExcel.getId());
                    node.put("pId", bmExcel.getTree_id());
                    node.put("name", bmExcel.getName());
                    node.put("treeFlag", false);
                    node.put("fileUrl",Constants.FILEPATH_PREFIX+File.separator+bmExcel.getSave_path());
                    node.put("icon",Constants.FILEPATH_PREFIX+File.separator+bmExcel.getSave_path());
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
     * *********************************************************************************************************************
     * *********************************************************************************************************************
     **********************************************************************************************************************/
    /**
     * 多级树形结构
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
        result.put("text", "请选择父级树");
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
    public void findSubTree(List<BmTree> menus, List<Map<String, Object>> sonList) throws ServiceException{
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
    
    /***************导入读取规则*************************/
    
	 /** 
	 * @Description 导入规则界面
	 * @author DCJ  
	 */

	@RequestMapping("/toImport")
	public String toImport(Model model) {
		List<SysDataDictionary> dicList = dicService.findDictionaryByCode(Constants.DataDictionary.EXML);
		model.addAttribute("dicList",dicList);
		return "info/import_view";
	}
	
	 /** 
	 * @Description 读取模版excel
	 * @author DCJ  
	 */
	@RequestMapping("/fileRead/{id}")
	public ResponseEntity<String> fileRead(@RequestParam("excel") MultipartFile[] myfiles, HttpServletResponse response,@PathVariable Integer id){
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
						return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
					}
					Row rowUnit= ExcelUtil.readRow(file.getInputStream(), filename, 0, 1);
				    dicService.updRuleById(id,formatRow(rowTitle),formatRow(rowUnit));
				} catch (IOException e) {
					logger.error(e.getMessage());
				}
			}
		}
		result.put("msg", "success");
		return new ResponseEntity<String>(result.toString(), headers, HttpStatus.OK);
	}
	
	private String formatRow(Row row){
		String format = "";
		if(row!=null){
			int size = row.getLastCellNum();
		    for (int i = 0; i < size; i++) {
		    	String cell = ExcelUtil.getCellValue(row.getCell(i));
		    	format = i==0?cell:format+", "+cell;
			}
		}
		logger.info("formatRow:"+format);
		return format;
	}
	 
}
