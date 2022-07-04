package com.jerryboot.springbootdemo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jerryboot.springbootdemo.model.Commodities;
import com.jerryboot.springbootdemo.model.CommoditiesRepository;
import com.jerryboot.springbootdemo.model.Member;

@Service
@Transactional
public class CommoditiesService {
	
	@Autowired
	private CommoditiesRepository comDao;
	
	public void insert(Commodities com) {
		comDao.save(com);
	}
	
	public Commodities findById(Integer id) {
		Optional<Commodities> option = comDao.findById(id);
		if(option.isPresent()) {
			return option.get();
		}
		return null;
	}
	
	public Commodities findByName(String name) {
		Commodities findMemberByName = comDao.findCommoditiesByName(name);
		if(findMemberByName!=null) {
			return findMemberByName;
		}
		return null;
	}
	
	public List<Commodities> findAllCommodities(){
		return comDao.findAll();
	}
	
	public void deleteById(Integer id) {
		comDao.deleteById(id);
	}
	
	
	
	///////////////////////////////////////
	////////////////////豫台/////////////////
	////////////////////////////////////////
	
	public Page<Commodities> findByPage(Integer pageNumber){
		PageRequest pgb = PageRequest.of(pageNumber-1, 5,Sort.Direction.DESC,"commodityId");
		Page<Commodities> page = comDao.findAll(pgb);
		
		return page;
	}
	
	
	
	public Commodities searchCommoditiesById(Integer id){
		Optional<Commodities> findById = comDao.findById(id);
	
		if(findById.isPresent()==true) {
			Commodities commodities = findById.get();
			return commodities;
		}else {
			return null;
		}
		
	}
	
	public Commodities addCommodities(Commodities commodities) {
		
		return comDao.saveAndFlush(commodities);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

}
