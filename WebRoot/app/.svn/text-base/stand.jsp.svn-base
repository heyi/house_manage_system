<%@page import="com.xt.utils.Constant"%>
<%@page import="com.xt.domain.Account"%>
<%@page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String username = "匿名";
Account user = null;
String path = request.getContextPath();
if(session.getAttribute(Constant.CURRENT_USER)==null){
response.sendRedirect(path+"/login.jsp");
}else{
user = (Account)session.getAttribute(Constant.CURRENT_USER);
username = user.getUsername();
}
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>标准化模板</title>
        <link rel="stylesheet" type="text/css" href="../resources/themes/default/easyui.css">
        <link rel="stylesheet" type="text/css" href="../resources/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="../resources/themes/common.css">
    </script> <script src="../resources/jquery.min.js"></script>
    <script type="text/javascript" src="../resources/jquery.easyui.min.js"></script>
    <script src="../resources/locale/easyui-lang-zh_CN.js" type="text/javascript" charset="utf-8"></script>
    <script src="../resources/underscore-min.js"></script>
    <script src="../resources/ckeditor/ckeditor.js"></script>
    <script>
        var userLevel = <%=(user!=null?user.getUserRight():"0")%>
    </script>
    <style type="text/css" media="all">
        #main .datagrid-wrap { border: 0px; }
        .easyui-validatebox,.easyui-numberbox { width: 180px; }
        .sf { padding: 5px 5px; }
        .sf-tb td,#dlg_info td  { padding: 6px 4px; }
        .nav {width: 90px; margin:auto; text-align:center;}
        .nav img {display:block;width:50px;margin:auto;}
        .nav li {padding:15px 0px; list-style-type: none;}
        .nav a {text-decoration: none; padding:5px 0px; display:block;border-radius: 10px; background:#eee;}
        .nav a:hover, .nav a.active { color: #fff; background-color: #0E2D5F; }
        #dlg_info table { width: 98%; padding: 1%; }
    </style>
</head>
<body class="easyui-layout" data-options="fit:true">
    <div data-options="region:'north',border:false" class="" style="width: 50px; ">
        <div class="ui-layout-head">
            <div class="ui-layout-nav">
                <span class="ui-layout-nav-prev"></span>
                <div class="ui-layout-nav-contain">
                    <ul class="ui-layout-nav-tab">
                        <li class="ui-layout-nav-frist">
							<a href="index.jsp">首页</a>
						</li>
                        <li ><a href="parcel.jsp">土地交易案例</a></li>
                        <li><a href="house.jsp">房产交易案例</a></li>
                        <li><a href="law.jsp">政策法规</a></li>
                        <li><a href="market.jsp">市场分析</a></li>
                        <li><a href="stand.jsp"  class="ui-layout-nav-active">标准化模板</a></li>
                        <li><a href="javascript:alert('正在建设中')">统计分析</a></li>
                        <li><a href="system.jsp">系统管理</a></li>
                        <li class="ui-layout-nav-last">
							<a href="../logout.do">退出系统</a>
					    </li>
                    </ul>
                </div>
                <span class="ui-layout-nav-next"></span>
            </div>
        </div>
    </div>

    <div data-options="region:'west',split:true" title="标准化模板" style="width: 200px;">
        <div style="margin:20px 0px; ">
            搜索:
            <input id="input-search"  type="search" name="key" value="" placeholder='输入关键字' />
        </div>
        <ul id="tree1" class="easyui-tree" data-options="method:'get',lines:true, onClick:search_key"></ul>
    </div>
    <div id="main" data-options="region:'center'" style="width: 100%;">
        <table id="table1" style="width:100%; "> </table>
    </div>
</div>

<div data-options="region:'south',border:false"
    style="height: 25px; background: #E0ECFF; padding: 5px;">当前登录用户：<%=username%></div>

<div class="easyui-dialog" id="dlg3"
    data-options="iconCls:'icon-save', closed:true,modal:true,buttons:'#btns_view', inline:true"
    title="查看资料" style="width: 700px; height: 480px;;">
    <div id="dlg_info" style="width: 100%%; padding:5%; box-sizing:border-box; ">
    </div>
</div>

<script type="text/template" id="tp1">
    <h2 style="text-align:center;"><@= infoTitle @> </h2>
    <div style="width: 160px; margin:auto;">
        <@= insertTime @> 
    </div>
    <p style="text-align:left;">
        <@= content @> 
    </p>
    <p style="text-align:left;">
        附件:<a href="../uploadfile/<@= attachment @>">
            <@= attachment @> 
        </a>
    </p>
</script>
<div id="btns_view">
    <a class="easyui-linkbutton" onclick="javascript:dlg3.dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
</div>
<script src="../resources/util.js" type="text/javascript" charset="utf-8"></script>
<script src="stand.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>
