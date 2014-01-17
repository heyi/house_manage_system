package com.xt.domain;

import java.io.Serializable;

public class Buildings implements Serializable {

	private static final long serialVersionUID = -1024108641305149631L;
	private int buildingsId;//楼盘编号
	private String buildingsName;//楼盘名称
	private String cityNo;//城市编号
	private String cityName;
	private int sectorId;//板块编号
	private String sectorName;
	private String pinyin;//拼音
	private String pinyinLetter;//拼音首字母
	private String buildingsAddress;//楼盘所在地址
	
	public String getSectorName() {
		return sectorName;
	}
	public void setSectorName(String sectorName) {
		this.sectorName = sectorName;
	}
	public int getBuildingsId() {
		return buildingsId;
	}
	public void setBuildingsId(int buildingsId) {
		this.buildingsId = buildingsId;
	}
	public String getBuildingsName() {
		return buildingsName;
	}
	public void setBuildingsName(String buildingsName) {
		this.buildingsName = buildingsName;
	}
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
	public int getSectorId() {
		return sectorId;
	}
	public void setSectorId(int sectorId) {
		this.sectorId = sectorId;
	}
	public String getPinyin() {
		return pinyin;
	}
	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}
	public String getPinyinLetter() {
		return pinyinLetter;
	}
	public void setPinyinLetter(String pinyinLetter) {
		this.pinyinLetter = pinyinLetter;
	}
	public String getBuildingsAddress() {
		return buildingsAddress;
	}
	public void setBuildingsAddress(String buildingsAddress) {
		this.buildingsAddress = buildingsAddress;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
