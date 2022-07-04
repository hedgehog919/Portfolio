package com.jerryboot.springbootdemo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jerryboot.springbootdemo.util.UtilStaticFactory;

@RestController
public class JsonResponseController {
	
	// 回傳json格式字串
	@GetMapping("/relatedLink")
	public String returnRefLink(HttpServletRequest req) {	
		
		// 取得當前執行環境路徑
		String path = req.getServletContext().getRealPath("");
		
		String jsonFileUrl = path + "/WEB-INF/" + "json/relatedLink.json";
		String jsonString = UtilStaticFactory.returnJsonString(jsonFileUrl);
		
		return jsonString;
	}
}
