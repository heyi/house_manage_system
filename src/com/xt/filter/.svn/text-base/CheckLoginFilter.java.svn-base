package com.xt.filter;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.xt.service.DictService;
import com.xt.utils.Constant;


public class CheckLoginFilter implements Filter {
	
	private static final Logger log = Logger.getLogger(CheckLoginFilter.class);


	public void destroy() {

	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain chain) throws IOException, ServletException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;
		String uri = request.getRequestURI();
		String path = request.getContextPath();
		HttpSession session = request.getSession(true);
		ApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
		try {
			long curTime = sdf.parse(((DictService)wac.getBean("dictService")).getSystemTime()).getTime();
			long expiredTime = sdf.parse(Constant.EXPIRED_TIME).getTime();
			if(curTime > expiredTime && !uri.equals(new StringBuffer(path).append("/app/login.jsp").toString())){
				response.sendRedirect(path + "/app/login.jsp?error_code=99");
				return;
			}
//			log.error("系统当前时间：" + new Date(curTime) + "|系统失效时间：" + new Date(expiredTime));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if(session.getAttribute(Constant.CURRENT_USER) != null){
			chain.doFilter(request, response);
			return;
		}else if(!uri.equals(new StringBuffer(path).append("/").toString())
				&& !uri.equals(new StringBuffer(path).append("/login.jsp").toString())
				&& !uri.equals(new StringBuffer(path).append("/app/login.jsp").toString())
				&& !uri.equals(new StringBuffer(path).append("/login.do").toString())){

			//判断是否为ajax请求
			if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
				HttpServletResponse httpResponse = (HttpServletResponse)response;
				httpResponse.addHeader("sessionstatus", "timeOut");
				httpResponse.addHeader("loginPath",path + "/app/login.jsp?error_code=2");
				chain.doFilter(request, response);//不可少，否则请求会出错
			}else{//不是ajax请求，超时直接重定向
				response.sendRedirect(path + "/app/login.jsp?error_code=2");
			}
				
			return;
		}
		chain.doFilter(request, arg1);
	}

	public void init(FilterConfig arg0) throws ServletException {

	}

}
