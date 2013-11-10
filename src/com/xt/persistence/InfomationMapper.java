package com.xt.persistence;


import java.util.List;
import java.util.Map;

import com.xt.domain.Infomation;

public interface InfomationMapper {

  Infomation getInfomationById(Integer id);
  int deleteInfomationById(Integer id);
  
  List<Infomation> getInfomationListForSearch(Map<String, Object> map);
  int getInfomationCountForSearch(Map<String, Object> map);
  
  int updateInfomationById(Infomation land);
  int insertInfomation(Infomation land);
  
}
