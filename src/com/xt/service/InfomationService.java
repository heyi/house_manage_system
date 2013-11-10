package com.xt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xt.domain.Infomation;
import com.xt.persistence.InfomationMapper;

@Service
public class InfomationService {

	@Autowired
	private InfomationMapper infoMapper;

	public Infomation getInfomationById(Integer id) {
		return infoMapper.getInfomationById(id);
	}

	public int deleteInfomationById(Integer id) {
		return infoMapper.deleteInfomationById(id);
	}

	public List<Infomation> getInfomationListForSearch(Map<String, Object> map) {
		return infoMapper.getInfomationListForSearch(map);
	}
	
	public int getInfomationCountForSearch(Map<String, Object> map){
		return infoMapper.getInfomationCountForSearch(map);
	}

	public int updateInfomationById(Infomation info) {
		return infoMapper.updateInfomationById(info);
	}

	public int insertInfomation(Infomation info) {
		return infoMapper.insertInfomation(info);
	}

}
