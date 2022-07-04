package com.jerryboot.springbootdemo.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.nio.charset.StandardCharsets;

import org.springframework.stereotype.Service;



@Service
public class UtilStaticFactory {
	
	/**
	 *  透過路徑參數讀取 json 格式檔案，並回傳 json 格式字串;
	 *  讀取失敗拋出例外訊息且印出「檔案讀取失敗」。
	 *  
	 * 	@param path 檔案所在的資料夾與檔案名稱.json
	 *  @return String 回傳 json 格式字串 
	 * 
	 */
	public static String returnJsonString(String path) {
		
		try(BufferedInputStream bis = new BufferedInputStream(new FileInputStream(path));) {
			byte[] bytes = bis.readAllBytes();
			String jsonString = new String(bytes, StandardCharsets.UTF_8);
			
			return jsonString;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("檔案讀取失敗");
		}
		return null;
	}
}
