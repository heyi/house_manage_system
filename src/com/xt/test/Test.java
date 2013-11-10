package com.xt.test;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

public class Test {

	/**
	 * @param args
	 */
	 public static void main(String[] args){ 
         //Map -> JSON 
        String json = "{\"date\":\"2012-01-02\",\"name\":\"wlz\"}";
         //JSON -> Map 
         Map<String,Object> map1 = JSON.parseObject(json, new TypeReference<Map<String, Object>>() {}); 
         for (String key : map1.keySet()) { 
                 System.out.println(key+":"+map1.get(key)); 
         } 
 } 

}
