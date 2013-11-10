package com.xt.persistence;


import java.util.List;
import java.util.Map;

import com.xt.domain.Land;

public interface LandMapper {

  Land getLandById(Integer id);
  int deleteLandById(Integer id);
  
  List<Land> getLandListForSearch(Map<String, Object> map);
  int getLandCountForSearch(Map<String, Object> map);
  
  int updateLandById(Land land);
  int insertLand(Land land);
  
}
