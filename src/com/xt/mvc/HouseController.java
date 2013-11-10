package com.xt.mvc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.xt.domain.Account;
import com.xt.domain.Buildings;
import com.xt.domain.House;
import com.xt.persistence.BuildingsMapper;
import com.xt.service.HouseService;
import com.xt.utils.Constant;
import com.xt.utils.DataGrid;


@Controller
public class HouseController {
	@Autowired
	private HouseService houseService;
	@Autowired
	private BuildingsMapper buildingsMapper;
	
	/**
	 * 
	 * @param params  json:{"cityNo":""}
	 * @return
	 */
	@RequestMapping(value = "/app/getBuildings")
	public @ResponseBody
	List<Buildings> getBuildings(@RequestParam String params) {
		Map<String, Object> map = new HashMap<String,Object>();
		if(params != null && params != ""){
			map = JSON.parseObject(params, new TypeReference<Map<String, Object>>() {});
		}
		return buildingsMapper.getBuildingsByKeywords(map);
	}
	
	@RequestMapping(value = "/app/insertHouse", method = RequestMethod.GET)
	public @ResponseBody
	String insertHouse(@RequestParam String data,HttpSession session) {
		Account account = (Account)session.getAttribute(Constant.CURRENT_USER);
		House house = JSON.parseObject(data,House.class);
		house.setUserId(account.getUserId());
		int rs = houseService.insertHouse(house);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}
	
	@RequestMapping(value = "/app/searchHouse")
	public @ResponseBody
	DataGrid searchHouse(HttpServletRequest request, HttpSession session) {
		int rows = Integer.valueOf(request.getParameter("rows"));
		int page = Integer.valueOf(request.getParameter("page"));
		String params = request.getParameter("params");
		int start = (page - 1) * rows;
		Map<String, Object> map = new HashMap<String,Object>();
		if(params != null && params != ""){
			map = JSON.parseObject(params, new TypeReference<Map<String, Object>>() {});
		}
		map.put("rows", rows);
		map.put("start", start);

		DataGrid datagrid = new DataGrid();
		List<House> lands = houseService.getHouseListForSearch(map);
		int records = houseService.getHouseCountForSearch(map);
		datagrid.setTotal(records);
		datagrid.setRows(lands);
		return datagrid;
	}
	
	@RequestMapping(value = "/app/updateHouse", method = RequestMethod.GET)
	public @ResponseBody
	String updateHouse(@RequestParam String data) {
		House map = JSON.parseObject(data,House.class);
		int rs = houseService.updateHouseById(map);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}

	@RequestMapping(value = "/app/deleteHouse")
	public @ResponseBody
	String deleteHouse(@RequestParam int id) {
		int rs = houseService.deleteHouseById(id);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}
}
