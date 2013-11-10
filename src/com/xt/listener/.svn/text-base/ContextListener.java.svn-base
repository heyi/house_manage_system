package com.xt.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.xt.utils.Constant;


public class ContextListener implements ServletContextListener {

	private Logger logger=Logger.getLogger(this.getClass());
	
	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	public void contextInitialized(ServletContextEvent event) {
		systemInitialize(event);
	}
	
	private void systemInitialize(ServletContextEvent event){
		ServletContext application = event.getServletContext();
//		String applicationName = application.getInitParameter("application_name");
//		logger.info(applicationName+"启动初始化......");
//		ApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(application);
//		SystemConfig sysconf = ((SystemConfigService)wac.getBean("systemConfigService")).getSystemConfigByCode(application.getInitParameter("IrrigationDistrict_code"));
//		application.setAttribute(Constant.SYSTEM_CONFIG, sysconf);
//		logger.info(applicationName+"初始化成功!当前灌区是【" + sysconf.getSystemName()+"】");
//		wac.getBean("smsThread");
		
	}

}
