package com.xt.domain;

import java.io.Serializable;

public class Sector implements Serializable {
	private static final long serialVersionUID = -1496153897238794631L;
	private int sectorId;
	private String sectorName;
	private String cityNo;
	public int getSectorId() {
		return sectorId;
	}
	public void setSectorId(int sectorId) {
		this.sectorId = sectorId;
	}
	public String getSectorName() {
		return sectorName;
	}
	public void setSectorName(String sectorName) {
		this.sectorName = sectorName;
	}
	public String getCityNo() {
		return cityNo;
	}
	public void setCityNo(String cityNo) {
		this.cityNo = cityNo;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	

}
