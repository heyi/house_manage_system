package com.xt.mvc;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class UploadController {

	/**
	 * 带文件上传的方法
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/app/uploadFile", method = RequestMethod.POST)
	public 	String uploadFile(HttpServletRequest request,ModelMap model) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("msg", "no");
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
//					map.put(paramName, paramValue);
				}else {
					String fileName = fileItem.getName();
					if(fileName != null && !fileName.equals("")){
						int pos = fileName.lastIndexOf("\\");
						if (pos > 0)
							fileName = fileName.substring(pos + 1);
						if (img_path.equals("")) {
							img_path = fileName;
						} else {
							img_path = img_path + "|" + fileName;
						}
						fileItem.write(new File(request.getSession().getServletContext().getRealPath("/uploadfile/") +"/"+ fileName));
						map.put("imgUrl", fileName);
						map.put("msg", "yes");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("result", map);
		return "upload_result";
	}

}
