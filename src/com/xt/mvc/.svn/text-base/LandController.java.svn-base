package com.xt.mvc;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.xt.domain.Buildings;
import com.xt.domain.House;
import com.xt.domain.Land;
import com.xt.service.BuildingsService;
import com.xt.service.HouseService;
import com.xt.service.LandService;
import com.xt.utils.DataGrid;


@Controller
public class LandController {
	@Autowired
	private LandService landService;
	@Autowired
	private HouseService houseService;
	
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
	
	/**
	 * excel导入
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/app/importExcel", method = RequestMethod.POST)
	public 	String importExcel(HttpServletRequest request,ModelMap model) {
		String excelType = request.getParameter("excelType");
		int rs = 0;
		
		try {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(4096);
			factory.setRepository(new File(request.getSession().getServletContext().getRealPath("/tmp/")));
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(100 * 1024 * 1024); 
			List fileItems = upload.parseRequest(request);
			Iterator iter = fileItems.iterator();
			String img_path="";
			for (; iter.hasNext();) {
				FileItem fileItem = (FileItem) iter.next();
				String paramName = fileItem.getFieldName();
				String paramValue = fileItem.getString();
				paramValue = new String(paramValue.getBytes("ISO8859-1"),
						"UTF-8");
				if (fileItem.isFormField()) {
//					if("stadiaCode".equals(paramName))
//						stadiaCode = paramValue;
//					else if("deviceId".equals(paramName))
//						deviceid = paramValue;
//					else if("sensorId".equals(paramName))
//						sensorid = paramValue;
//					System.out.println(stadiaCode+"|"+deviceid+"|"+sensorid);
				}else {
					String fileName = fileItem.getName();
					System.out.println(fileName);
					int pos = fileName.lastIndexOf("\\");
					if (pos > 0)
						fileName = fileName.substring(pos + 1);
					if (img_path.equals("")) {
						img_path = fileName;
					} else {
						img_path = img_path + "|" + fileName;
					}
					fileItem.write(new File(request.getSession().getServletContext().getRealPath("/uploadfile/") +"/"+ fileName));
					try {
			            //打开文件
			            Workbook book = Workbook.getWorkbook(new File(request.getSession().getServletContext().getRealPath("/uploadfile/") +"/"+ fileName)) ;
			            //取得第一个sheet
			            Sheet sheet = book.getSheet(0);
			            //取得行数
			            int rows = sheet.getRows();
			            
			            if("land".equalsIgnoreCase(excelType)){
				            List<Land> list = new ArrayList<Land>();
				    		Land land = null;
				            for(int i = 1; i < rows; i++) {//去除第一行表头
				            	land = new Land();
			                    //getCell(列，行)
				            	land.setListNo(sheet.getCell(1, i).getContents());
			                    list.add(land);
				            }
				            //关闭文件
				            book.close();
				            rs = landService.insertLandBatch(list);
			            }else{
			            	List<House> list = new ArrayList<House>();
			            	House house = null;
				            for(int i = 1; i < rows; i++) {//去除第一行表头
				            	house = new House();
			                    //getCell(列，行)
				            	house.setHouseName(sheet.getCell(1, i).getContents());
			                    list.add(house);
				            }
				            //关闭文件
				            book.close();
				            rs = houseService.insertHouseBatch(list);
			            }
			            
			        } catch (BiffException e) {
			            e.printStackTrace();
			        } catch (IOException e) {
			            e.printStackTrace();
			        } 
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String result;
		if (rs > 0) {
			result = "yes";
		} else {
			result = "no";
		}
		model.addAttribute("msg", result);
		return "import_result";
	}

}
