package com.jerryboot.springbootdemo.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jerryboot.springbootdemo.dao.EditLogDao;
import com.jerryboot.springbootdemo.dao.EmployeeDao;
import com.jerryboot.springbootdemo.model.EditLog;
import com.jerryboot.springbootdemo.model.Employee;
import com.jerryboot.springbootdemo.service.EditLogService;
import com.jerryboot.springbootdemo.service.EmployeeService;


@SuppressWarnings("unchecked")
@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeService service;
	@Autowired
	private EmployeeDao dao;

	
	@Autowired
	private EditLogDao editLogDao;
	@Autowired
	private EditLogService editLogService;
	
	
	@GetMapping("/Backstage/getallEmployee")
	public String findAllMember(Model model,@RequestParam(name="p",defaultValue = "1")Integer pageNumber) {
		
		Page<Employee> page = service.findByPage(pageNumber);
		model.addAttribute("page",page);
//		List<Employee> allEmployee = service.getAllEmployee();
//		model.addAttribute("empList",allEmployee);
		return "Backstage/jsp/allEmployee";
	}
	
	@GetMapping(value="/Backstage/downloadImage/{id}")
	@ResponseBody
	public ResponseEntity<byte[]> downloadImage(@PathVariable("id") Integer id){
		Employee photoById = service.searchEmployeeById(id);
		
		byte[] photoFile = photoById.getEmployeePhoto();
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.IMAGE_JPEG);
		//此陣列物件裡面放的是1.要回傳的物件2.header3.httpstatus回應
		return new ResponseEntity<byte[]>(photoFile,httpHeaders,HttpStatus.OK);
	}
	
	
	
	
	
	
	
	
	
	
	
	@GetMapping("/Backstage/employeelogin")
	public String employeeLoginPage(HttpSession session) {
		
		if(session.getAttribute("loginSession")!=null) {
			session.setMaxInactiveInterval(0);
			
			return "Backstage/jsp/index";
		}else {
			return "Backstage/jsp/login";
		}
	}
