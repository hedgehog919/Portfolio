package com.jerryboot.springbootdemo.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.jerryboot.springbootdemo.dao.RealAssistiveDeviceDao;
import com.jerryboot.springbootdemo.model.RealAssistiveDevice;

@Transactional
@Service
public class RealAssistiveDeviceService {

	@Autowired
	RealAssistiveDeviceDao dao;
	
	
	public List<RealAssistiveDevice> getAllDevice(){
		return dao.findAll();
	}
	
	public Page<RealAssistiveDevice> findByPage(Integer pageNumber){
		PageRequest pgb = PageRequest.of(pageNumber-1, 5,Sort.Direction.DESC,"id");
		Page<RealAssistiveDevice> page = dao.findAll(pgb);
		return page;
	}
	
	public RealAssistiveDevice addDevice(RealAssistiveDevice device) {
		return dao.save(device);
	}
	
	
	public RealAssistiveDevice searchAssistiveDeviceById(Integer id){
		Optional<RealAssistiveDevice> findById = dao.findById(id);
	
		if(findById.isPresent()==true) {
			RealAssistiveDevice assistiveDevice = findById.get();
			return assistiveDevice;
		}else {
			return null;
		}
		
	}
	
	
	
	
	
	
	
}
