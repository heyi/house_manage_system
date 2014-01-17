package com.xt.mvc;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
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
import com.xt.domain.City;
import com.xt.domain.House;
import com.xt.domain.Land;
import com.xt.service.BuildingsService;
import com.xt.service.DictService;
import com.xt.service.HouseService;
import com.xt.service.LandService;
import com.xt.utils.DataGrid;
import com.xt.utils.DateUtil;


@Controller
public class LandController {
	@Autowired
	private LandService landService;
	@Autowired
	private HouseService houseService;
	@Autowired
	private DictService dictService;
	
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
		String houseType = request.getParameter("houseType");
		String dealType = request.getParameter("dealType");
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
			            System.out.println("rows:" + rows);
			            if("land".equalsIgnoreCase(excelType)){
				            List<Land> list = new ArrayList<Land>();
				    		Land land = null;
				            for(int i = 1; i < rows; i++) {//去除第一行表头
				            	if(sheet.getCell(4, i).getContents().equalsIgnoreCase("") || sheet.getCell(4, i).getContents() == null){
				            		break;
				            	}
				            	land = new Land();
			                    //getCell(列，行)
				            	land.setListNo(sheet.getCell(1, i).getContents());
				            	String dd = sheet.getCell(3, i).getContents().trim();
				            	System.out.println(dd);
				            	land.setDealTime(convertDate(dd));
				            	land.setCity(sheet.getCell(4, i).getContents());
				            	land.setLocate(sheet.getCell(5, i).getContents());
				            	land.setLevel(sheet.getCell(6, i).getContents());
				            	land.setUseNo(sheet.getCell(7, i).getContents());
				            	land.setUseScale(sheet.getCell(8, i).getContents());
				            	land.setAcreage(convertFloat(sheet.getCell(9, i).getContents()));
				            	land.setAreaRatio(sheet.getCell(10, i).getContents());
				            	land.setAgeLimit(sheet.getCell(11, i).getContents());
				            	land.setStartingPrice(convertFloat(sheet.getCell(12, i).getContents()));
				            	land.setTotalPrice(convertFloat(sheet.getCell(13, i).getContents()));
				            	land.setUnitPrice1(convertFloat(sheet.getCell(14, i).getContents()));
				            	land.setUnitPrice2(convertFloat(sheet.getCell(15, i).getContents()));
				            	land.setFloorPrice(convertFloat(sheet.getCell(16, i).getContents()));
				            	land.setBidTimes(convertInteger(sheet.getCell(17, i).getContents()));
				            	land.setDealUnit(sheet.getCell(18, i).getContents());
				            	land.setRemark(sheet.getCell(19, i).getContents());
			                    list.add(land);
				            }
				            //关闭文件
				            book.close();
				            rs = landService.insertLandBatch(list);
			            }else if("house".equalsIgnoreCase(excelType)){
			            	List<House> list = new ArrayList<House>();
			            	House house = null;
				            for(int i = 1; i < rows; i++) {//去除第一行表头
				            	if(sheet.getCell(1, i).getContents().equalsIgnoreCase("") || sheet.getCell(1, i).getContents() == null){
				            		break;
				            	}
				            	house = new House();
				            	house.setHouseType(houseType);
				            	house.setDealType(dealType);
			                    //getCell(列，行)
				            	house.setHouseName(sheet.getCell(1, i).getContents());
				            	house.setHouseNo(sheet.getCell(2, i).getContents());
				            	house.setDealTime(convertDate(sheet.getCell(3, i).getContents()));
				            	house.setCityNo(sheet.getCell(4, i).getContents());
				            	house.setLocate(sheet.getCell(5, i).getContents());
				            	house.setRealUse(sheet.getCell(6, i).getContents());
				            	house.setStructure(sheet.getCell(7, i).getContents());
				            	house.setConstructionArea(convertFloat(sheet.getCell(8, i).getContents()));
				            	house.setPoolArea(convertFloat(sheet.getCell(9, i).getContents()));
				            	house.setBuildingDate(sheet.getCell(10, i).getContents());
				            	house.setNewSituation(sheet.getCell(11, i).getContents());
				            	house.setTotalFloor(convertInteger(sheet.getCell(12, i).getContents()));
				            	house.setFloor(convertInteger(sheet.getCell(13, i).getContents()));
				            	house.setFloorHeight(convertFloat(sheet.getCell(14, i).getContents()));
				            	house.setDecorateSituation(sheet.getCell(15, i).getContents());
				            	house.setLandUseRight(sheet.getCell(16, i).getContents());
				            	house.setLandExpiredDate(convertDate(sheet.getCell(17, i).getContents()));
				            	house.setHirePrice(convertFloat(sheet.getCell(18, i).getContents()));
				            	house.setContactTel(sheet.getCell(19, i).getContents());
				            	house.setCollecter(sheet.getCell(20, i).getContents());
				            	house.setRemark(sheet.getCell(21, i).getContents());
				            	if("1".equalsIgnoreCase(houseType) && "1".equalsIgnoreCase(dealType)){
					            	house.setCaseNo(sheet.getCell(22, i).getContents());
					            	house.setBusinessState(sheet.getCell(23, i).getContents());
					            	house.setStreetSide(sheet.getCell(24, i).getContents());
					            	house.setStreetLength(sheet.getCell(25, i).getContents());
					            	house.setDepth(sheet.getCell(26, i).getContents());
					            	house.setTotalPrice(convertFloat(sheet.getCell(27, i).getContents()));
					            	house.setUnitPrice(convertFloat(sheet.getCell(28, i).getContents()));
					            	house.setHireState(sheet.getCell(29, i).getContents());
					            	house.setSupportingFacilities(sheet.getCell(30, i).getContents());
				            	}else if("1".equalsIgnoreCase(houseType) && "2".equalsIgnoreCase(dealType)){
					            	house.setCaseNo(sheet.getCell(22, i).getContents());
					            	house.setBusinessState(sheet.getCell(23, i).getContents());
					            	house.setStreetSide(sheet.getCell(24, i).getContents());
					            	house.setStreetLength(sheet.getCell(25, i).getContents());
					            	house.setDepth(sheet.getCell(26, i).getContents());
					            	house.setHireExpiredDate(sheet.getCell(27, i).getContents());
					            	house.setHireUnitPrice(convertFloat(sheet.getCell(28, i).getContents()));
					            	house.setTransferFee(convertFloat(sheet.getCell(29, i).getContents()));
					            	house.setPropertyManagementFee(convertFloat(sheet.getCell(30, i).getContents()));
				            	}else if("2".equalsIgnoreCase(houseType) && "1".equalsIgnoreCase(dealType)){
					            	house.setCaseNo(sheet.getCell(22, i).getContents());
					            	house.setSupportingFacilities(sheet.getCell(23, i).getContents());
					            	house.setTotalPrice(convertFloat(sheet.getCell(24, i).getContents()));
					            	house.setUnitPrice(convertFloat(sheet.getCell(25, i).getContents()));
					            	house.setHireState(sheet.getCell(26, i).getContents());
					            	house.setApartment(sheet.getCell(27, i).getContents());
				            	}else if("2".equalsIgnoreCase(houseType) && "2".equalsIgnoreCase(dealType)){
					            	house.setCaseNo(sheet.getCell(22, i).getContents());
					            	house.setSupportingFacilities(sheet.getCell(23, i).getContents());
					            	house.setHireExpiredDate(sheet.getCell(24, i).getContents());
					            	house.setHireUnitPrice(convertFloat(sheet.getCell(25, i).getContents()));
					            	house.setDeposit(convertFloat(sheet.getCell(26, i).getContents()));
				            	}else if("3".equalsIgnoreCase(houseType) && "1".equalsIgnoreCase(dealType)){
					            	house.setStreetSide(sheet.getCell(22, i).getContents());
					            	house.setOfficeFacilities(sheet.getCell(23, i).getContents());
					            	house.setParkingFacilities(sheet.getCell(24, i).getContents());
					            	house.setUnitPrice(convertFloat(sheet.getCell(25, i).getContents()));
					            	house.setTotalPrice(convertFloat(sheet.getCell(26, i).getContents()));
					            	house.setHireState(sheet.getCell(27, i).getContents());
				            	}else if("3".equalsIgnoreCase(houseType) && "2".equalsIgnoreCase(dealType)){
				            		house.setStreetSide(sheet.getCell(22, i).getContents());
					            	house.setOfficeFacilities(sheet.getCell(23, i).getContents());
					            	house.setParkingFacilities(sheet.getCell(24, i).getContents());
					            	house.setHireExpiredDate(sheet.getCell(25, i).getContents());
					            	house.setDeposit(convertFloat(sheet.getCell(26, i).getContents()));
				            	}else if("4".equalsIgnoreCase(houseType) && "1".equalsIgnoreCase(dealType)){
					            	house.setStreetSide(sheet.getCell(22, i).getContents());
					            	house.setPilespacing(convertFloat(sheet.getCell(23, i).getContents()));
					            	house.setSpan(convertFloat(sheet.getCell(24, i).getContents()));
					            	house.setCraneBeam(sheet.getCell(25, i).getContents());
					            	house.setUnitPrice(convertFloat(sheet.getCell(26, i).getContents()));
					            	house.setTotalPrice(convertFloat(sheet.getCell(27, i).getContents()));
					            	house.setHireState(sheet.getCell(28, i).getContents());
				            	}else if("4".equalsIgnoreCase(houseType) && "2".equalsIgnoreCase(dealType)){
				            		house.setStreetSide(sheet.getCell(22, i).getContents());
					            	house.setPilespacing(convertFloat(sheet.getCell(23, i).getContents()));
					            	house.setSpan(convertFloat(sheet.getCell(24, i).getContents()));
					            	house.setCraneBeam(sheet.getCell(25, i).getContents());
					            	house.setHireExpiredDate(sheet.getCell(26, i).getContents());
					            	house.setDeposit(convertFloat(sheet.getCell(27, i).getContents()));
				            	}
				            	
			                    list.add(house);
				            }
				            //关闭文件
				            book.close();
				            rs = houseService.insertHouseBatch(list);
			            }else if("city".equalsIgnoreCase(excelType)){
				            List<City> list = new ArrayList<City>();
				    		City city = null;
				            for(int i = 0; i < rows; i++) {//去除第一行表头
				            	city = new City();
				            	String nn = sheet.getCell(0, i).getContents();
			                    //getCell(列，行)
				            	city.setCityNo(!nn.endsWith("00")?nn:(!nn.endsWith("0000")?nn.substring(0,4):nn.substring(0,2)));
				            	city.setCityName(sheet.getCell(1, i).getContents());
				            	city.setParentNo(!nn.endsWith("00")?nn.substring(0, 4):(!nn.endsWith("0000")?nn.substring(0,2):"00"));
			                    list.add(city);
				            }
				            //关闭文件
				            book.close();
				            rs = dictService.insertCityBatch(list);
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
	
	private Float convertFloat(String str){
		return str == null || str.length() == 0 ? null : Float.parseFloat(str);
	}
	
	private Integer convertInteger(String str){
		return str == null || str.length() == 0 ? null : Integer.parseInt(str);
	}
	private Date convertDate(String str){
		return str!=null&&!str.equals("")?(new Date(DateUtil.convertDate(str.trim(), "yyyy-MM-dd").getTime())):null;
	}

}
