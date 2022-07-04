package com.jerryboot.springbootdemo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jerryboot.springbootdemo.dao.EmployeeDao;
import com.jerryboot.springbootdemo.model.Employee;
import com.jerryboot.springbootdemo.model.Member;


@Service
@Transactional
public class EmployeeService {
	@Autowired
	private EmployeeDao dao;
	
	public List<Employee> getAllEmployee(){
		return dao.findAll();
		
	}
	
	

	
	
	public List<Employee> checkLogin (String loginAccount, String loginPassword) {
		List<Employee> login = dao.findByNameAndPassword(loginAccount, loginPassword);
		
		if(login!=null) {
			return login;
		}
		
		return null;
	}
	
	
	public Page<Employee> findByPage(Integer pageNumber){
		PageRequest pgb = PageRequest.of(pageNumber-1, 5,Sort.Direction.DESC,"id");
		Page<Employee> page = dao.findAll(pgb);
		
		return page;
	}
	
	

	public Employee searchEmployeeById(Integer id){
		Optional<Employee> findById = dao.findById(id);
	
		if(findById.isPresent()==true) {
			Employee employee = findById.get();
			return employee;
		}else {
			return null;
		}
		
	}
	
	
	
	
	
	public Employee addEmployee(Employee emp) {
		
		return dao.saveAndFlush(emp);
	}
	
	//
	public Employee finByAccount(String account) {
		Employee Employee = dao.findMemberByAccount(account);
		
		if(Employee!=null) {
			return Employee;
		}
		
		return null;
	}
	
	
	
	

}
