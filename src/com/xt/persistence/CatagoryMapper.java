package com.xt.persistence;

import java.util.List;
import java.util.Map;

import com.xt.domain.Catagory;

public interface CatagoryMapper {

	Catagory getCatagoryById(Integer id);

	int deleteCatagoryById(Integer id);

	List<Catagory> getCatagoryListForSearch(Map<String, Object> map);

	int getCatagoryCountForSearch(Map<String, Object> map);

	int updateCatagoryById(Catagory catagory);

	int insertCatagory(Catagory catagory);
}
