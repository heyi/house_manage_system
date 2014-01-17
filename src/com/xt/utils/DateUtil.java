package com.xt.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

	public static Date convertDate(String str, String format) {
		Date date = null;
		try {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
			date = simpleDateFormat.parse(str);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return date;
	}
	
	public static void main(String[] args){
		System.out.println(convertDate("2012/3/12", "yyyy/MM/dd").toString());
	}
}
