package com.xt.domain;

import java.io.Serializable;

public class City implements Serializable {
	private static final long serialVersionUID = 4421957081131973936L;
	private String cityNo;
	private String cityName;
	private String parentNo;
	private String lat;
	private String lng;
	public String getCityNo() {
		return cityNo;
	}
	public void setCityNo(String cityNo) {
		this.cityNo = cityNo;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getParentNo() {
		return parentNo;
	}
	public void setParentNo(String parentNo) {
		this.parentNo = parentNo;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
}

