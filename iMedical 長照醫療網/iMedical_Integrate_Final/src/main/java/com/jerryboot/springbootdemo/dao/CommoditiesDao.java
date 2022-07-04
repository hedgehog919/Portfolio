package com.jerryboot.springbootdemo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jerryboot.springbootdemo.model.Commodities;

@Repository
public interface CommoditiesDao extends JpaRepository<Commodities, Integer>{

	
	
	
	
}
