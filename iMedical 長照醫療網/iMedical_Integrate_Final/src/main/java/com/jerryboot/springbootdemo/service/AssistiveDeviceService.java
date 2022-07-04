package com.jerryboot.springbootdemo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jerryboot.springbootdemo.dao.AssistiveDeviceDao;
import com.jerryboot.springbootdemo.model.AssistiveDevice;

@Service
@Transactional
public class AssistiveDeviceService {
	
	
	@Autowired
	private AssistiveDeviceDao dao;
	
	public void save(AssistiveDevice ad) {
		dao.save(ad);
	}
	public List<AssistiveDevice> allAssistiveDevice(){
		List<AssistiveDevice> findAll = dao.findAll();
		return findAll;
	}
	
	public AssistiveDevice findById(Integer id){
		Optional<AssistiveDevice> option = dao.findById(id);
		if(option.isPresent()) {
			AssistiveDevice ad = option.get();
			return ad;
		}
		return null;
	}
	
	public void delete(Integer id) {
		dao.deleteById(id);
	}
	
	
	
	
	
	
	
	
	///////////////////////////////////
	//////////////豫台/////////////////
	/////////////////////////////////
	
	public List<AssistiveDevice> getAllDevice(){
		return dao.findAll();
	}
	
	public Page<AssistiveDevice> findByPage(Integer pageNumber){
		PageRequest pgb = PageRequest.of(pageNumber-1, 5,Sort.Direction.DESC,"id");
		Page<AssistiveDevice> page = dao.findAll(pgb);
		return page;
	}
	
	public AssistiveDevice addDevice(AssistiveDevice device) {
		return dao.save(device);
	}
	
	
	public AssistiveDevice searchAssistiveDeviceById(Integer id){
		Optional<AssistiveDevice> findById = dao.findById(id);
	
		if(findById.isPresent()==true) {
			AssistiveDevice assistiveDevice = findById.get();
			return assistiveDevice;
		}else {
			return null;
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
