package com.jerryboot.springbootdemo.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.jerryboot.springbootdemo.dao.EditLogDao;
import com.jerryboot.springbootdemo.dao.MemberDao;
import com.jerryboot.springbootdemo.dto.MemberDto;
import com.jerryboot.springbootdemo.model.Commodities;
import com.jerryboot.springbootdemo.model.EditLog;
import com.jerryboot.springbootdemo.model.Employee;
import com.jerryboot.springbootdemo.model.Member;
import com.jerryboot.springbootdemo.model.ShoppingCart;
import com.jerryboot.springbootdemo.service.CommoditiesService;
import com.jerryboot.springbootdemo.service.MemberService;
import com.jerryboot.springbootdemo.service.ShoppingCartService;



@SuppressWarnings("unchecked")
@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	@Autowired
	private MemberDao dao;
	@Autowired
	private EditLogDao editLogDao;
	@Autowired
	private CommoditiesService cService;
	
	private Member newRegister = new Member();

	
//--------------------------------- 前台 ----------------------------------------

	@PostMapping("/LoginOK")
	public String LoginOK() {
		return "FrontMember/frontMemberLoginOK";
	}
	@PostMapping("/LoginFail")
	public String LoginFail(RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("loginError", "帳號密碼輸入錯誤，請重新輸入");
		return "redirect:frontMemberLogin";
	}
	@GetMapping("/Logout")
	public String Logout(RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("logoutMessage", "帳號已登出，請重新登入");
		return "redirect:frontMemberLogin";
	}
	
	/*
	 * 第三方登入
	 */
	
//	public Principal user(Principal principal) {
//		return principal;
//		
//	}

//	@PostMapping("/memberpost")
//	public String postForm(@RequestParam("username") String loginUser, 
//							@RequestParam("password") String loginPassword,
//							HttpSession httpSession, 
//							RedirectAttributes redirectAttributes) {
//
//		List<Member> result = service.checkLogin(loginUser, loginPassword);
//		httpSession.setAttribute("loginMember", result);
//		if (result.isEmpty() == true) {
//			redirectAttributes.addFlashAttribute("loginError", "帳號密碼輸入錯誤，請重新輸入");
//
//			return "redirect:frontMemberLogin";
//		} else {
//			httpSession.setAttribute("loginSession", result);
//			return "FrontMember/frontMemberLoginOK";
//		}
//	}
	
		@PostMapping("/memberaddpost")
		public String postAddForm(@RequestParam("username") String loginUser,
				@RequestParam("password") String loginPassword, HttpSession httpSession,
				RedirectAttributes redirectAttributes) {

			List<Member> result = service.checkAdd(loginUser, loginPassword);
			httpSession.setAttribute("loginMember", result);
			if (result.isEmpty() == true) {
				redirectAttributes.addFlashAttribute("AddError", "註冊失敗，請再檢查輸入資料有無按照格式！");

				return "redirect:frontMemberAdd";
			} else {
				httpSession.setAttribute("loginSession", result);
				return "FrontMember/frontAddMemberOK";
			}
		}

