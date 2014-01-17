package com.xt.mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.xt.domain.City;
import com.xt.service.BuildingsService;
import com.xt.service.DictService;
import com.xt.utils.DataGrid;
import com.xt.utils.GetPinyin;


@Controller
public class BuildingsController {
	@Autowired
	private BuildingsService sectorService;
	@Autowired
	private DictService dictService;
	
	@RequestMapping(value = "/app/insertBuildings", method = RequestMethod.GET)
	public @ResponseBody
	String insertBuildings(@RequestParam String data) {
//		GsonBuilder gsonBuilder = new GsonBuilder();  
//        gsonBuilder.registerTypeAdapter(Object.class, new NaturalDeserializer());  
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();;
		Buildings map = JSON.parseObject(data,Buildings.class);
		map.setPinyin(GetPinyin.getPingYin(map.getBuildingsName()));
		map.setPinyinLetter(GetPinyin.getPinYinHeadChar(map.getBuildingsName()));
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
		map.setPinyin(GetPinyin.getPingYin(map.getBuildingsName()));
		map.setPinyinLetter(GetPinyin.getPinYinHeadChar(map.getBuildingsName()));
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
	
	@RequestMapping(value = "/app/getCityList", method=RequestMethod.GET)
	public void getCityList(HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8"); //设置编码格式
        response.setContentType("text/html");   //设置数据格式
        PrintWriter out;
		try {
			out = response.getWriter();
			out.print(dictService.getCityTree()); //将json数据写入流中
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}
	
	@RequestMapping(value = "/app/getLandUseDict", method=RequestMethod.GET)
	public void getLandUseDict(HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8"); //设置编码格式
        response.setContentType("text/html");   //设置数据格式
        PrintWriter out;
		try {
			out = response.getWriter();
			out.print(dictService.getLandUseTree()); //将json数据写入流中
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}
}
