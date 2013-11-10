package com.xt.filter;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.log4j.Logger;

public class CORSFilter implements Filter {

	private Logger logger = Logger.getLogger(this.getClass());

	public CORSFilter() {

	}

	public void init(FilterConfig fConfig) throws ServletException {

	}

	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		logger.info("跨域================");
		((HttpServletResponse) response).addHeader(
				"Access-Control-Allow-Origin", "*");
		chain.doFilter(request, response);
	}
}