//		@GetMapping("/FrontMember/logout")
//
//		public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session,
//				RedirectAttributes redirectAttributes) {
//			session.invalidate();
//
//			Cookie[] cs = request.getCookies();
//			for (Cookie c : cs) {
//				if ("JSESSIONID".equals(c.getName())) {
//					c.setMaxAge(0);
//					response.addCookie(c);
//				}
//			}
//
//			redirectAttributes.addFlashAttribute("logoutMessage", "您已登出，請重新登入後使用");
//			return "redirect:memberlogin";
//		}
	
	
//////----------------------- 會員註冊 -------------------------------------------------------------	
		
				@GetMapping("/FrontMember/goAddMember") // 註冊會員
				public String addMemberPage2(Model model) {
					model.addAttribute("memberBean", new Member());

					return "FrontMember/frontAddMemberPage";

				}

				/*
				 * AJAX
				 * 不能傳字串過去
				 */
				@ResponseBody //轉成json送回前端
				@PostMapping("/FrontMember/goAddMember")//當在這個頁面時
				public Integer ajaxAccountCheck(@RequestBody MemberDto dto) {
//					用ResponseBody接收Json的dto再用ResponseBody回傳
					String memberAccount = dto.getDtoMemberAccount();
					System.out.println(memberAccount);
//					*****不能直接回傳ShoppingCart物件,因為會連關連到的一起傳過去,會有error
					Member oneOfAccount = service.finByAccount(memberAccount);
					if(oneOfAccount == null) {
						return 0;
					}
					return 1;
				}
				
				/*
				 * AJAX以上
				 */
				
				@PostMapping("/FrontMember/addMember")	
				public String addMember(@ModelAttribute("memberBean") Member addMem) {
					//加密
					BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
					String encodePassword = bCryptPasswordEncoder.encode(addMem.getMemberPassword());
					addMem.setMemberPassword(encodePassword);
					service.addMember(addMem);

					return "FrontMember/frontAddMemberOK";
				}

				@GetMapping("/FrontMember/frontMemberLogin") // 註冊成功回登入
				public String frontAddMember(Model model) {
					model.addAttribute("memberBean", new Member());

					return "FrontMember/frontMemberLogin";

				}

				@PostMapping("/FrontMember/frontMemberLogin")	// 註冊成功回登入
				public String frontMemberLogin(@ModelAttribute("memberBean") Member addMem) {
					service.addMember(addMem);

					return "FrontMember/frontMemberLoginOK";
				}
//////---------------------- 會員中心 -----------------------------
		
		@GetMapping("/FrontMember/memberCentre") 
		public String frontMemberLoginOK(Model model) {
			model.addAttribute("memberBean", new Member());

			return "FrontMember/memberCentre";

		}
		
		@GetMapping("/FrontMember/memberData") 
		public String frontMemberData(Model model) {
			String account = SecurityContextHolder.getContext().getAuthentication().getName();
			model.addAttribute("memberNewData", service.finByAccount(account));
//			model.addAttribute("memberBean", new Member());

			return "/FrontMember/memberData";

		}
		@PostMapping("/FrontMember/memberData")
		public String FrontMemberData(@ModelAttribute("memberNewData") Member addMem) {
			service.addMember(addMem);
			return "/FrontMember/memberCentre";
		}

		@PostMapping("/FrontMember/memberCentre")	
		public String memberCentre(@ModelAttribute("memberBean") Member addMem) {
			service.addMember(addMem);

			return "/FrontMember/memberCentre";
		}
		@GetMapping("/FrontMember/ShoppingCartList")
		public String showShoppingList(Model model) {
			String account = SecurityContextHolder.getContext().getAuthentication().getName();
			Member thisMem = service.finByAccount(account);
			Set<ShoppingCart> scSet = thisMem.getShoppigCarts();
			model.addAttribute("shoppingCartSet", scSet);
			
			
			
			
			return "/FrontMember/ShoppingCartList";
		}
		
	//-------------------------------------------------------
		
//		@GetMapping("/FrontMember/editmember") // 編輯會員
//		public String editMemberePage(@RequestParam("id") Integer id, Model model) {
//			Optional<Member> someMem = dao.findById(id);
//			model.addAttribute("someMember", someMem);
//			return "FrontMember/editMemberPage";
//		}
//
//		@PostMapping("/FrontMember/editMember")
//		public String editMember(@ModelAttribute("memberBean") Member mem, Model model) {
//
//			Member update = dao.save(mem);
//			model.addAttribute("memberBean", update);
//			return "redirect:../Backstage/getAllMember";
//
//		}
	
	
	
