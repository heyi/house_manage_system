package com.xt.domain;

import java.io.Serializable;

public class Dict implements Serializable{

	private static final long serialVersionUID = 6183699722758045283L;
	private String dictId;
	private String dictName;
	private String parentId;
	public String getDictId() {
		return dictId;
	}
	public void setDictId(String dictId) {
		this.dictId = dictId;
	}
	public String getDictName() {
		return dictName;
	}
	public void setDictName(String dictName) {
		this.dictName = dictName;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
