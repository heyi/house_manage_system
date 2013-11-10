package com.xt.domain;

import java.io.Serializable;

public class Dict implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6183699722758045283L;
	public static final int SENSOR = 1;
	public static final int HOIST = 2;
	public static final int DEVICE = 0;
	public static final int POWER = 3;
	public static final int SLUICE = 4;
	public static final int UNIT = 5;
	public static final int CANAL = 6;
	public static final int DEVICE_STATUS = 7;
	public static final int VIDEO_PROVIDER = 8;
	public static final int PROTOCAL_TYPE = 9;
	public static final int COMM_TYPE = 10;
	
	private int id;
	private String name;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
