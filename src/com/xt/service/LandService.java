package com.xt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xt.domain.Land;
import com.xt.persistence.LandMapper;

@Service
public class LandService {

	@Autowired
	private LandMapper landMapper;

	public Land getLandById(Integer id) {
		return landMapper.getLandById(id);
	}

	public int deleteLandById(Integer id) {
		return landMapper.deleteLandById(id);
	}

	public List<Land> getLandListForSearch(Map<String, Object> map) {
		return landMapper.getLandListForSearch(map);
	}
	
	public int getLandCountForSearch(Map<String, Object> map){
		return landMapper.getLandCountForSearch(map);
	}

	public int updateLandById(Land land) {
		return landMapper.updateLandById(land);
	}

	public int insertLand(Land land) {
		return landMapper.insertLand(land);
	}

}