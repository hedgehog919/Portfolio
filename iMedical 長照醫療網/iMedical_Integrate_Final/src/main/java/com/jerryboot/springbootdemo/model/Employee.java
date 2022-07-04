package com.jerryboot.springbootdemo.model;

import java.util.Arrays;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.servlet.annotation.MultipartConfig;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="employee")
public class Employee {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="employee_id")
	private Integer id;
	
	@Lob
	@Column(name="employee_photo")
	private byte[] employeePhoto;
	
	@Column(name="employee_account",columnDefinition = "char(50)",nullable = false,unique = true)
	private String employeeAccount;
	@Column(name="employee_password",columnDefinition = "char(50)",nullable = false)
	private String employeePassword;
	@Column(name="employee_name", columnDefinition = "nvarchar(20)",nullable = false)
	private String employeeName;
	//權限 預設 normal,ROLE_admin

	//
	@Column(name="employee_phone",columnDefinition = "varchar(20)" , nullable = false)
	private String employeePhone;
	@Column(name="employee_email", columnDefinition = "char(50)",nullable = false)
	private String employeeEmail;
	@Column(name="employee_address", columnDefinition = "nvarchar(50)",nullable = false)
	private String employeeAddress;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Temporal(TemporalType.DATE)
	@Column(name="employee_birthday",columnDefinition = "datetime",nullable = false)
	private Date employeeBirthday;
	@Column(name="employee_level",columnDefinition = "tinyint",nullable = false)
	private Integer employeeLevel;
	@Column(name="employee_salary",columnDefinition = "money",nullable = false)
	private Integer employeeSalary;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Temporal(TemporalType.DATE)
	@Column(name="employee_onboard", columnDefinition = "datetime",nullable = false)
	private Date employeeOnboard;
	

	public Employee() {
	}


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}







	public byte[] getEmployeePhoto() {
		return employeePhoto;
	}


	public void setEmployeePhoto(byte[] employeePhoto) {
		this.employeePhoto = employeePhoto;
	}


	public String getEmployeeAccount() {
		return employeeAccount;
	}


	public void setEmployeeAccount(String employeeAccount) {
		this.employeeAccount = employeeAccount;
	}


	public String getEmployeePassword() {
		return employeePassword;
	}


	public void setEmployeePassword(String employeePassword) {
		this.employeePassword = employeePassword;
	}


	public String getEmployeeName() {
		return employeeName;
	}


	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}


	public String getEmployeePhone() {
		return employeePhone;
	}


	public void setEmployeePhone(String employeePhone) {
		this.employeePhone = employeePhone;
	}


	public String getEmployeeEmail() {
		return employeeEmail;
	}


	public void setEmployeeEmail(String employeeEmail) {
		this.employeeEmail = employeeEmail;
	}


	public String getEmployeeAddress() {
		return employeeAddress;
	}


	public void setEmployeeAddress(String employeeAddress) {
		this.employeeAddress = employeeAddress;
	}


	public Date getEmployeeBirthday() {
		return employeeBirthday;
	}


	public void setEmployeeBirthday(Date employeeBirthday) {
		this.employeeBirthday = employeeBirthday;
	}


	public Integer getEmployeeLevel() {
		return employeeLevel;
	}


	public void setEmployeeLevel(Integer employeeLevel) {
		this.employeeLevel = employeeLevel;
	}


	public Integer getEmployeeSalary() {
		return employeeSalary;
	}


	public void setEmployeeSalary(Integer employeeSalary) {
		this.employeeSalary = employeeSalary;
	}


	public Date getEmployeeOnboard() {
		return employeeOnboard;
	}


	public void setEmployeeOnboard(Date employeeOnboard) {
		this.employeeOnboard = employeeOnboard;
	}


	@Override
	public String toString() {
		return "Employee [id=" + id + ", employeePhoto=" + Arrays.toString(employeePhoto) + ", employeeAccount="
				+ employeeAccount + ", employeePassword=" + employeePassword + ", employeeName=" + employeeName
				+ ", employeePhone=" + employeePhone + ", employeeEmail=" + employeeEmail + ", employeeAddress="
				+ employeeAddress + ", employeeBirthday=" + employeeBirthday + ", employeeLevel=" + employeeLevel
				+ ", employeeSalary=" + employeeSalary + ", employeeOnboard=" + employeeOnboard + "]";
	}


	public Employee(Integer id, byte[] employeePhoto, String employeeAccount, String employeePassword,
			String employeeName, String employeePhone, String employeeEmail, String employeeAddress,
			Date employeeBirthday, Integer employeeLevel, Integer employeeSalary, Date employeeOnboard) {
		super();
		this.id = id;
		this.employeePhoto = employeePhoto;
		this.employeeAccount = employeeAccount;
		this.employeePassword = employeePassword;
		this.employeeName = employeeName;
		this.employeePhone = employeePhone;
		this.employeeEmail = employeeEmail;
		this.employeeAddress = employeeAddress;
		this.employeeBirthday = employeeBirthday;
		this.employeeLevel = employeeLevel;
		this.employeeSalary = employeeSalary;
		this.employeeOnboard = employeeOnboard;
	}




	


	


	


}
