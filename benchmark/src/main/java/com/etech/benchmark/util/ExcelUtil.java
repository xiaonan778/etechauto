package com.etech.benchmark.util;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
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
    
    /**
     * 判断文件是否是Excel
     * @param filename
     * @return
     */
    public static boolean isExcel(String filename){
    	// 获取扩展名
        String ext = filename.substring(filename.lastIndexOf(".") + 1);
        if ("xls".equals(ext)||"xlsx".equals(ext)) {
        	return true;
        } else {
            return false;
        }
    }
    
    /**
     * 读取excel某一行数据
     * @param in
     * @param filename
     * @param sheetIndex
     * @param rowIndex
     * @return
     * @throws IOException
     */
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
                    if (cell.getCellStyle().getDataFormat() == HSSFDataFormat.getBuiltinFormat("hh:mm")) {  
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
    
    /**
     * excel 一行数据转成map,  附带 id , treeId, templateId, fileId
     * 
     */
    public static Map<String, Object> rowToMap(Row title, Row row, String treeId, String templateId, String fileId) throws UtilException {
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
        map.put("treeId",  treeId);
        map.put("templateId",  templateId);
        map.put("fileId",  fileId);
        return map;
    }
    
    /**
     *  excel 一行数据转成map
     * @param title
     * @param row
     * @return
     * @throws UtilException
     */
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
        return map;
    }
    
    
    /******************************************************************************************************************/
    
    /**
     * 导出Excel
     * @param titleArray
     * @param keyArray
     * @param sheetName
     * @param outputStream
     * @param dataList
     * @throws UtilException
     */
    public static <T> XSSFWorkbook exportExcel(String[] titleArray, String[] keyArray, String sheetName, List<T>  dataList) throws UtilException {  
        // 创建一个workbook 对应一个excel应用文件  
        XSSFWorkbook workBook = new XSSFWorkbook();  
        // 在workbook中添加一个sheet,对应Excel文件中的sheet  
        XSSFSheet sheet = workBook.createSheet(sheetName);  
        XSSFCellStyle headStyle = getHeadStyle(workBook);  
        XSSFCellStyle bodyStyle = getBodyStyle(workBook);  
        
        XSSFCell cell = null;  
        
        // 构建表体数据  
        if (dataList != null && dataList.size() > 0 ) {
            int size = dataList.size();
            for ( int i = 0; i < size; i++ ) {
                T obj = dataList.get(i);
                XSSFRow bodyRow = sheet.createRow(i + 1);  
                
                for (int j = 0; j < keyArray.length; j++) {
                    String key = keyArray[j];
                    try {
                        Field field = obj.getClass().getDeclaredField(key);
                        field.setAccessible(true);
                        cell = bodyRow.createCell( j );  
                        cell.setCellStyle(bodyStyle);  
                        convertCellValue(cell, field.get(obj));
                    } catch (NoSuchFieldException e) {
                        e.printStackTrace();
                        throw new UtilException(e);
                    } catch (SecurityException e) {
                        e.printStackTrace();
                        throw new UtilException(e);
                    } catch (IllegalArgumentException e) {
                        e.printStackTrace();
                        throw new UtilException(e);
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                        throw new UtilException(e);
                    }
                }
                
            }
        }
        
        // 构建表头  
        XSSFRow headRow = sheet.createRow(0);  
        for (int i = 0; i < titleArray.length; i++) {  
            sheet.setColumnWidth(i, 6000);
            //sheet.autoSizeColumn(i);
            cell = headRow.createCell(i);  
            cell.setCellStyle(headStyle);  
            cell.setCellValue(titleArray[i]); 
        } 
        
        return workBook;
    }
    
    /**
     * 转换数据
     * @param cell
     * @param value
     */
    private static void convertCellValue(XSSFCell cell, Object value) {
        if (value == null) {
            cell.setCellValue("");
        } else if (value instanceof String) {
            cell.setCellValue( (String) value );
        } else if(value instanceof Integer) {
            cell.setCellValue( (Integer)value );
        } else if(value instanceof BigDecimal) {
            cell.setCellValue( ((BigDecimal)value).doubleValue() );
        } else if(value instanceof Double) {
            cell.setCellValue( (Double)value );
        } else if(value instanceof Long) {
            cell.setCellValue( (Long)value );
        } else if(value instanceof Float) {
            cell.setCellValue( (Float)value );
        } else if(value instanceof Date) {
            cell.setCellValue( (Date)value );
        } else if(value instanceof Calendar) {
            cell.setCellValue( (Calendar)value );
        } else {
            cell.setCellValue( value.toString() );
        }
    }
    
    /**
     * 设置表头的单元格样式 
     * @param workBook
     * @return
     */
    private static XSSFCellStyle getHeadStyle(XSSFWorkbook workBook) {  
        // 创建单元格样式  
        XSSFCellStyle cellStyle = workBook.createCellStyle();  
        // 设置单元格的背景颜色为淡蓝色  
        cellStyle.setFillForegroundColor(HSSFColor.PALE_BLUE.index);  
        cellStyle.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);  
        // 设置单元格居中对齐  
        cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);  
        // 设置单元格垂直居中对齐  
        cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);  
        // 创建单元格内容显示不下时自动换行  
        cellStyle.setWrapText(true);  
        
        // 设置单元格字体样式  
        XSSFFont font = workBook.createFont();  
        // 设置字体加粗  
        font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);  
        font.setFontName("宋体");  
        font.setFontHeight((short) 260);  
        cellStyle.setFont(font);  
        // 设置单元格边框为细线条  
        cellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);  
        cellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);  
        cellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);  
        cellStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);  
        return cellStyle;  
    }  
  
    /**
     * 设置表体的单元格样式 
     * @param workBook
     * @return
     */
    private static XSSFCellStyle getBodyStyle(XSSFWorkbook workBook)  {  
        // 创建单元格样式  
        XSSFCellStyle cellStyle = workBook.createCellStyle();  
        // 设置单元格居中对齐  
        cellStyle.setAlignment(XSSFCellStyle.ALIGN_LEFT);  
        // 设置单元格垂直居中对齐  
        cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);  
        // 创建单元格内容显示不下时自动换行  
        cellStyle.setWrapText(true);
        
        
        // 设置单元格字体样式  
        XSSFFont font = workBook.createFont();  
      
        font.setFontName("宋体");  
        font.setFontHeight((short) 200);  
        cellStyle.setFont(font);  
        // 设置单元格边框为细线条  
        cellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);  
        cellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);  
        cellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);  
        cellStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);  
        return cellStyle;  
    }  
}

