package com.jerryboot.springbootdemo.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.jerryboot.springbootdemo.dao.CommoditiesDao;
import com.jerryboot.springbootdemo.dao.EditLogDao;
import com.jerryboot.springbootdemo.model.Commodities;
import com.jerryboot.springbootdemo.model.EditLog;
import com.jerryboot.springbootdemo.model.Employee;
import com.jerryboot.springbootdemo.service.CommoditiesService;

@SuppressWarnings("unchecked")
@Controller
public class CommoditiesController {

	@Autowired
	private CommoditiesService comService;
	
	
	@Autowired
	CommoditiesDao dao;

	@Autowired
	private EditLogDao editLogDao;
	
	
	
	
	@GetMapping("/Commodities")
	public ModelAndView allCommoditiesPage(ModelAndView mav) {
	
		List<Commodities> allcom = comService.findAllCommodities();
		mav.getModel().put("listCommodities", allcom);
		mav.setViewName("CommoditiesPage");
		return mav;
	}
	
	@GetMapping("/AddCommodities")
	public ModelAndView addCommoditiesPage(ModelAndView mav) {
		Commodities newcom = new Commodities();
		mav.getModel().put("addCommodities", newcom);//form的modelAttribute
		mav.setViewName("AddCommoditiesPage");//jsp名稱,返回路徑
		return mav;
	}
	
	@PostMapping("/AddCommodities")
	public ModelAndView addCommoditiesPage(ModelAndView mav, @ModelAttribute(name="addCommodities") Commodities com 
			) {
//		照片處理

		comService.insert(com);
		Commodities newcom = new Commodities();
		mav.getModel().put("addCommodities", newcom);
		mav.setViewName("AddCommoditiesPage");//jsp名稱,返回某頁面
		return mav;
	}
	
	@GetMapping("/ProducePage")
	public ModelAndView producePage(ModelAndView mav, @RequestParam(name="commodityId") Integer id) {
	
		Commodities com = comService.findById(id);
		mav.addObject("produce", com);
		mav.setViewName("ProductPage");
		return mav;
	}
	///////////////////////編輯商品
	
	@GetMapping("/Backstage/EditCommodities")
	public ModelAndView editCommoditiesPage(ModelAndView mav) {
	
		List<Commodities> allcom = comService.findAllCommodities();
		mav.getModel().put("listCommodities", allcom);
		mav.setViewName("EditCommoditiesPage");
		return mav;
	}
	
	@GetMapping("/Backstage/EditCommodity")
	public String editCommodityPage(Model model, @RequestParam(name="commodityId") Integer id) {
		//不用ModelAndView 會跟 @RequestParam 衝突?
		Commodities com = comService.findById(id);
		model.addAttribute("EditCommodity", com);
		
		return "EditCommodityPage";
	}
	
	@PostMapping("/EditCommodity")
	public ModelAndView editCommodity(ModelAndView mav, @ModelAttribute(name="EditCcommodity") Commodities com, BindingResult br) {
		
		mav.setViewName("EditCommodity");
		
		if(!br.hasErrors()) {
			comService.insert(com);
			mav.setViewName("redirect:/EditCommodities");
		}
		return mav;
	}
	
	@GetMapping("/DeletCommodity")
	public String deletCommodity(@RequestParam(name="commodityId") Integer id) {
		comService.deleteById(id);
		return "redirect:/EditCommodity";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	///////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////
	////////////////後台控制//////////////////////////////////////////
	///////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////
	
	
	
	@GetMapping("/Backstage/getAllCommodities")
	public String findAllCommodities(Model model,@RequestParam(name = "p",defaultValue = "1")Integer pageNumber) {
		Page<Commodities> page = comService.findByPage(pageNumber);
		model.addAttribute("page",page);
		return "Backstage/jsp/allCommodities";
	}
	
	
	
	@GetMapping(value="/Backstage/downloadImageCommodities/{id}")
	@ResponseBody
	public ResponseEntity<byte[]> downloadImage(@PathVariable("id") Integer id){
		Commodities photoById = comService.searchCommoditiesById(id);
		
		byte[] photoFile = photoById.getCommoditiesPhoto();
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.IMAGE_JPEG);
		//此陣列物件裡面放的是1.要回傳的物件2.header3.httpstatus回應
		return new ResponseEntity<byte[]>(photoFile,httpHeaders,HttpStatus.OK);
	}
	
