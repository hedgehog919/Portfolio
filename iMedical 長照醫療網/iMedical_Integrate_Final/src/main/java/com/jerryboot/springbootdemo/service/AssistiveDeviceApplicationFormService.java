package com.jerryboot.springbootdemo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jerryboot.springbootdemo.dao.AssistiveDeviceApplicationFormDao;
import com.jerryboot.springbootdemo.model.AssistiveDeviceApplicationForm;

@Service
@Transactional
public class AssistiveDeviceApplicationFormService {

	@Autowired
	private AssistiveDeviceApplicationFormDao dao;
	
	public List<AssistiveDeviceApplicationForm> getAllForm(){
		return dao.findAll();
	}
	
	public Page<AssistiveDeviceApplicationForm> findByPage(Integer pageNumber){
		PageRequest pgb = PageRequest.of(pageNumber-1, 5,Sort.Direction.DESC,"id");
		Page<AssistiveDeviceApplicationForm> page = dao.findAll(pgb);
		return page;
	}
	
	
	/*
	 * 此新增表單方法是為開發用，實際上自行新增申請表單並不合理，應由會員新增表單
	 * */
	
	public AssistiveDeviceApplicationForm addForm(AssistiveDeviceApplicationForm form) {
		return dao.save(form);
	}
	
	
	
	
}
