package com.xt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xt.domain.Buildings;
import com.xt.domain.House;
import com.xt.persistence.HouseMapper;

@Service
public class HouseService {

	@Autowired
	private HouseMapper houseMapper;

	public House getHouseById(Integer id) {
		return houseMapper.getHouseById(id);
	}

	public int deleteHouseById(Integer id) {
		return houseMapper.deleteHouseById(id);
	}

	public List<House> getHouseListForSearch(Map<String, Object> map) {
		return houseMapper.getHouseListForSearch(map);
	}
	
	public int getHouseCountForSearch(Map<String, Object> map){
		return houseMapper.getHouseCountForSearch(map);
	}

	public int updateHouseById(House house) {
		return houseMapper.updateHouseById(house);
	}

	public int insertHouse(House house) {
		return houseMapper.insertHouse(house);
	}
	
	/**
	 * 批处理excel导入
	 * @param list
	 * @return
	 */
	@Transactional
	public int insertHouseBatch(List<House> list) {
		int result = 0;
		for (House house : list) {
			result = houseMapper.insertHouse(house);
			if(result==0){
				break;
			}
		}
		return result;
	}

}
