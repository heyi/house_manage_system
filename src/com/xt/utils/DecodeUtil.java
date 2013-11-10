package com.xt.utils;

import java.io.UnsupportedEncodingException;

public class DecodeUtil {
	
	/**
	 * 解决页面传参中文乱码问题，将iso转换成utf-8
	 * @param str
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String iso2utf(String str) {
		String result = null;
		try {
			result = new String(str.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

}
