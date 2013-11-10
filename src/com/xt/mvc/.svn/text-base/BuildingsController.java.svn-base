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
import com.xt.domain.Buildings;
import com.xt.service.BuildingsService;
import com.xt.utils.DataGrid;


@Controller
public class BuildingsController {
	@Autowired
	private BuildingsService sectorService;
	
	@RequestMapping(value = "/app/insertBuildings", method = RequestMethod.GET)
	public @ResponseBody
	String insertBuildings(@RequestParam String data) {
//		GsonBuilder gsonBuilder = new GsonBuilder();  
//        gsonBuilder.registerTypeAdapter(Object.class, new NaturalDeserializer());  
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();;
		Buildings map = JSON.parseObject(data,Buildings.class);
		int rs = sectorService.insertBuildings(map);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}
	
	@RequestMapping(value = "/app/searchBuildings")
	public @ResponseBody
	DataGrid searchBuildings(HttpServletRequest request, HttpSession session) {
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
		List<Buildings> lands = sectorService.getBuildingsByKeywords(map);
		int records = sectorService.getBuildingsCountByKeywords(map);
		datagrid.setTotal(records);
		datagrid.setRows(lands);
		return datagrid;
	}
	
	@RequestMapping(value = "/app/updateBuildings", method = RequestMethod.GET)
	public @ResponseBody
	String updateBuildings(@RequestParam String data) {
//		Gson gson = new Gson();
//		Map<String, Object> map = gson.fromJson(data,
//				new TypeToken<Map<String, String>>() {
//				}.getType());
		Buildings map = JSON.parseObject(data,Buildings.class);
		int rs = sectorService.updateBuildingsById(map);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}

	@RequestMapping(value = "/app/deleteBuildings")
	public @ResponseBody
	String deleteBuildings(@RequestParam int id) {
		int rs = sectorService.deleteBuildingsById(id);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}
}
