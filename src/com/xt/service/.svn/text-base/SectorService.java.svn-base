package com.xt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xt.domain.Sector;
import com.xt.persistence.SectorMapper;

@Service
public class SectorService {

	@Autowired
	private SectorMapper sectorMapper;
	
	public List<Sector> getSectorListByCityNo(String cityNo){
		return sectorMapper.getSectorListByCityNo(cityNo);
	}

	public Sector getSectorById(Integer id) {
		return sectorMapper.getSectorById(id);
	}

	public int deleteSectorById(Integer id) {
		return sectorMapper.deleteSectorById(id);
	}

	public List<Sector> getSectorListForSearch(Map<String, Object> map) {
		return sectorMapper.getSectorListForSearch(map);
	}
	
	public int getSectorCountForSearch(Map<String, Object> map){
		return sectorMapper.getSectorCountForSearch(map);
	}

	public int updateSectorById(Sector sector) {
		return sectorMapper.updateSectorById(sector);
	}

	public int insertSector(Sector sector) {
		return sectorMapper.insertSector(sector);
	}

}
