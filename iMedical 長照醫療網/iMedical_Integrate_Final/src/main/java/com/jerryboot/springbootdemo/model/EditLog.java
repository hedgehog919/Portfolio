package com.jerryboot.springbootdemo.model;

import java.util.Date;

import javax.annotation.ManagedBean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@ManagedBean
@Entity
@Table(name="edit_log")
public class EditLog {

	@Id
	@Column(name="id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name="employee_id")
	private Integer employeeId;
	@Column(name="employee_name", columnDefinition = "nvarchar(10)")
	private String employeeName;
	
	@Column(name="employee_action", columnDefinition = "nvarchar(10)")
	private String employeeAction;
	
	@Column(name="tablename", columnDefinition = "nvarchar(20)")
	private String tableName;
	
	@Column(name="updated_table_id")
	private Integer updatedTableId;
	
	public Integer getUpdatedTableId() {
		return updatedTableId;
	}

	public void setUpdatedTableId(Integer updatedTableId) {
		this.updatedTableId = updatedTableId;
	}

	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="edit_time", columnDefinition = "datetime")
	private Date editTime;
	
	
	
	public void onCreate() {
		if(editTime == null) {
			editTime = new Date();
		}
	}
	
	public EditLog() {
		// TODO Auto-generated constructor stub
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getEditTime() {
		return editTime;
	}

	public void setEditTime(Date editTime) {
		this.editTime = editTime;
	}

	public Integer getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public String getEmployeeAction() {
		return employeeAction;
	}

	public void setEmployeeAction(String employeeAction) {
		this.employeeAction = employeeAction;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public EditLog(Integer id, Integer employeeId, String employeeName, String employeeAction, String tableName,
			Date editTime) {
		super();
		this.id = id;
		this.employeeId = employeeId;
		this.employeeName = employeeName;
		this.employeeAction = employeeAction;
		this.tableName = tableName;
		this.editTime = editTime;
	}

	public EditLog(Integer id, Integer employeeId, String employeeName, String employeeAction, String tableName,
			Integer updatedTableId, Date editTime) {
		super();
		this.id = id;
		this.employeeId = employeeId;
		this.employeeName = employeeName;
		this.employeeAction = employeeAction;
		this.tableName = tableName;
		this.updatedTableId = updatedTableId;
		this.editTime = editTime;
	}
	
	
	
	
	
	
	
	
	

}
