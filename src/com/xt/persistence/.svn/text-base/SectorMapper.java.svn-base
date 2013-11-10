package com.xt.persistence;


import java.util.List;
import java.util.Map;

import com.xt.domain.Sector;

public interface SectorMapper {

  Sector getSectorById(Integer id);
  int deleteSectorById(Integer id);
  
  List<Sector> getSectorListForSearch(Map<String, Object> map);
  int getSectorCountForSearch(Map<String, Object> map);
  
  int updateSectorById(Sector sector);
  int insertSector(Sector sector);
  
  List<Sector> getSectorListByCityNo(String cityNo);
  
  
}
