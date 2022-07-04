package com.jerryboot.springbootdemo.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jerryboot.springbootdemo.dao.AssistiveDeviceApplicationFormDao;
import com.jerryboot.springbootdemo.dao.AssistiveDeviceDao;
import com.jerryboot.springbootdemo.dao.EditLogDao;
import com.jerryboot.springbootdemo.model.AssistiveDevice;
import com.jerryboot.springbootdemo.model.AssistiveDeviceApplicationForm;
import com.jerryboot.springbootdemo.model.EditLog;
import com.jerryboot.springbootdemo.model.Employee;
import com.jerryboot.springbootdemo.service.AssistiveDeviceApplicationFormService;
import com.jerryboot.springbootdemo.service.AssistiveDeviceService;

@Controller
public class AssistiveDeviceApplicationFormController {

	@Autowired
	private AssistiveDeviceService service;
	@Autowired
	private AssistiveDeviceDao dao;
	@Autowired
	private EditLogDao editLogDao;
	
	@GetMapping("/Backstage/getAllAssistiveDeviceApplicationForm")
	public String findAllAssistiveDeviceApplicationForm(Model model,@RequestParam(name="p",defaultValue = "1")Integer pageNumber) {
		Page<AssistiveDevice> page = service.findByPage(pageNumber);
		model.addAttribute("page",page);
		return "Backstage/jsp/allAssistiveDeviceApplicationFormPage";
		
	}
	
	@GetMapping("/Backstage/deleteAssistiveDeviceApplicationForm")
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

		return "redirect:getAllAssistiveDeviceApplicationForm";
	}
	
	
	
	
	
	
	
}
