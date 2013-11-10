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
import com.xt.domain.Land;
import com.xt.service.LandService;
import com.xt.utils.DataGrid;


@Controller
public class LandController {
	@Autowired
	private LandService landService;
	
	@RequestMapping(value = "/app/insertLand", method = RequestMethod.GET)
	public @ResponseBody
	String insertLand(@RequestParam String data) {
//		GsonBuilder gsonBuilder = new GsonBuilder();  
//        gsonBuilder.registerTypeAdapter(Object.class, new NaturalDeserializer());  
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();;
		Land map = JSON.parseObject(data,Land.class);
		int rs = landService.insertLand(map);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}
	
	@RequestMapping(value = "/app/searchLand")
	public @ResponseBody
	DataGrid searchLand(HttpServletRequest request, HttpSession session) {
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
		List<Land> lands = landService.getLandListForSearch(map);
		int records = landService.getLandCountForSearch(map);
		datagrid.setTotal(records);
		datagrid.setRows(lands);
		return datagrid;
	}
	
	@RequestMapping(value = "/app/updateLand", method = RequestMethod.GET)
	public @ResponseBody
	String updateLand(@RequestParam String data) {
//		Gson gson = new Gson();
//		Map<String, Object> map = gson.fromJson(data,
//				new TypeToken<Map<String, String>>() {
//				}.getType());
		Land map = JSON.parseObject(data,Land.class);
		int rs = landService.updateLandById(map);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}

	@RequestMapping(value = "/app/deleteLand")
	public @ResponseBody
	String deleteLand(@RequestParam int id) {
		int rs = landService.deleteLandById(id);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}
}
