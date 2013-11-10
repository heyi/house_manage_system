package com.xt.persistence;


import java.util.List;
import java.util.Map;

import com.xt.domain.Buildings;


public interface BuildingsMapper {

  List<Buildings> getBuildingsByKeywords(Map<String, Object> map);
  int getBuildingsCountByKeywords(Map<String, Object> map);
  int updateBuildingsById(Buildings buildings);
  int insertBuildings(Buildings buildings);
  int deleteBuildingsById(int buildingsId);
}
