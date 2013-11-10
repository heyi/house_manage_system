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
import com.xt.domain.Sector;
import com.xt.service.SectorService;
import com.xt.utils.DataGrid;


@Controller
public class SectorController {
	@Autowired
	private SectorService sectorService;
	
	@RequestMapping(value = "/app/insertSector", method = RequestMethod.GET)
	public @ResponseBody
	String insertSector(@RequestParam String data) {
//		GsonBuilder gsonBuilder = new GsonBuilder();  
//        gsonBuilder.registerTypeAdapter(Object.class, new NaturalDeserializer());  
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();;
		Sector map = JSON.parseObject(data,Sector.class);
		int rs = sectorService.insertSector(map);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}
	
	@RequestMapping(value = "/app/searchSector")
	public @ResponseBody
	DataGrid searchSector(HttpServletRequest request, HttpSession session) {
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
		List<Sector> lands = sectorService.getSectorListForSearch(map);
		int records = sectorService.getSectorCountForSearch(map);
		datagrid.setTotal(records);
		datagrid.setRows(lands);
		return datagrid;
	}
	
	@RequestMapping(value = "/app/updateSector", method = RequestMethod.GET)
	public @ResponseBody
	String updateSector(@RequestParam String data) {
//		Gson gson = new Gson();
//		Map<String, Object> map = gson.fromJson(data,
//				new TypeToken<Map<String, String>>() {
//				}.getType());
		Sector map = JSON.parseObject(data,Sector.class);
		int rs = sectorService.updateSectorById(map);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}

	@RequestMapping(value = "/app/deleteSector")
	public @ResponseBody
	String deleteSector(@RequestParam int id) {
		int rs = sectorService.deleteSectorById(id);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}
	
	@RequestMapping(value = "/app/getSectorListByCityNo")
	public @ResponseBody
	List<Sector> getSectorListByCityNo(@RequestParam String cityNo) {
		return  sectorService.getSectorListByCityNo(cityNo);
	}
}
