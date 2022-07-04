package com.jerryboot.springbootdemo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jerryboot.springbootdemo.model.AssistiveDevice;

@Repository
public interface AssistiveDeviceDao extends JpaRepository<AssistiveDevice,Integer> {
	
	
	
}
