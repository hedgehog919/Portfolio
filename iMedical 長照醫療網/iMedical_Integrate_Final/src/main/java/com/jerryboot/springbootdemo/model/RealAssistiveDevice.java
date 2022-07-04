package com.jerryboot.springbootdemo.model;

import java.util.Arrays;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="real_assistive_device")
public class RealAssistiveDevice {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private Integer id;
	
	
	
	@Column(name="assistivce_device_name", columnDefinition = "nvarchar(100)")
	private String assistiveDeviceName;
	@Column(name="assistive_device_description", columnDefinition = "nvarchar(500)")
	private String assistiveDeviceDescription;
	
	@Column(name="assistive_device_img", columnDefinition = "varbinary(max)")
	private byte[] assistiveDeviceImg;
	
	
	
	
	public RealAssistiveDevice() {
		// TODO Auto-generated constructor stub
	}




	public Integer getId() {
		return id;
	}




	public void setId(Integer id) {
		this.id = id;
	}




	public String getAssistiveDeviceName() {
		return assistiveDeviceName;
	}




	public void setAssistiveDeviceName(String assistiveDeviceName) {
		this.assistiveDeviceName = assistiveDeviceName;
	}




	public String getAssistiveDeviceDescription() {
		return assistiveDeviceDescription;
	}




	public void setAssistiveDeviceDescription(String assistiveDeviceDescription) {
		this.assistiveDeviceDescription = assistiveDeviceDescription;
	}


	
	
	
	









	public byte[] getAssistiveDeviceImg() {
		return assistiveDeviceImg;
	}




	public void setAssistiveDeviceImg(byte[] assistiveDeviceImg) {
		this.assistiveDeviceImg = assistiveDeviceImg;
	}




	@Override
	public String toString() {
		return "RealAssistiveDevice [id=" + id + ", assistiveDeviceName=" + assistiveDeviceName
				+ ", assistiveDeviceDescription=" + assistiveDeviceDescription + ", assistiveDeviceImg="
				+ Arrays.toString(assistiveDeviceImg) + "]";
	}



	
	
	
	
	
	
	
	
	
	
	
	

}
