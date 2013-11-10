package com.xt.listener;

import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import org.apache.log4j.Logger;

import com.xt.utils.Constant;

public class OnLineUserListener implements HttpSessionAttributeListener {

	private static final Logger log = Logger
			.getLogger(OnLineUserListener.class);

	/**
	 * 存放在线用户列表
	 */
	public static List<String> onLineUserList = new LinkedList<String>();

	/**
	 * 根据用户ID，查询用户是否在线
	 * 
	 * @param userName
	 *            用户ID
	 * @return true:表示用户在线 false:表示用户离线
	 */
	public static boolean findUserOnLine(String userName) {
		return onLineUserList.contains(userName);
	}

	/**
	 * 用户登录时候，把用户的信息存到userSession里
	 */
	@Override
	public void attributeAdded(HttpSessionBindingEvent se) {
		if (Constant.CURRENT_USER.equals(se.getName())) {
			/**
			 * 用户上线的话，把用户的ID，添加到onLineUserList里
			 */
//			String userName = ((Account) se.getValue()).getUsername();
//			onLineUserList.add(userName);
//			log.info("用户ID：" + userName + " 上线了。。。");
		}
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent se) {
		if (Constant.CURRENT_USER.equals(se.getName())) {
			/**
			 * 用户下线的话，把用户的ID，从onLineUserList中移除
			 */
//			String userName = ((Account) se.getValue()).getUsername();
//			onLineUserList.remove(userName);
//			log.info("用户ID：" + userName + " 下线了。。。");
		}
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent se) {
		// TODO Auto-generated method stub

	}
}
