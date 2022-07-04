package com.jerryboot.springbootdemo.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jerryboot.springbootdemo.model.AgencyData;

@Repository
public interface AgencyDataDao extends JpaRepository<AgencyData,Integer>{
	
	@Query(value = "select * from agency_data where name = %?1%", nativeQuery = true)
	public List<AgencyData> agencyName(String name );
	
}

