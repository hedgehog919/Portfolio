package com.jerryboot.springbootdemo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jerryboot.springbootdemo.dto.NewsMessageDto;
import com.jerryboot.springbootdemo.model.NewsInfoPage;
import com.jerryboot.springbootdemo.model.NewsMessage;
import com.jerryboot.springbootdemo.service.NewsMessageService;


@Controller
public class NewsMessageController {
	@Autowired
	NewsMessageService newsMsgService;
	
	
	@GetMapping("/newsInfo")
	public String viewNewsInfo(Model model, 
							   @RequestParam(value="page", defaultValue = "1") Integer currPage,
							   @RequestParam(value="category", required = false) String category) {
		int perPageAmount = 10; // 每頁10筆
		
		NewsInfoPage newsInfoPage = null;
		
		if (category == null) // 找出所有newsMsg
			newsInfoPage = newsMsgService.findPageMsgByStatusAndDateDesc(perPageAmount, currPage);
		else {
			newsInfoPage = newsMsgService.findNewsByCategoryAndStatusDateDesc(category, perPageAmount, currPage);
		}
		
		model.addAttribute("newsMsgList", newsInfoPage.getNewsMsgList());
		model.addAttribute("category", category);
		model.addAttribute("totalMsg", newsInfoPage.getTotalMsgNum());
		model.addAttribute("currPage", newsInfoPage.getCurrPage());
		model.addAttribute("totalPage", newsInfoPage.getTotalPage());
		
		return "/newsInfo";
	}
	
	
	@GetMapping("/newsInfoPage") 
	public String viewNewsInfoPageById(Model model, @RequestParam(name="id") Integer id) {
		NewsMessage newsMsg = newsMsgService.findNewsMsgById(id);
		newsMsg.setViews(newsMsg.getViews() + 1);
		newsMsgService.save(newsMsg);
		model.addAttribute("newsMsg", newsMsg);
		return "/newsInfoPage";
	}
	
	/** 首頁取得消息的api **/
	@ResponseBody
	@GetMapping("/getNewsForIndexPage")
	public NewsInfoPage returnNewsArticle(@RequestParam("category") String category) {	
		int currPage = 1;
		int perPageAmount = 5;
		System.out.println(category);
		return newsMsgService.findNewsByCategoryAndStatusDateDesc(category, perPageAmount, currPage);		
	}
	
	/***********    後台訊息管理      ***********/
	/***********    後台訊息管理      ***********/
	
	@GetMapping("Backstage/editNewsMessage")
	public String editNewsMsg(Model model, @RequestParam(value="id") Integer id) {
		NewsMessage newsMsg = newsMsgService.findNewsMsgById(id);
		model.addAttribute("newsMsg", newsMsg);
		
		return "Backstage/jsp/newsManagement/editNewsMessage";
	}
	
	
	@GetMapping("Backstage/addNewsMessage")
	public String addNewsMsg(Model model) {
		model.addAttribute("newsMsg", new NewsMessage());
		return "Backstage/jsp/newsManagement/addNewsMessage";
	}
	
	@PostMapping("Backstage/addNewsMessage")
	public String addNewsMsg(Model model, @ModelAttribute(name="newsMsg") NewsMessage newsMsg) {
		newsMsgService.save(newsMsg);
//		System.out.println(newsMsg.getTitle());
		return "redirect:/Backstage/";
	}
	
	
	
	@PostMapping("Backstage/editNewsMessage")
	public String editNewsMsg(@ModelAttribute(name="newsMsg") NewsMessage newsMsg) {
		newsMsgService.save(newsMsg);
		return "redirect:/Backstage/searchAllNews";
	}
	
	@ResponseBody
	@PostMapping("/Backstage/postDataList")
	public NewsInfoPage postDataList(@RequestParam(value="id", required = false) Integer id, 
			 						 @RequestParam(value="sortType", required = false) String sortType,
									 @RequestBody NewsMessageDto newsMsgDto) {
		int perPageAmount = 5;
		if (newsMsgDto.getPerPageNum() != null) perPageAmount = newsMsgDto.getPerPageNum();
		
		return newsMsgService.findPageMsgByNewsMsgDto(newsMsgDto, perPageAmount);
	}
	
	@GetMapping("/Backstage/searchAllNews") 
	public String searchAllNews() {
		return "Backstage/jsp/newsManagement/searchAllNews";
	}
	
	
	@ResponseBody
	@PostMapping("/Backstage/deleteNewsMessage")
	public NewsInfoPage deleteNewsMsg(@RequestParam("id") Integer id,
									  @RequestBody NewsMessageDto newsMsgDto)					
	{
		int perPageAmount = 5;
		if (newsMsgDto.getPerPageNum() != null) perPageAmount = newsMsgDto.getPerPageNum();
		
		newsMsgService.deleteNewsMsgById(id);
		
		return newsMsgService.findPageMsgByNewsMsgDto(newsMsgDto, perPageAmount);
	}
	
}
