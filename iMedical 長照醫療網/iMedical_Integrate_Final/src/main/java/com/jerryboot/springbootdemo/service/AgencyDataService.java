package com.jerryboot.springbootdemo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jerryboot.springbootdemo.dao.AgencyDataDao;
import com.jerryboot.springbootdemo.model.AgencyData;

@Service
@Transactional
public class AgencyDataService {
	
	@Autowired
	private AgencyDataDao dao;
	
	public void save(AgencyData agencyData) {
		dao.saveAndFlush(agencyData);
	}
	public List<AgencyData> allAgencyData(){
		List<AgencyData> allAgencyData = dao.findAll();
		return allAgencyData;
	}
	
	public List<AgencyData> AgencyDataName(String name ){
		
		if(name !=null) {
			return dao.agencyName(name);
		}
		return dao.findAll();
	}
	
	
	
	///////////後台控制//////////////////////////////////////
	
	public Page<AgencyData> findByPage(Integer pageNumber){
		PageRequest pgb = PageRequest.of(pageNumber-1, 5,Sort.Direction.DESC,"id");
		Page<AgencyData> page = dao.findAll(pgb);
		return page;
		
	}
	
	public AgencyData searchAgencyById(Integer id){
		Optional<AgencyData> findById = dao.findById(id);
		
		if(findById.isPresent()==true){
			AgencyData agencyData = findById.get();
			return agencyData;
		}else {
			return null;
		}
	}
	
	
	
	public AgencyData addAgencyData(AgencyData agencyData) {
		return dao.saveAndFlush(agencyData);
	}
	
	
	
	
	
	
}
