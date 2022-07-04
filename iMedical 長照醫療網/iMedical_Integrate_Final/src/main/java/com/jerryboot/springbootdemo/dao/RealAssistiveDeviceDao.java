package com.jerryboot.springbootdemo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jerryboot.springbootdemo.model.RealAssistiveDevice;


@Repository
public interface RealAssistiveDeviceDao extends JpaRepository<RealAssistiveDevice, Integer>{

}