	@GetMapping("/Backstage/goAddCommodities")
	public String addEmployeePage(Model model) {
		model.addAttribute("commoditiesBean",new Commodities());
		
		return "Backstage/jsp/addCommoditiesPage";
		
	}
	
	
	
	@PostMapping("/Backstage/addCommodities")
	public String addCommodities(@ModelAttribute(name = "commoditiesBean")Commodities addCommoditites,@RequestParam("commoditiesPic")MultipartFile commoditiesPic,HttpSession session)throws IOException {
		byte[] photo = commoditiesPic.getBytes();
		addCommoditites.setCommoditiesPhoto(photo);
		
		Commodities addCommodities = comService.addCommodities(addCommoditites);
		
		
		Integer updatedTableId = addCommodities.getCommodityId();
		
		List<Employee> loginUser = (List<Employee>) session.getAttribute("loginSession");
		Integer employeeID = loginUser.get(0).getId();
		String employeeName = loginUser.get(0).getEmployeeName();
		
		EditLog editLog = new EditLog();
		editLog.setEmployeeId(employeeID);
		editLog.setEmployeeName(employeeName);
		editLog.setEmployeeAction("新增");
		editLog.setTableName("商品");
		editLog.setUpdatedTableId(updatedTableId);
		editLog.setEditTime(new Date());
		
		editLogDao.saveAndFlush(editLog);
		
		return "redirect:getAllCommodities";
	}
	
	
	@GetMapping("/Backstage/editcommodities")
	public String editCommoditiesPage(@RequestParam("id") Integer id, Model model) {
		Optional<Commodities> someCom = dao.findById(id);
		Integer id2 = someCom.get().getCommodityId();
		model.addAttribute("comId",id2);
		model.addAttribute("someCommodities",someCom);
		return "Backstage/jsp/editCommoditiesPage";
	}
	
	
	@PostMapping("/Backstage/editCommodities")
	public String editCommodities(@ModelAttribute("commoditiesBean") Commodities commodities,@RequestParam("commoditiesPic") MultipartFile commoditiesPic,HttpSession session)throws IOException {
		byte[] photo = commoditiesPic.getBytes();
		commodities.setCommoditiesPhoto(photo);
		//取得被變更欄位的ID
		Commodities update = dao.save(commodities);
		Integer updatedTableId = update.getCommodityId();
		
		//取得登入的session記錄誰做更動
		List<Employee> loginUser = (List<Employee>) session.getAttribute("loginSession");
		Integer loginUserId = loginUser.get(0).getId();
		String loginUserName = loginUser.get(0).getEmployeeName();
		
		//設定紀錄
		EditLog editLog = new EditLog();
		editLog.setEmployeeId(loginUserId);
		editLog.setEmployeeName(loginUserName);
		editLog.setEmployeeAction("編輯");
		editLog.setTableName("商品");
		editLog.setUpdatedTableId(updatedTableId);
		editLog.setEditTime(new Date());
		//存入
		editLogDao.saveAndFlush(editLog);
		
		return "redirect:getAllCommodities";
		
	}
	
	
	@GetMapping("/Backstage/deleteCommodities")
	public String deleteCommodities(@RequestParam("id") Integer id, HttpSession session) {
				
		//取得登入的session記錄誰做更動
		List<Employee> loginUser = (List<Employee>) session.getAttribute("loginSession");
		Integer loginUserId = loginUser.get(0).getId();
		String loginUserName = loginUser.get(0).getEmployeeName();
				
		//設定紀錄
		EditLog editLog = new EditLog();
		editLog.setEmployeeId(loginUserId);
		editLog.setEmployeeName(loginUserName);
		editLog.setEmployeeAction("刪除");
		editLog.setTableName("商品");
		editLog.setUpdatedTableId(id);
		editLog.setEditTime(new Date());
		//存入
		editLogDao.saveAndFlush(editLog);
		//刪除
		dao.deleteById(id);
		
		return "redirect:getAllCommodities";
	}
	
	
	
	
	
	
	
	
	
	
}
