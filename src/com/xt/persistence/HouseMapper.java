package com.xt.persistence;


import java.util.List;
import java.util.Map;

import com.xt.domain.House;

public interface HouseMapper {

  House getHouseById(Integer id);
  int deleteHouseById(Integer id);
  
  List<House> getHouseListForSearch(Map<String, Object> map);
  int getHouseCountForSearch(Map<String, Object> map);
  
  int updateHouseById(House house);
  int insertHouse(House house);
  
}
