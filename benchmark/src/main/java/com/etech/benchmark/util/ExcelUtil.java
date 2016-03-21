package com.etech.benchmark.util;

import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.etech.benchmark.exception.UtilException;

public class ExcelUtil {
    
    private final static int READ_START_ROW = 0;
    
    public ExcelUtil(){
        
    }

    /** 
     * 自动根据文件扩展名，调用对应的读取方法 
     *  
     * @throws IOException 
     */  
	public static List<Row> readExcel(InputStream in, String filename,int sheetIndex) throws IOException {

		// 获取扩展名
		String ext = filename.substring(filename.lastIndexOf(".") + 1);

		try {
			if ("xls".equals(ext)) { // 使用xls方式读取
				return readExcel_xls(in, sheetIndex);
			} else if ("xlsx".equals(ext)) { // 使用xlsx方式读取
				return readExcel_xlsx(in, sheetIndex);
			} else{
				List<Row> list = new ArrayList<Row>();
				return list;
			}
		} catch (IOException e) {
			throw e;
		} finally {
			if (in != null) {
				in.close();
			}
		}
	}
    
    /**
     * 读取Excel 2007版，xlsx格式 
     * @param in
     * @param sheetIndex
     * @return
     * @throws IOException
     */
    private static List<Row> readExcel_xlsx(InputStream in, int sheetIndex) throws IOException {  
  
        XSSFWorkbook wb = null;  
        List<Row> rowList = new ArrayList<Row>();  
        try {  
            // 去读Excel  
            wb = new XSSFWorkbook(in);  
  
            // 读取Excel 2007版，xlsx格式  
            rowList = readExcel(wb, sheetIndex); 
  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        return rowList;  
    }  
    
    /**
     * 读取Excel(97-03版，xls格式)
     * @param in
     * @param sheetIndex
     * @return
     * @throws IOException
     */
    private static List<Row> readExcel_xls(InputStream in, int sheetIndex) throws IOException {

        HSSFWorkbook wb = null;// 用于Workbook级的操作
        List<Row> rowList = new ArrayList<Row>();

        try {
            // 读取Excel
            wb = new HSSFWorkbook(in);

            // 读取Excel 97-03版，xls格式
            rowList = readExcel(wb, sheetIndex);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return rowList;
    }

    /**
     * 通用读取Excel
     * 
     * @Title: readExcel
     * @param wb
     * @return
     */
    private static List<Row> readExcel(Workbook wb, int sheetIndex) {
        List<Row> rowList = new ArrayList<Row>();
        
        int sheetCount = 1;//需要操作的sheet数量
        
        Sheet sheet = null;

        sheetCount = wb.getNumberOfSheets();
        
        if (sheetCount > sheetIndex) {
            sheet = wb.getSheetAt(sheetIndex);
            
            //获取最后行号
            int lastRowNum = sheet.getLastRowNum();
            
            if (lastRowNum > 0) {  
                Row row = null;
                // 循环读取
                for (int i = READ_START_ROW; i <= lastRowNum; i++) {
                    row = sheet.getRow(i);
                    if (row != null) {
                        String firstCol = getCellValue(row.getCell(0));
                        if (firstCol == null || "".equals(firstCol)) {  // 如果该行第一列为 空则 不继续读取
                            break;
                        }
                        rowList.add(row);
                    }
                }
            }
        }
        
        return rowList;
    }
    
    public static boolean isExcel(String filename){
    	// 获取扩展名
        String ext = filename.substring(filename.lastIndexOf(".") + 1);
        if("xls".equals(ext)||"xlsx".equals(ext)){
        	return true;
        }else return false;
    }
    
    
	public static Row readRow(InputStream in, String filename,int sheetIndex,int rowIndex) throws IOException {

		// 获取扩展名
		String ext = filename.substring(filename.lastIndexOf(".") + 1);

		try {
			if ("xls".equals(ext)) { // 使用xls方式读取
				return readRow_xls(in, sheetIndex, rowIndex);
			} else if ("xlsx".equals(ext)) { // 使用xlsx方式读取
				return readRow_xlsx(in, sheetIndex, rowIndex);
			} else{
				return null;
			}
		} catch (IOException e) {
			throw e;
		} finally {
			if (in != null) {
				in.close();
			}
		}
	}
    
    /**
     * 读取某行 2007版，xlsx格式 
     * @param in
     * @param sheetIndex
     * @return
     * @throws IOException
     */
    private static Row readRow_xlsx(InputStream in, int sheetIndex,int rowIndex) throws IOException {  
        XSSFWorkbook wb = null;  
        Row row = null;  
        try {  
            // 去读Excel  
            wb = new XSSFWorkbook(in);  
            // 读取Excel 2007版，xlsx格式  
            row = readRow(wb, sheetIndex,rowIndex); 
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        return row;  
    }  
    
    /**
     * 读取某行(97-03版，xls格式)
     * @param in
     * @param sheetIndex
     * @return
     * @throws IOException
     */
    private static Row readRow_xls(InputStream in, int sheetIndex , int rowIndex) throws IOException {
        HSSFWorkbook wb = null;// 用于Workbook级的操作
        Row row = null;
        try {
            // 读取Excel
            wb = new HSSFWorkbook(in);
            // 读取Excel 97-03版，xls格式
            row = readRow(wb, sheetIndex , rowIndex);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return row;
    }
    /**
     * 通用读取Excel某页某行
     * 
     * @Title: readExcel
     * @param wb
     * @return
     */
    private static Row readRow(Workbook wb, int sheetIndex, int rowIndex) {
		Sheet sheet = null;
		sheet = wb.getSheetAt(sheetIndex);
		Row row = null;
		// 循环读取
		row = sheet.getRow(rowIndex);
		return row;
	}
    
    /***
     * 读取单元格的值
     * 
     * @param cell
     * @return
     */
    public static String getCellValue(Cell cell) {
        Object result = null;
        if (cell != null) {
            switch (cell.getCellType()) {
            case Cell.CELL_TYPE_STRING:
                result = cell.getStringCellValue();
                break;
            case Cell.CELL_TYPE_NUMERIC:
                if (HSSFDateUtil.isCellDateFormatted(cell)) {// 处理日期格式、时间格式  
                    SimpleDateFormat sdf = null;  
                    if (cell.getCellStyle().getDataFormat() == HSSFDataFormat.getBuiltinFormat("h:mm")) {  
                        sdf = new SimpleDateFormat("HH:mm");  
                    } else {// 日期  
                        sdf = new SimpleDateFormat("yyyy-MM-dd");  
                    }  
                    Date date = cell.getDateCellValue();  
                    result = sdf.format(date);  
                } else if (cell.getCellStyle().getDataFormat() == 58) {  
                    // 处理自定义日期格式：m月d日(通过判断单元格的格式id解决，id的值是58)  
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
                    double value = cell.getNumericCellValue();  
                    Date date = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(value);  
                    result = sdf.format(date);  
                } else {  
                    double value = cell.getNumericCellValue();  
                    CellStyle style = cell.getCellStyle();  
                    DecimalFormat format = new DecimalFormat();  
                    String temp = style.getDataFormatString();  
                    // 单元格设置成常规  
                    if (temp.equals("General")) {  
                        format.applyPattern("#.#");  
                    }  
                    result = format.format(value);  
                    if (result.toString().indexOf(",") != -1) {
                        result = result.toString().replace(",", "");
                    }
                }  
                break;
            case Cell.CELL_TYPE_BOOLEAN:
                result = cell.getBooleanCellValue();
                break;
            case Cell.CELL_TYPE_FORMULA:
                try {
                    result = cell.getNumericCellValue();
                } catch (IllegalStateException e) {
                    result = String.valueOf(cell.getRichStringCellValue());
                }
                break;
            case Cell.CELL_TYPE_ERROR:
                result = cell.getErrorCellValue();
                break;
            case Cell.CELL_TYPE_BLANK:
                break;
            default:
                break;
            }
        }
        if (result == null) {
            return null;
        } else {
            return result.toString();
        }
    }
    
    public static Map<String, Object> rowToMap(Row title, Row row) throws UtilException {
        Map<String, Object> map = new HashMap<String, Object>();
        int titleCol = title.getLastCellNum();
        int col = row.getLastCellNum();
        if (titleCol > col) {
            throw new UtilException("Excel标题列数错误");
        }
        for (int i = 0; i < titleCol; i++) {
            Cell cell = row.getCell(i);
            Cell titleCell = title.getCell(i);
            String titleValue = getCellValue(titleCell).toUpperCase();
            String  value = getCellValue(cell);
            map.put(titleValue, value);
        }
        map.put("id", StringUtil.createUUID());
        return map;
    }
}

