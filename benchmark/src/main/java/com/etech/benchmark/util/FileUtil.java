package com.etech.benchmark.util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * @author dcj
 * 
 */
public class FileUtil {

	static final Logger logger = Logger.getLogger(FileUtil.class);
	
	private FileUtil(){}
	
	/**
	 * 文件上传
	 * @param file
	 * @param path
	 * @return
	 */
	public static String upload(MultipartFile file, String path) {
		String url = "";
		String fileName = file.getOriginalFilename();
		SimpleDateFormat formater = new SimpleDateFormat("yyyyMMdd");
		String date = formater.format(new Date());
		String folderUrl = getFolder(path,date);
		url = date + "/" +getRandomName( fileName);
		File outFile = new File(folderUrl + File.separatorChar + getRandomName( fileName) );
		try {
			file.transferTo(outFile);
			return url;
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "error";
	}

	/**
	 *  获取文件后缀
	 * 
	 * @return string
	 */
	private static String getFileExt(String fileName) {
		return fileName.substring(fileName.lastIndexOf("."));
	}

	/**
	 *  生成随机文件名
	 * 
	 * @return
	 */
	public static String getRandomName(String fileName) {
		Random random = new Random();
		return random.nextInt(10000) + System.currentTimeMillis() + getFileExt(fileName);
	}

	/**
	 * 生成文件路径
	 * 
	 * @param path
	 * @return
	 */
	private  static String getFolder(String path,String date) {
		path += File.separatorChar + date;
		File dir = new File(path);
		if (!dir.exists()) {
			try {
				dir.mkdirs();
			} catch (Exception e) {
				return "";
			}
		}
		return path;
	}

	public void makeDir(String path) {
		File dir = new File(path);
		if (!dir.exists()) {
			try {
				logger.info("Create dir:"+path);
				dir.mkdirs();
			} catch (Exception e) {
				logger.error("Create dir error:"+e.getMessage());
			}
		}
	}

	public static  boolean deleteFile(String fullFilePath) {
        File file = null;
        try {
            file = new File(fullFilePath);
            if (file.exists()) {
            	logger.info("Delete file:"+fullFilePath);
                return file.delete();
            }
        } finally {
            file = null;
        }
        return false;
    }

}
