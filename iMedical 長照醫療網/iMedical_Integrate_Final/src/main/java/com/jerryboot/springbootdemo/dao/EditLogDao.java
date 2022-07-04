package com.jerryboot.springbootdemo.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jerryboot.springbootdemo.model.EditLog;

@Repository
public interface EditLogDao extends JpaRepository<EditLog, Integer>{

	@Query("from EditLog")
	public List<EditLog> listAllLog(EditLog log);
	
	
	
}
