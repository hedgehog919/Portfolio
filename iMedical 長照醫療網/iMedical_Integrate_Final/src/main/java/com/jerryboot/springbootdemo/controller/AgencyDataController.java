package com.jerryboot.springbootdemo.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jerryboot.springbootdemo.dao.AgencyDataDao;
import com.jerryboot.springbootdemo.dao.EditLogDao;
import com.jerryboot.springbootdemo.model.AgencyData;
import com.jerryboot.springbootdemo.model.EditLog;
import com.jerryboot.springbootdemo.model.Employee;
import com.jerryboot.springbootdemo.service.AgencyDataService;
import com.jerryboot.springbootdemo.service.EditLogService;


@SuppressWarnings("unchecked")
@Controller
public class AgencyDataController {

	@Autowired
	private AgencyDataDao dao;
	
	@Autowired
	private AgencyDataService service;
	@Autowired
	private EditLogDao editLogDao;
	@Autowired
	private EditLogService editLogService;
	
	@GetMapping("/Agency/addAgencys")	// 新增機構
	public String addAgency(Model model) {
		model.addAttribute("agencyDatas",new AgencyData());
		return "Agency/addAgencyData";
	}
//	@PostMapping("/addAgencys")
//	public String postAgency(@ModelAttribute("agencyDatas") AgencyData postad) {
//		System.out.println(postad.toString());
//		service.save(postad);
//		return "Agency/addAgencyData";
//	}
	
	@GetMapping("/Agency/viewAgency")	// 機構介紹
	public String introduceAgency(Model model,@RequestParam(name="p",defaultValue = "1")Integer pageNumber) {
		Page<AgencyData> page = service.findByPage(pageNumber);
		model.addAttribute("agencyDatas",page);
		return "Agency/viewAgency";
	}
	
	@PostMapping("/Agency/viewAgency")
	public String postIntroduceAgency(@ModelAttribute("agencyDatas") AgencyData postad) {
		service.save(postad);
		return "Agency/viewAgency";
	}
	
	@GetMapping("/Agency/allAgencyData")	// 查詢所有機構列表
	public String listAll(Model model) {
		List<AgencyData> allAgencyData = service.allAgencyData();
		model.addAttribute("andAgencyDataList", allAgencyData);
		return "Agency/allAgencyData";
	}
	// 搜尋機構名字 --> 使用名字查機構
	@RequestMapping("/Agency/selectAgencyData")
	public String selectAgencyName(Model model,@Param("name") String name ) {
		List<AgencyData> listAg = service.AgencyDataName(name);
		model.addAttribute("listAg", listAg);
		return "/Agency/selectAgencyData";
	}
	
	
	
	
	
	
	
	
	/////////////////////////////////////////////////////////////////
	////////////////////////後台機構/////////////////////////////////
	
	@GetMapping("/Backstage/getAllAgency")
	public String findAllAgency(Model model,@RequestParam(name = "p",defaultValue = "1")Integer pageNumber) {
		Page<AgencyData> page = service.findByPage(pageNumber);
		model.addAttribute("page",page);
		
		return "Backstage/jsp/allAgency";
	
	}
	
	@GetMapping("/Backstage/goAddAgency")
	public String addAgencyDataPage(Model model) {
		model.addAttribute("agencyBean",new AgencyData());
		return "Backstage/jsp/addAgencyPage";
	}
	
	@PostMapping("/Backstage/addAgency")
	public String addAgency(@ModelAttribute(name = "agencyBean")AgencyData addAgency,@RequestParam("agencyPic") MultipartFile agencyPic, HttpSession session)throws IOException {
		
		byte[] photo = agencyPic.getBytes();
		addAgency.setAgencyPhoto(photo);

		AgencyData addAgencyData = service.addAgencyData(addAgency);
		
		
		//取得被變更欄位的ID
		
		Integer updatedTableId = addAgency.getId();
				
		//取得登入的session記錄誰做更動
		List<Employee> loginUser = (List<Employee>) session.getAttribute("loginSession");
		Integer employeeID = loginUser.get(0).getId();
		String employeeName = loginUser.get(0).getEmployeeName();
				
		//設定紀錄
		EditLog editLog = new EditLog();
		editLog.setEmployeeId(employeeID);
		editLog.setEmployeeName(employeeName);
		editLog.setEmployeeAction("新增");
		editLog.setTableName("機構");
		editLog.setUpdatedTableId(updatedTableId);
		editLog.setEditTime(new Date());

		//存入
		editLogDao.saveAndFlush(editLog);
				
		return "redirect:getAllAgency";
		
		
		
	}
	
	
	
	@GetMapping(value="/Backstage/downloadImageAgency/{id}")
	@ResponseBody
	public ResponseEntity<byte[]> downloadImage(@PathVariable("id") Integer id){
		AgencyData photoById = service.searchAgencyById(id);
		
		byte[] photoFile = photoById.getAgencyPhoto();
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.IMAGE_JPEG);
		//此陣列物件裡面放的是1.要回傳的物件2.header3.httpstatus回應
		return new ResponseEntity<byte[]>(photoFile,httpHeaders,HttpStatus.OK);
	}
	
	
	
	@GetMapping("/Backstage/goEditAgency")
	public String editEmployeePage(@RequestParam("id") Integer id, Model model) {
		Optional<AgencyData> someAgency = dao.findById(id);
		Integer id2 = someAgency.get().getId();
		model.addAttribute("agencyId",id2);
		model.addAttribute("someAgency",someAgency);
		return "Backstage/jsp/editAgencyPage";
	}
	
	@PostMapping("/Backstage/editAgency")
	public String editEmployee(@ModelAttribute("agencyBean") AgencyData agencydata,@RequestParam("agencyPic") MultipartFile agencyPic,HttpSession session)throws IOException {
		byte[] photo = agencyPic.getBytes();
		agencydata.setAgencyPhoto(photo);
		//取得被變更欄位的ID
		AgencyData update = dao.save(agencydata);
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
		editLog.setTableName("機構");
		editLog.setUpdatedTableId(updatedTableId);
		editLog.setEditTime(new Date());
		//存入
		editLogDao.saveAndFlush(editLog);
		
		return "redirect:getAllAgency";
		
	}
	
	
	@GetMapping("/Backstage/deleteAgency")
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
		editLog.setTableName("機構");
		editLog.setUpdatedTableId(id);
		editLog.setEditTime(new Date());
		//存入
		editLogDao.saveAndFlush(editLog);
		//刪除
		dao.deleteById(id);
		
		return "redirect:getAllAgency";
	}
	
	
	
	
	
	
}
