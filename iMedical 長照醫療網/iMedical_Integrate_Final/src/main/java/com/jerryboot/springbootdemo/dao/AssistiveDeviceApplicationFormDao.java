package com.jerryboot.springbootdemo.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jerryboot.springbootdemo.model.AssistiveDeviceApplicationForm;

@Repository
public interface AssistiveDeviceApplicationFormDao extends JpaRepository<AssistiveDeviceApplicationForm, Integer> {

	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	/////////////////// 以下是查詢功能
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////

	@Query("from AssistiveDeviceApplicationForm")
	public List<AssistiveDeviceApplicationForm> listAllForm(AssistiveDeviceApplicationForm form);

	@Query("from AssistiveDeviceApplicationForm where name = :name")
	public List<AssistiveDeviceApplicationForm> findFormByName(@Param("name") String name);

////////////////////////////////////////////////////
////////////////////////////////////////////////////
///////////////////以下是刪除資料功能
////////////////////////////////////////////////////
////////////////////////////////////////////////////

	@Query(value = "delete from AssistiveDeviceApplicationForm where AssistiveDeviceApplicationForm_name = ?1", nativeQuery = true)
	@Transactional
	@Modifying
	public void deleteFormByName(String formName);

	
	
	
	
	
	
	
}
