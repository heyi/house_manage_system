package com.xt.mvc;

import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.xt.domain.Account;
import com.xt.listener.OnLineUserListener;
import com.xt.service.AccountService;
import com.xt.utils.Constant;
import com.xt.utils.DataGrid;


@Controller
public class AccountController {
	private static final Logger log = Logger.getLogger(AccountController.class);
	@Autowired
	private AccountService accountService;

	@RequestMapping(value = "/login")
	public String validateUser(HttpServletRequest request, HttpSession session,ModelMap model) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String validateCode = request.getParameter("validateCode");
		String validateCodeInSession = (String)session.getAttribute(Constant.VALIDATE_KEY);
		session.removeAttribute(Constant.VALIDATE_KEY);
		log.info("输入：" + validateCode + "|session：" + validateCodeInSession);
		//首先判断验证码是否正确
		if(validateCode!=null && validateCode.trim().length()!=0 && validateCode.equalsIgnoreCase(validateCodeInSession)){
			if(OnLineUserListener.findUserOnLine(username)){
				return "redirect:/app/login.jsp?error_code=4";
			}
			// 验证用户名和密码，如果成功，则跳转到首页
			Account account = accountService.getAccountByUsername(username);
			if (account != null && password.equals(account.getPassword()) && account.getIsValid().equals("1")) {
				session.setAttribute(Constant.CURRENT_USER, account);
				return "redirect:/app/parcel.jsp";
			}else{
				return "redirect:/app/login.jsp?error_code=1";
			}
		}else{
			return "redirect:/app/login.jsp?error_code=3";
		}
	}
	
	/**
	 * 退出
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpSession session) {
		Enumeration<String> enums = session.getAttributeNames();
		while (enums.hasMoreElements()) {
			session.removeAttribute(enums.nextElement());
		}
		session.invalidate();
		return "redirect:login.jsp";
	}

	@RequestMapping(value = "/app/showUsers")
	public @ResponseBody
	DataGrid showUsers(HttpServletRequest request, HttpSession session) {
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
		List<Account> users = accountService.getAccountListByKeywords(map);
		int records = accountService.getAccountCount(map);
		datagrid.setTotal(records);
		datagrid.setRows(users);
		return datagrid;
	}

	@RequestMapping(value = "/app/saveUser", method = RequestMethod.GET)
	public @ResponseBody
	String saveUser(@RequestParam String data) {
		Gson gson = new Gson();
		Map<String, Object> map = gson.fromJson(data,
				new TypeToken<Map<String, String>>() {
				}.getType());
		map.put("password", "888888");//初始密码
		int rs = accountService.insertUser(map);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}

	@RequestMapping(value = "/app/updateUser", method = RequestMethod.GET)
	public @ResponseBody
	String updateUser(@RequestParam String data) {
		Gson gson = new Gson();
		Map<String, Object> map = gson.fromJson(data,
				new TypeToken<Map<String, String>>() {
				}.getType());
		int rs = accountService.updateUser(map);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}
	
	@RequestMapping(value = "/app/getUserinfo", method = RequestMethod.GET)
	public @ResponseBody
	Account getUserinfo(HttpSession session) {
		Account account = (Account)session.getAttribute(Constant.CURRENT_USER);
		return accountService.getAccountByUserId(account.getUserId());
	}

	@RequestMapping(value = "/app/deleteUser", method = RequestMethod.GET)
	public @ResponseBody
	String deleteUser(@RequestParam int userId) {
		int rs = accountService.deleteUser(userId);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return result;
	}

	@RequestMapping(value = "/app/checkUserName", method = RequestMethod.GET)
	public @ResponseBody
	String checkUserName(@RequestParam String username) {
		Account account = accountService.getAccountByUsername(username);
		String rs = "no";
		if (account != null) {
			rs = "yes";
		}
		return rs;
	}
	
	@RequestMapping(value = "/app/editPassword", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, ? extends Object> editPassword(@RequestParam String user,HttpSession session) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		Gson gson = new Gson();
		Map<String, Object> map = gson.fromJson(user,
				new TypeToken<Map<String, String>>() {
				}.getType());
		Account account = (Account)session.getAttribute(Constant.CURRENT_USER);
		if(!account.getPassword().equals(map.get("oldPassword").toString())){
			resultMap.put("msg", "旧密码输入错误！");
			resultMap.put("result", "no");
			return resultMap;
		}
		account.setPassword(map.get("newPassword").toString());
		map = new HashMap<String,Object>();
		map.put("userId", account.getUserId());
		map.put("password", account.getPassword());
		map.put("username", account.getUsername());
		int rs = accountService.updateUser(map);
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		return Collections.singletonMap("result", result);
	}
}
