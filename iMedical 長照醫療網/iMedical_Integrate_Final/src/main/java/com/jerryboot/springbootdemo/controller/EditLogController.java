package com.jerryboot.springbootdemo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jerryboot.springbootdemo.dao.EditLogDao;
import com.jerryboot.springbootdemo.model.EditLog;
import com.jerryboot.springbootdemo.service.EditLogService;

@Controller
public class EditLogController {
	
	@Autowired
	private EditLogDao dao;
	@Autowired
	private EditLogService service;
	
	
	
	@GetMapping("/Backstage/getAllEditLog")
	public String findAllLog(Model model,@RequestParam(name="p",defaultValue = "1")Integer pageNumber) {
		
		Page<EditLog> page = service.findByPage(pageNumber);
		model.addAttribute("page",page);
//		List<Employee> allEmployee = service.getAllEmployee();
//		model.addAttribute("empList",allEmployee);
		return "Backstage/jsp/editLogPages/editLog";
	}
	
	@GetMapping("/Backstage/deleteEditLog")
	public String deleteEmployee(@RequestParam("id") Integer id) {
		dao.deleteById(id);
		return "redirect:/Backstage/getAllEditLog";
	}
	
	
	
	
	
	
	
	
	
	
	
	

}
