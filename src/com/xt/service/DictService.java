package com.xt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xt.domain.City;
import com.xt.domain.Dict;
import com.xt.persistence.DictMapper;

@Service
public class DictService {

	@Autowired
	private DictMapper dictMapper;
	
	public String getLandUseTree(){
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("parentId", "0");
		List<Dict> parent = this.getLandUseDict(map);
		int i=0;
		for (Dict landUse : parent) {
			sb.append("{\"id\":\"" + landUse.getDictId() + "\",\"state\":\"closed\",\"text\":\"" + landUse.getDictName() + "\"");
			map = new HashMap<String,Object>();
			map.put("parentId", landUse.getDictId());
			List<Dict> children = this.getLandUseDict(map);
			if(children.size()>0){
				sb.append(",\"children\":[");
				int j = 0;
				for (Dict landUse2 : children) {
					sb.append("{\"id\":\"" + landUse2.getDictId() + "\",\"text\":\"" + landUse2.getDictName() + "\"}");
					j++;
					if(j<children.size()){
						sb.append(",");
					}
				}
				sb.append("]"); 
			}
			sb.append("}");
			i++;
			if(i<parent.size()){
				sb.append(",");
			}
		}
		sb.append("]");
		return sb.toString();
	}
	
	public List<Dict> getLandUseDict(Map<String,Object> map){
		return dictMapper.getLandUseDict(map);
	}

	public List<City> getCityList(Map<String,Object> map){
		return dictMapper.getCityList(map);
	}
	
	public String getCityTree(){
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("parentNo", "43");
		List<City> parent = this.getCityList(map);
		int i=0;
		for (City city : parent) {
			sb.append("{\"id\":\"" + city.getCityNo() + "\",\"state\":\"closed\",\"text\":\"" + city.getCityName() + "\",\"attributes\":{\"lat\":\""+city.getLat()+"\",\"lng\":\""+city.getLng()+"\"},\"children\":[");
			map = new HashMap<String,Object>();
			map.put("parentNo", city.getCityNo());
			List<City> children = this.getCityList(map);
			int j = 0;
			for (City city2 : children) {
				sb.append("{\"id\":\"" + city2.getCityNo() + "\",\"text\":\"" + city2.getCityName() + "\",\"attributes\":{\"lat\":\""+city2.getLat()+"\",\"lng\":\""+city2.getLng()+"\"}}");
				j++;
				if(j<children.size()){
					sb.append(",");
				}
			}
			sb.append("]}"); 
			i++;
			if(i<parent.size()){
				sb.append(",");
			}
		}
		sb.append("]");
		return sb.toString();
	}
	
	/**
	 * 批处理excel导入
	 * @param list
	 * @return
	 */
	@Transactional
	public int insertCityBatch(List<City> list) {
		int result = 0;
		for (City city : list) {
			result = dictMapper.insertCity(city);
			if(result==0){
				break;
			}
		}
		return result;
	}
	
	public String getSystemTime(){
		return dictMapper.getSystemTime();
	}
}
