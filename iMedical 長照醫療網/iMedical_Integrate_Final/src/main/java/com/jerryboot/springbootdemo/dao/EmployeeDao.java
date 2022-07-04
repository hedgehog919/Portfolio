package com.jerryboot.springbootdemo.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jerryboot.springbootdemo.model.Employee;
import com.jerryboot.springbootdemo.model.Member;


@Repository
public interface EmployeeDao extends JpaRepository<Employee, Integer> {

	
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	/////////////////// 以下是查詢功能
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	
	
	@Query("from Employee")
	public List<Employee> listAllEmployee(Employee emp);
	
	@Query("from Employee where name= :name")
	public List<Employee> findEmployeeByName(@Param("name") String name);
	
	@Query("from Employee where employeeAccount = :account")
	public Employee findMemberByAccount(@Param("account") String account);
	
	@Query("from Employee where employee_account=:account and employee_password=:password ")
	public List<Employee> findByNameAndPassword(@Param("account") String loginAccount, @Param("password") String loginPassword); 
		
	
	
	
	
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	///////////////////以下是新增資料功能
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	
	
	
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	///////////////////以下是刪除資料功能
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	
	@Query(value="delete from Employee where employee_name=?1", nativeQuery = true)
	@Transactional
	@Modifying
	public void deleteEmployeeByName(String employeeName);
	
	
	
	
	
	
	
}
