package com.jerryboot.springbootdemo.model;

import java.util.Arrays;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name = "agency_data")
public class AgencyData {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
	@Column(name = "agency_name",columnDefinition = "nvarchar(500)")
	private String agencyName;
	@Column(name = "agency_type",columnDefinition = "nvarchar(200)")
	private String agencyType;
	@Lob
	@Column(name = "agency_photo",columnDefinition = "varbinary(max)")
	private byte[] agencyPhoto;
	@Column(name = "agency_phone",columnDefinition = "nvarchar(200)")
	private String agencyPhone;
	@Column(name = "agency_address",columnDefinition = "nvarchar(500)")
	private String agencyAddress;
	@Column(name = "working_hours",columnDefinition = "nvarchar(200)")
	private String workingHours;
	@Column(name = "room_type",columnDefinition = "nvarchar(300)")
	private String roomType;
	@Column(name = "bed_number",columnDefinition = "smallint")
	private Integer bedNumber;
	@Column(name = "serve_target",columnDefinition = "nvarchar(500)")
	private String serveTarget;
	@Column(name = "government_subsidy",columnDefinition = "nvarchar(500)")
	private String governmentSubsidy;
	@Column(name = "medical_service",columnDefinition = "nvarchar(500)")
	private String medicalService;
	@Column(name = "professional_care",columnDefinition = "nvarchar(500)")
	private String professionalCare;
	@Column(name = "feature_service",columnDefinition = "nvarchar(500)")
	private String featureService;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAgencyName() {
		return agencyName;
	}
	public void setAgencyName(String agencyName) {
		this.agencyName = agencyName;
	}
	public String getAgencyType() {
		return agencyType;
	}
	public void setAgencyType(String agencyType) {
		this.agencyType = agencyType;
	}
	public byte[] getAgencyPhoto() {
		return agencyPhoto;
	}
	public void setAgencyPhoto(byte[] agencyPhoto) {
		this.agencyPhoto = agencyPhoto;
	}
	public String getAgencyPhone() {
		return agencyPhone;
	}
	public void setAgencyPhone(String agencyPhone) {
		this.agencyPhone = agencyPhone;
	}
	public String getAgencyAddress() {
		return agencyAddress;
	}
	public void setAgencyAddress(String agencyAddress) {
		this.agencyAddress = agencyAddress;
	}
	public String getWorkingHours() {
		return workingHours;
	}
	public void setWorkingHours(String workingHours) {
		this.workingHours = workingHours;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public Integer getBedNumber() {
		return bedNumber;
	}
	public void setBedNumber(Integer bedNumber) {
		this.bedNumber = bedNumber;
	}
	public String getServeTarget() {
		return serveTarget;
	}
	public void setServeTarget(String serveTarget) {
		this.serveTarget = serveTarget;
	}
	public String getGovernmentSubsidy() {
		return governmentSubsidy;
	}
	public void setGovernmentSubsidy(String governmentSubsidy) {
		this.governmentSubsidy = governmentSubsidy;
	}
	public String getMedicalService() {
		return medicalService;
	}
	public void setMedicalService(String medicalService) {
		this.medicalService = medicalService;
	}
	public String getProfessionalCare() {
		return professionalCare;
	}
	public void setProfessionalCare(String professionalCare) {
		this.professionalCare = professionalCare;
	}
	public String getFeatureService() {
		return featureService;
	}
	public void setFeatureService(String featureService) {
		this.featureService = featureService;
	}
	
	
	
	public AgencyData() {
		
	}
	

	public AgencyData(Integer id, String agencyName, String agencyType, byte[] agencyPhoto, String agencyPhone,
			String agencyAddress, String workingHours, String roomType, Integer bedNumber, String serveTarget,
			String governmentSubsidy, String medicalService, String professionalCare, String featureService) {
		super();
		this.id = id;
		this.agencyName = agencyName;
		this.agencyType = agencyType;
		this.agencyPhoto = agencyPhoto;
		this.agencyPhone = agencyPhone;
		this.agencyAddress = agencyAddress;
		this.workingHours = workingHours;
		this.roomType = roomType;
		this.bedNumber = bedNumber;
		this.serveTarget = serveTarget;
		this.governmentSubsidy = governmentSubsidy;
		this.medicalService = medicalService;
		this.professionalCare = professionalCare;
		this.featureService = featureService;
	}
	@Override
	public String toString() {
		return "AgencyData [id=" + id + ", agencyName=" + agencyName + ", agencyType=" + agencyType + ", agencyPhoto="
				+ Arrays.toString(agencyPhoto) + ", agencyPhone=" + agencyPhone + ", agencyAddress=" + agencyAddress
				+ ", workingHours=" + workingHours + ", roomType=" + roomType + ", bedNumber=" + bedNumber
				+ ", serveTarget=" + serveTarget + ", governmentSubsidy=" + governmentSubsidy + ", medicalService="
				+ medicalService + ", professionalCare=" + professionalCare + ", featureService=" + featureService
				+ "]";
	}
	
	
	
	
	
	
	
	
	
}
