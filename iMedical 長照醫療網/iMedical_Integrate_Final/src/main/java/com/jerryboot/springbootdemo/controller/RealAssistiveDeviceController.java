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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jerryboot.springbootdemo.dao.EditLogDao;
import com.jerryboot.springbootdemo.dao.RealAssistiveDeviceDao;
import com.jerryboot.springbootdemo.model.EditLog;
import com.jerryboot.springbootdemo.model.Employee;
import com.jerryboot.springbootdemo.model.RealAssistiveDevice;
import com.jerryboot.springbootdemo.service.RealAssistiveDeviceService;

@SuppressWarnings("unchecked")
@Controller
public class RealAssistiveDeviceController {
	
	@Autowired
	RealAssistiveDeviceDao dao;
	@Autowired
	RealAssistiveDeviceService adService;
	@Autowired
	private EditLogDao editLogDao;
	
	
	
	@GetMapping("/Backstage/getAllRealAssistiveDevice")
	public String findAllDevice(Model model,@RequestParam(name="p",defaultValue = "1")Integer pageNumber) {
		Page<RealAssistiveDevice> findByPage = adService.findByPage(pageNumber);
		model.addAttribute("page",findByPage);
	
		return "Backstage/jsp/allAssistiveDevicePage";
	}
	
	@GetMapping("/Backstage/goAddRealAssistiveDevice")
	public String addAssistiveDevicePage(Model model) {
		model.addAttribute("deviceBean",new RealAssistiveDevice());
		return "Backstage/jsp/addAssistiveDevicePage";
		
	}
	
	@PostMapping("/Backstage/addRealAssistiveDevice")
	public String addAssistiveDevice(@ModelAttribute("deviceBean") RealAssistiveDevice addDevice,@RequestParam("assistiveDevicePic") MultipartFile assistiveDevicePic,HttpSession session)throws IOException {
		
		byte[] photo = assistiveDevicePic.getBytes();
		
		addDevice.setAssistiveDeviceImg(photo);
		
		RealAssistiveDevice addDevice2 = adService.addDevice(addDevice);
		Integer updatedTableId = addDevice2.getId();
		
		List<Employee> loginUser = (List<Employee>) session.getAttribute("loginSession");
		
		Integer loginUserId = loginUser.get(0).getId();
		String loginUserName = loginUser.get(0).getEmployeeName();
		
		EditLog editLog = new EditLog();
		editLog.setEmployeeId(loginUserId);
		editLog.setEmployeeName(loginUserName);
		editLog.setEmployeeAction("新增");
		editLog.setTableName("輔具");
		editLog.setUpdatedTableId(updatedTableId);
		editLog.setEditTime(new Date());
		
		editLogDao.saveAndFlush(editLog);
		
		
		return "redirect:../Backstage/getAllRealAssistiveDevice";
	}
	
	
	@GetMapping("/Backstage/goEditRealAssistiveDevice")
	public String editAssistiveDevicePage(@RequestParam("id") Integer id, Model model) {
		Optional<RealAssistiveDevice> someDevice = dao.findById(id);
		model.addAttribute("someDevice",someDevice);
		return "Backstage/jsp/editAssistiveDevicePage";
	}
	
	@PostMapping("/Backstage/editRealAssistiveDevice")
	public String editAssistiveDevice(@ModelAttribute("someDevice") RealAssistiveDevice assistiveDevice,@RequestParam("assistiveDevicePic") MultipartFile assistiveDevicePic, HttpSession session) throws IOException {
		
		byte[] photo = assistiveDevicePic.getBytes();
		
		assistiveDevice.setAssistiveDeviceImg(photo);
		
		//取得被變更欄位的ID
		RealAssistiveDevice update = dao.save(assistiveDevice);
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
		editLog.setTableName("輔具");
		editLog.setUpdatedTableId(updatedTableId);
		editLog.setEditTime(new Date());
		//存入
		editLogDao.saveAndFlush(editLog);
		
		
		return "redirect:../Backstage/getAllRealAssistiveDevice";
	}
	
	
	@GetMapping("/Backstage/deleteRealAssistiveDevice")
	public String deleteAssistiveDevice(@RequestParam("id") Integer id, HttpSession session) {
		//取得登入的session記錄誰做更動
		List<Employee> loginUser = (List<Employee>) session.getAttribute("loginSession");
		Integer loginUserId = loginUser.get(0).getId();
		String loginUserName = loginUser.get(0).getEmployeeName();
				
		//設定紀錄
		EditLog editLog = new EditLog();
		editLog.setEmployeeId(loginUserId);
		editLog.setEmployeeName(loginUserName);
		editLog.setEmployeeAction("刪除");
		editLog.setTableName("輔具");
		editLog.setUpdatedTableId(id);
		editLog.setEditTime(new Date());
		//存入
		editLogDao.saveAndFlush(editLog);
		//刪除
		dao.deleteById(id);
		
		return "redirect:../Backstage/getAllRealAssistiveDevice";
	}
	
	
	
	
	@GetMapping(value="/Backstage/downloadImageRealAssistiveDevice/{id}")
	@ResponseBody
	public ResponseEntity<byte[]> downloadImage(@PathVariable("id") Integer id){
		RealAssistiveDevice photoById = adService.searchAssistiveDeviceById(id);
		
		byte[] photoFile = photoById.getAssistiveDeviceImg();
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.IMAGE_JPEG);
		//此陣列物件裡面放的是1.要回傳的物件2.header3.httpstatus回應
		return new ResponseEntity<byte[]>(photoFile,httpHeaders,HttpStatus.OK);
	}
	
	
	
	
	
	

}
