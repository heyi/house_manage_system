<%@page import="com.xt.utils.Constant"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Enumeration"%>
<%@ page isELIgnored="false"%>

<%
if(session.getAttribute(Constant.CURRENT_USER) != null){
	Enumeration<String> enums = session.getAttributeNames();
	while (enums.hasMoreElements()) {
		session.removeAttribute(enums.nextElement());
	}
	session.invalidate();
}
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
         <title>湖南新融达房地产信息管理系统</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <script src="<c:url value="/resources/js/jquery.js"/>" type="text/javascript" charset="utf-8"></script>        

        <style>
            body {
            background: url(<c:url value="/resources/css/images/cback.jpg"/>) repeat-x #0f9ca9;
            text-align: center;
            padding: 0;
            margin: 0;
            }

            .main {
            background: url(<c:url value="/resources/css/images/cover.jpg"/>) no-repeat center top;
            max-height:680px;
            height:100%;
            margin: auto;
            text-align: center
            }

            .main1 {
            width: 980px;
            height: 500px;
            position: relative;
            margin: 0 auto 0px;
            }

            .main1 .login {
            position: absolute;
            top: 254px;
            right: 164px;
            width: 225px;
            height: 200px;
            background: url(<c:url value="/resources/css/images/login_back.png"/>) no-repeat;
            padding: 15px 25px;
            }
            
            .main1 .msg {
            position: absolute;
            top: 200px;
            width: 500px;
            right: 164px;
            }

            th {
            white-space: nowrap;
            font-size: 16px;
            font-weight: normal;
            }

            td {
            text-align: left;
            padding: 0;
            }

            td input {
            height: 24px;
            border: 1px solid #bbb;
            margin: 0;
            background-color: #eee;
            }

            #username {
            background: url(<c:url value="/resources/css/images/i1.png"/>) no-repeat 5px center #eee;
            padding-left: 20px;
            width: 130px;
            }

            #password {
            background: url(<c:url value="/resources/css/images/i2.png"/>) no-repeat 5px center #eee;
            padding-left: 20px;
            width: 130px;
            }

            #validateCode {
            width: 60px;
            margin-right: 10px;
            }

            #login_btn {
            display: block;
            width: 142px;
            height: 39px;
            background: url(<c:url value="/resources/css/images/login_btn.png"/>) no-repeat;
            margin: auto;
            border: 0;
            }

            #login_btn:hover {
            background-image: url(<c:url value="/resources/css/images/login_btn_hover.png"/>);
            cursor: pointer;
            }

             .footer {
            font-size: 12px;
            color: #fff;
            text-align: left;
            width: 280px;
            line-height: 160%;
            margin: auto;
            padding: 30px 0 0 20px;
            height: 50px;
            white-space:nowrap
            }
        </style>
        <script>
        window.onload = function(){
	        $("#username").focus();
        };
        function newCode(){
            var nb = new Date().getTime();
            document["validateJpg"].src = "<c:url value="/validatecode.jpg"/>?nb="+nb;
        }
        function checkForm(){
        	var form = document.getElementById("loginForm");
        	var user = form.username.value;
        	var password = form.password.value;
        	var code = form.validateCode.value;
        	if(user.length == 0){
        		$("#log_msg").text("用户名不能为空！");
        		form.username.focus();
        		return ;
        	}
        	if(password.length == 0){
        		$("#log_msg").text("密码不能为空！");
        		form.password.focus();
        		return ;
        	}
        	if(code.length == 0){
        		$("#log_msg").text("验证码不能为空！");
        		form.validateCode.focus();
        		return ;
        	}
        	form.submit();
        }
        </script>
        <script src="<c:url value="/app/login.js"/>" type="text/javascript" charset="utf-8"></script>        
    </head>

    <body>
        <div class="main">
            <div class="main1">
                <div class="login">
                    <table width="210" border="0" cellpadding="0" cellspacing="8">
                        <form action="<c:url value="/login.do"/>" method="post" id="loginForm" name="loginForm" onsubmit="return false;">
                            <tr>
                                <th>帐&nbsp;&nbsp;&nbsp;号</th>
                                <td><input type="text" id="username" name="username" value="" /></td>
                            </tr>
                            <tr>
                                <th>密&nbsp;&nbsp;&nbsp;码</th>
                                <td><input type="password" id="password" name="password"
                                    value=""></td>
                            </tr>
                            <tr>
                                <th>验证码</th>
                                <td><table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td><input type="text" name="validateCode" id="validateCode"></td>
                                            <td><a href="javascript:newCode();" title="看不清？请点击我！"><img src="<c:url value="/validatecode.jpg"/>" name="validateJpg" width="65"
                                                    height="28" border="0" id="validateJpg"></a></td>
                                        </tr>
                                </table></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center">
                                    <input type="submit" id="login_btn" value="" onclick="checkForm()"/>
                                </td>
                            </tr>
                        </form>
                    </table>
					<span id="log_msg" style="font-size: 15px; color: red;" class="msg">
					<c:if test="${param.error_code==4}">
						<c:out value="该帐号已经登录本系统，请使用别的帐号！" />
					</c:if>
					<c:if test="${param.error_code==3}">
						<c:out value="验证码错误!" />
					</c:if>
					<c:if test="${param.error_code==2}">
						<c:out value="您还没有登录或长时间没有任何操作!" />
					</c:if>
					 <c:if test="${param.error_code==1}">
						<c:out value="用户名或者密码错误!" />
					</c:if>
					<c:if test="${param.error_code==99}">
						<c:out value="系统初始化错误！" />
					</c:if>
					</span>
                </div>
            </div>
            <div class="footer">
            温馨提示：为了您拥有更好的用户体验，请使用谷歌浏览器[<a href="chrome.zip" style="color:#ffffff">点击下载</a>]
               <!-- 
                <img src="<c:url value="/resources/css/images/copyright.png"/>" width="304" height="58">
                -->
            </div>
             
        </div>

    </body>
</html>

