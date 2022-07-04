package com.jerryboot.springbootdemo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.jerryboot.springbootdemo.dao.MemberDao;
import com.jerryboot.springbootdemo.model.Member;
import com.jerryboot.springbootdemo.model.NewsInfoPage;
import com.jerryboot.springbootdemo.service.MemberService;
import com.jerryboot.springbootdemo.service.NewsMessageService;

@Controller
public class PageController {

// 前台轉頁控制

	
	@Autowired
	private NewsMessageService newsMsgService;
	
	
	@GetMapping("/")
	public String index(Model model) {
		int currPage = 1;
		int perPageAmount = 5;
		NewsInfoPage newsInfoPage = newsMsgService.findPageMsgByStatusAndDateDesc(perPageAmount, currPage);
		model.addAttribute("newsMsgList", newsInfoPage.getNewsMsgList());
		
		return "index";
	}
	

	@GetMapping("/frontMemberLogin") // 前台會員登入
	public String frontMemberLogin() {
		return "/FrontMember/frontMemberLogin";
	}

	@GetMapping("/frontAddMemberPage") // 前台註冊會員
	public String frontAddMemberPage() {
		return "/FrontMember/frontAddMemberPage";
	}

//	@GetMapping("/FrontMember/gofrontAddMemberPage")
//	public String frontAddMemberPage(Model model) {
//	//	model.addAttribute("memberBean", new Member());
//
//		return "FrontMember/frontAddMemberPage";
//
//	}

	@PostMapping("/FrontMember/gofrontAddMemberPage")
	public String frontAddMemberPage(@ModelAttribute("memberBean") Member addMem) {
		service.addMember(addMem);

		return "redirect:getall";
	}

	@GetMapping("/myWebTour") // 網頁導覽
	public String myWebTour() {
		return "myWebTour";
	}
	
	@GetMapping("/CommoditiesPage") // 商店
	public String CommoditiesPage() {
		return "CommoditiesPage";
	}
	
	@GetMapping("/ShoppingCartPage") // 購物車
	public String ShoppingCartPage() {
		return "ShoppingCartPage";
	}
	
	@GetMapping("/shoppingCarCheckout") // 購物車結帳
	public String shoppingCarCheckout() {
		return "shoppingCarCheckout ";
		
	}

	@GetMapping("/agencyData")	// 機構
	public String agencyData() {
		return "Agency/agencyData";
	}

	@GetMapping("/selectAgencyData")
	public String selectAgency() {
		return "/Agency/selectAgencyData";
	}

	@GetMapping("/assistiveDevice") // 輔具
	public String assistiveDevice() {
		return "Auxiliary/assistiveDevice";
	}

	@GetMapping("assistiveDeviceIntroduce")
	public String assistiveDeviceIntroduce() {
		return "assistiveDeviceIntroduce";
	}

	@GetMapping("/aboutimedical") // 關於iMedical
	public String aboutimedical() {
		return "aboutimedical";
	}

	@GetMapping("/gosubsidy") // 長照補助
	public String gosubsidy() {
		return "/gosubsidy";
	}

	@GetMapping("/subsidy") // 長照2.0
	public String gotosubsidy() {
		return "/subsidy";
	}
	
	@GetMapping("/otherServe") // 其他長照2.0服務
	public String otherServe() {
		return "otherServe";
	}

	@GetMapping("/messageNavbar") // 留言板
	public String messageNavbar() {
		return "/default/messageNavbar";
	}
	
	






	
////----------------------------------  後台端  --------------------------------------//// 
//// 後台轉頁

	@Autowired
	private MemberService service;
	@Autowired
	private MemberDao dao;

	@GetMapping("/Backstage")
	public String Backstage() {
		return "Backstage/jsp/index";
	}

	@GetMapping("/myNavbar")
	public String myNavbar() {
		return "/Backstage/jsp/default/myNavbar";
	}
	
	@GetMapping("/Backstage/jsp/goaddAgencyPage")	// 新增機構
	public String addAgencyPage() {
		return "/Backstage/jsp/goaddAgencyPage";
	}
	


}
