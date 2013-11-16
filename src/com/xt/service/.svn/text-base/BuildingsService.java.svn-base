package com.xt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xt.domain.Buildings;
import com.xt.domain.Land;
import com.xt.persistence.BuildingsMapper;

@Service
public class BuildingsService {

	@Autowired
	private BuildingsMapper buildingsMapper;


	public int deleteBuildingsById(Integer id) {
		return buildingsMapper.deleteBuildingsById(id);
	}

	public List<Buildings> getBuildingsByKeywords(Map<String, Object> map) {
		return buildingsMapper.getBuildingsByKeywords(map);
	}
	
	public int getBuildingsCountByKeywords(Map<String, Object> map){
		return buildingsMapper.getBuildingsCountByKeywords(map);
	}

	public int updateBuildingsById(Buildings buildings) {
		return buildingsMapper.updateBuildingsById(buildings);
	}

	public int insertBuildings(Buildings buildings) {
		return buildingsMapper.insertBuildings(buildings);
	}
}
