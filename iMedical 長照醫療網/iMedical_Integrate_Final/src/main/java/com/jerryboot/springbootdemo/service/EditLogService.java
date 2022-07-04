package com.jerryboot.springbootdemo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jerryboot.springbootdemo.dao.EditLogDao;
import com.jerryboot.springbootdemo.model.EditLog;
import com.jerryboot.springbootdemo.model.Employee;

@Service
@Transactional
public class EditLogService {
	
	@Autowired
	private EditLogDao dao;
	
	
	public Page<EditLog> findByPage(Integer pageNumber){
		PageRequest pgb = PageRequest.of(pageNumber-1, 5,Sort.Direction.DESC,"id");
		Page<EditLog> page = dao.findAll(pgb);
		
		return page;
	}
	
	
	

}