//	//security
//	@GetMapping("/Backstage/employeeloginError")
//	public String employeeLoginErrorPage(RedirectAttributes redirectAttributes) {
//		redirectAttributes.addFlashAttribute("loginError", "帳號密碼輸入錯誤，請重新輸入");
//		return "Backstage/jsp/login";
//	}
	
	
	@PostMapping("/Backstage/employeepost")
	public String postForm(@RequestParam("username") String loginUser,
							@RequestParam("password") String loginPassword,
							HttpSession httpSession,
							RedirectAttributes redirectAttributes) {
		List<Employee> result = service.checkLogin(loginUser, loginPassword);
		httpSession.setAttribute("loginEmployee", result);
		if(result.isEmpty()==true) {
			redirectAttributes.addFlashAttribute("loginError", "帳號密碼輸入錯誤，請重新輸入");
			
			return "redirect:employeelogin";
		}else{ 
			httpSession.setAttribute("loginSession", result);
		return "Backstage/jsp/loginOK";
	}	
	}
	
	
	@GetMapping("/Backstage/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response , HttpSession session,RedirectAttributes redirectAttributes) {
		if(session!=null) {
					session.invalidate();
//		session.removeAttribute("loginSession");
		
		Cookie[] cs = request.getCookies();
		
		for (Cookie c : cs) {
			if ("JSESSIONID".equals(c.getName())) {
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
		}

		
		redirectAttributes.addFlashAttribute("logoutMessage", "您已登出，請重新登入後使用");
		return "redirect:employeelogin";
	}
	
	
	
//	@GetMapping("/employee/allEmployee")
//	public String viewEmployeePage(Model model,@RequestParam(name="p",defaultValue = "1") Integer pageNumber) {
//		Page<Employee> page = service.findByPage(pageNumber);
//		
//		model.addAttribute("page",page);
//		return "allEmployee";
//				
//		
//	}
	
	
	@GetMapping("/Backstage/goAddEmployee")
	public String addEmployeePage(Model model) {
		model.addAttribute("employeeBean",new Employee());
		
		return "Backstage/jsp/addEmployeePage";
		
	}
	
	@PostMapping("/Backstage/addEmployee")
	public String addEmployee(@ModelAttribute (name="employeeBean")Employee addEmp,@RequestParam("employeePic") MultipartFile employeePic, HttpSession session) throws IOException {
//		String fileName = StringUtils.cleanPath(employeePhoto.getOriginalFilename());
//		System.out.println("fileName: "+fileName);
//		addEmp.setEmployeePhoto(fileName);
//		System.out.println("123");
		byte[] photo = employeePic.getBytes();
		System.out.println("存進去的圖片: "+photo);
		addEmp.setEmployeePhoto(photo);
		
		Employee addEmployee = service.addEmployee(addEmp);
		
		
//		String uploadDir = "./employee-avatar/"+addEmployee.getId();
//		System.out.println("uploadDir: "+uploadDir);
//		Path uploadPath = Paths.get(uploadDir);
//		System.out.println("uploadPath: "+uploadPath);
//		if(!Files.exists(uploadPath)) {
//			Files.createDirectories(uploadPath);
//		}
//		
//		try(InputStream inputStream = employeePhoto.getInputStream()) {
//			Path filePath = uploadPath.resolve(fileName);
//			Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
//			
//		}catch (IOException e) {
//			throw new IOException("Could not save uploaded file: "+ fileName);
//		}
		
		//取得被變更欄位的ID
		
		Integer updatedTableId = addEmployee.getId();
		
		//取得登入的session記錄誰做更動
		List<Employee> loginUser = (List<Employee>) session.getAttribute("loginSession");
		Integer employeeID = loginUser.get(0).getId();
		String employeeName = loginUser.get(0).getEmployeeName();
		
		//設定紀錄
		EditLog editLog = new EditLog();
		editLog.setEmployeeId(employeeID);
		editLog.setEmployeeName(employeeName);
		editLog.setEmployeeAction("新增");
		editLog.setTableName("員工");
		editLog.setUpdatedTableId(updatedTableId);
		editLog.setEditTime(new Date());

		//存入
		editLogDao.saveAndFlush(editLog);
		
		return "redirect:getallEmployee";
	}
	
	
	@GetMapping("/Backstage/editemployee")
	public String editEmployeePage(@RequestParam("id") Integer id, Model model) {
		Optional<Employee> someEmp = dao.findById(id);
		Integer id2 = someEmp.get().getId();
		model.addAttribute("empId",id2);
		model.addAttribute("someEmployee",someEmp);
		return "Backstage/jsp/editEmployeePage";
	}
	
	
	
	@PostMapping("/Backstage/editEmployee")
	public String editEmployee(@ModelAttribute("employeeBean") Employee emp,@RequestParam("employeePic") MultipartFile employeePic,HttpSession session)throws IOException {
		byte[] photo = employeePic.getBytes();
		emp.setEmployeePhoto(photo);
		//取得被變更欄位的ID
		Employee update = dao.save(emp);
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
		editLog.setTableName("員工");
		editLog.setUpdatedTableId(updatedTableId);
		editLog.setEditTime(new Date());
		//存入
		editLogDao.saveAndFlush(editLog);
		
		return "redirect:getallEmployee";
		
	}
	
	
	@GetMapping("/Backstage/deleteEmployee")
	public String deleteEmployee(@RequestParam("id") Integer id, HttpSession session) {
				
		//取得登入的session記錄誰做更動
		List<Employee> loginUser = (List<Employee>) session.getAttribute("loginSession");
		Integer loginUserId = loginUser.get(0).getId();
		String loginUserName = loginUser.get(0).getEmployeeName();
				
		//設定紀錄
		EditLog editLog = new EditLog();
		editLog.setEmployeeId(loginUserId);
		editLog.setEmployeeName(loginUserName);
		editLog.setEmployeeAction("刪除");
		editLog.setTableName("員工");
		editLog.setUpdatedTableId(id);
		editLog.setEditTime(new Date());
		//存入
		editLogDao.saveAndFlush(editLog);
		//刪除
		dao.deleteById(id);
		
		return "redirect:getallEmployee";
	}
	
	
	@GetMapping("Backstage/searchEmployee")
	public String searchEmployeeByIdOrName(@RequestParam("id") Integer id,Model model) {

		Employee emp = service.searchEmployeeById(id);

		model.addAttribute("empById",emp);
		return "Backstage/jsp/searchPages/searchEmployee";
	}
	
	
	
	

}