// ---------------------------------- 後台會員 ------------------------------
		
	@GetMapping("/Backstage/getAllMember")
	public String findAllMember(Model model,@RequestParam(name="p",defaultValue = "1")Integer pageNumber) {
		Page<Member> page = service.findByPage(pageNumber);
		model.addAttribute("page",page);
		return "Backstage/jsp/allMember";
	}
	
	@GetMapping("/Backstage/editMember")
	public String editMemberPage(@RequestParam("id") Integer id, Model model) {
		Optional<Member> someMem = dao.findById(id);
		model.addAttribute("someMember",someMem);
		return "Backstage/jsp/editMemberPage";
	}
	
	
	
	@PostMapping("/Backstage/editMember")
	public String editMember(@ModelAttribute("memberBean") Member mem,HttpSession session) {
		//取得被變更欄位的ID
		Member update = dao.save(mem);
		Integer updatedTableId = update.getId();
				
		//取得登入的session記錄誰做更動
		List<Employee> loginUser = (List<Employee>) session.getAttribute("loginSession");
		Integer loginUserId = loginUser.get(0).getId();
		String loginUserName = loginUser.get(0).getEmployeeName();
				
		//設定紀錄
		EditLog editLog = new EditLog();
		editLog.setEmployeeId(loginUserId);
		editLog.setEmployeeName(loginUserName);
		editLog.setEmployeeAction("編輯");
		editLog.setTableName("會員");
		editLog.setUpdatedTableId(updatedTableId);
		editLog.setEditTime(new Date());
		//存入
		editLogDao.saveAndFlush(editLog);
		return "redirect:getAllMember";
		
	}
	
	@GetMapping("/Backstage/deleteMember")
	public String deleteMember(@RequestParam("id") Integer id,HttpSession session) {
		
		//取得登入的session記錄誰做更動
		List<Employee> loginUser = (List<Employee>) session.getAttribute("loginSession");
		Integer loginUserId = loginUser.get(0).getId();
		String loginUserName = loginUser.get(0).getEmployeeName();
				
		//設定紀錄
		EditLog editLog = new EditLog();
		editLog.setEmployeeId(loginUserId);
		editLog.setEmployeeName(loginUserName);
		editLog.setEmployeeAction("刪除");
		editLog.setTableName("會員");
		editLog.setUpdatedTableId(id);
		editLog.setEditTime(new Date());
		//存入
		editLogDao.saveAndFlush(editLog);
		//刪除
		dao.deleteById(id);
		
		return "redirect:getAllMember";
	}
	
	
	@GetMapping("/Backstage/goAddMember")
	public String addMemberPage(Model model) {
		model.addAttribute("memberBean",new Member());
		
		return "Backstage/jsp/addMemberPage";
		
	}
	
	@PostMapping("/addMember")
	public String addMember(@ModelAttribute("memberBean") Member addMem, HttpSession session) {
		Member addMember = service.addMember(addMem);
		Integer updatedTableId = addMember.getId();
		
		List<Employee> loginUser = (List<Employee>) session.getAttribute("loginSession");
		Integer loginUserId = loginUser.get(0).getId();
		String loginUserName = loginUser.get(0).getEmployeeName();
		
		EditLog editLog = new EditLog();
		editLog.setEmployeeId(loginUserId);
		editLog.setEmployeeName(loginUserName);
		editLog.setEmployeeAction("新增");
		editLog.setTableName("會員");
		editLog.setUpdatedTableId(updatedTableId);
		editLog.setEditTime(new Date());
		
		editLogDao.saveAndFlush(editLog);
		
		return "redirect:/Backstage/getAllMember";
	}
	
	
	
	@GetMapping("Backstage/searchMember")
	public String searchMemberByIdOrName(@RequestParam("id") Integer id,Model model) {

		Member mem = service.searchMemberById(id);

		model.addAttribute("memById",mem);
		return "Backstage/jsp/searchPages/searchMember";
	}
	
	
	
	
}
//SecurityContextHolder.getContext().getAuthentication().getName();