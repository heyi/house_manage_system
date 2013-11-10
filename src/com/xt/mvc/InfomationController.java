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
import com.xt.domain.Infomation;
import com.xt.service.InfomationService;
import com.xt.utils.Constant;
import com.xt.utils.DataGrid;


@Controller
public class InfomationController {
	@Autowired
	private InfomationService infomationService;
	
	@RequestMapping(value = "/app/insertInfomation", method = RequestMethod.GET)
	public @ResponseBody
	String insertInfomation(@RequestParam String data,HttpSession session) {
		Account account = (Account)session.getAttribute(Constant.CURRENT_USER);
		Infomation info = JSON.parseObject(data,Infomation.class);
		info.setUserId(account.getUserId());
		int rs = infomationService.insertInfomation(info);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}
	
	@RequestMapping(value = "/app/searchInfomation")
	public @ResponseBody
	DataGrid searchInfomation(HttpServletRequest request, HttpSession session) {
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
		List<Infomation> lands = infomationService.getInfomationListForSearch(map);
		int records = infomationService.getInfomationCountForSearch(map);
		datagrid.setTotal(records);
		datagrid.setRows(lands);
		return datagrid;
	}
	
	@RequestMapping(value = "/app/updateInfomation", method = RequestMethod.GET)
	public @ResponseBody
	String updateInfomation(@RequestParam String data) {
//		Gson gson = new Gson();
//		Map<String, Object> map = gson.fromJson(data,
//				new TypeToken<Map<String, String>>() {
//				}.getType());
		Infomation map = JSON.parseObject(data,Infomation.class);
		int rs = infomationService.updateInfomationById(map);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}

	@RequestMapping(value = "/app/deleteInfomation")
	public @ResponseBody
	String deleteInfomation(@RequestParam int id) {
		int rs = infomationService.deleteInfomationById(id);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}
}
