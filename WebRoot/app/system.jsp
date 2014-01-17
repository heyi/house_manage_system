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
        <title>系统管理</title>
        <link rel="stylesheet" type="text/css" href="../resources/themes/default/easyui.css">
        <link rel="stylesheet" type="text/css" href="../resources/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="../resources/themes/common.css"> 
        </script> <script src="../resources/jquery.min.js"></script>
        <script type="text/javascript" src="../resources/jquery.easyui.min.js"></script>
        <script src="../resources/locale/easyui-lang-zh_CN.js" type="text/javascript" charset="utf-8"></script>
        <script src="../resources/underscore-min.js"></script>
		<script>
        var userLevel = <%=(user!=null?user.getUserRight():"0")%>
        </script>
        <style type="text/css" media="all">
        	#main .datagrid-wrap { border: 0px; }
            .easyui-validatebox,.easyui-numberbox { width: 180px; }
            .sf { padding: 10px; }
            .sf1 { padding: 10px; margin-bottom: 10px; }
            .sf1{width: 750px;}
            .sf1 td {padding: 5px 4px;}
            #dlg1 td { padding: 2px 4px; }
            .nav {width: 120px; margin:5px auto; text-align:center;}
            .nav li {padding:8px 0px; list-style-type: none;}
            .nav img {display:block;width:80px;margin:auto;}
            .nav a {color:#000;text-decoration: none; display:block;border-radius: 2px; text-align:center;width:100px;margin:5px auto;padding: 5px;border: 1px #ffffff solid;}
            .nav a:hover {color:#000;background:url(../resources/images/tab-bg.gif) repeat-x;border: 1px #8FB1DB solid; }
            .nav a.active { color:#000;background:url(../resources/images/tree-over-bg.gif) repeat-x;border: 1px #8FB1DB solid;}
            #dlg_info table { width: 98%; padding: 1%; }
            .demo-info { background: #FFFEE6; color: #8F5700; padding: 12px; }
            .demo-tip { width: 16px; height: 16px; margin-right: 8px; float: left; }
            .icon-tip { background: url('../resources/images/tip.png') no-repeat center center; }
        </style>
    </head>
    <body class="easyui-layout">
        <div data-options="region:'north',border:false" class="" style="width: 50px; ">
            <div class="ui-layout-head">
            	<div class="ui-layout-logo"></div>
                <h1>房地产信息管理系统</h1>
                <div class="ui-layout-menu">
	                <div class="ui-layout-nav">
	                    <span class="ui-layout-nav-prev"></span>
	                    <div class="ui-layout-nav-contain">
	                        <ul class="ui-layout-nav-tab">
	                            <li class="ui-layout-nav-frist">
									<a href="index.jsp">首页</a>
								</li>
	                            <li ><a href="parcel.jsp" >土地交易案例</a></li>
	                            <li><a href="house.jsp">房产交易案例</a></li>
	                            <li><a href="law2.jsp">政策法规</a></li>
	                            <li><a href="market2.jsp">市场分析</a></li>
	                            <li><a href="stand2.jsp">标准化模板</a></li>
	                            <li><a href="javascript:alert('正在建设中')">统计分析</a></li>
	                            <li><a href="system.jsp" class="ui-layout-nav-active">系统管理</a></li>
	                            <li class="ui-layout-nav-last">
									<a href="../logout.do">退出系统</a>
							    </li>
	                        </ul>
	                    </div>
	                    <span class="ui-layout-nav-next"></span>
	                </div>
	             </div>
            </div>
        </div>

        <div data-options="region:'west',split:true" title="系统配置"
            style="width: 180px;">
            <ul class='nav'>
                <li>
                    <a href="javascript:void(0)" data-key="1" >
                        <img src="../resources/images/user.png" alt="shop" border="0"/>
                        用户管理
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-key="2">
                        <img src="../resources/images/module.png" alt="shop" border="0"/>
                        板块维护
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-key="3">
                        <img src="../resources/images/floor.png" alt="shop" border="0"/>
                        楼盘字典</a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-key="4">
                        <img src="../resources/images/personal.png" alt="shop" border="0"/>
                        个人信息</a>
                </li>
            </ul>
        </div>
        <div id="main" data-options="region:'center'" style="width: 100%; position:relative;">
            <div id="tab1" class="easyui-tabs" data-options="fit:true,border:false,onSelect:tab_select">
                <div title="用户管理" style="padding:2%;">
                    <div class="easyui-layout" data-options="fit:true">
                        <div data-options="region:'north',border:true" style="height:55px;padding: 2px;margin-bottom:10px;border-bottom:none;overflow: hidden;">
                            <form class="sf" id="sform1" method="post" method="post">
                                关键字筛选:
                                <input class="easyui-validatebox" name="keywords" data-options="" placeholder="可输入用户名或姓名进行筛选"></input> 
                                <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" >查询</a>
                            </form>
                        </div>
                        <div data-options="region:'center',border:true" style="position:relative; ">
                            <table cellspacing="0" id="table1"></table>
                        </div>
                    </div>
                </div>
                <div title="板块维护" data-options="" style="overflow:hidden; padding:2%;">
                    <div class="easyui-layout" data-options="fit:true">
                        <div data-options="region:'north',border:true" style="height:55px;padding: 2px;margin-bottom:10px;border-bottom:none;overflow: hidden;">
                           <form class="sf" id="sform2" method="post">
                                关键字筛选:
                                <input class="easyui-validatebox" name="sectorName" data-options="" placeholder="输入板块名称"></input> 
                                <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" >查询</a>
                            </form>
                        </div>
                        <div data-options="region:'center',border:true" style="position:relative; ">
                            <table cellspacing="0" id="table2"></table>
                        </div>
                    </div>
                </div>
                <div title="楼盘字典" data-options="" style="overflow:hidden;padding:2%;border-sizeing:border-box;">
                    <div class="easyui-layout" data-options="fit:true">
                        <div data-options="region:'west'" style="width: 200px;border-right:none;">
                            <ul class="easyui-tree" data-options="url:'getCityList.do',method:'get',lines:true,title:'板块列表',onClick:search_sector"></ul>
                        </div>
                        <div data-options="region:'center',border:true,border:false" style="position:relative; ">
                            <div class="easyui-layout" data-options="fit:true">
                                <div data-options="region:'north',border:true" style="height:55px;padding: 2px;margin-bottom:10px;border-bottom:none;overflow: hidden;">
                                    <form class="sf" id="sform3" method="post" style="border:none;">
                                        关键字筛选:
                                        <input class="easyui-validatebox" name="buildingsName" data-options="" placeholder="输入楼盘名称"></input> 
                                        <input type="hidden" name="cityNo" id="cityNo" value="" />
                                        <a class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                                    </form>
                                </div>
                                <div data-options="region:'center',border:true" style="position:relative;">
                                    <table cellspacing="0" id="table3"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="个人信息" data-options="" style="overflow:hidden;padding:2%;border-sizeing:border-box;">
                    <form class="sf1" id="form4"  method="post">
                    <fieldset style="border:1px solid #95B8E7; padding:5px;">
                    <legend>个人信息</legend>
                        <table border="0" cellspacing="0" cellpadding="0" class="ui-form-table" width="100%" style="margin-bottom:20px;">
                            <tr>
                                <td class="ui-form-table-dt">用户名：</td>
                                <td class="ui-form-table-dd"><input class="easyui-validatebox" id="username" disabled name="username" data-options=""></input>
                                    <input type="hidden" name="userId" value="" />
                                </td>
                                <td class="ui-form-table-dd" rowspan=3 colspan=2 style="text-align:center;">
                                    <img id="img_photo" src="" alt="" style="width:80px;height:70px;"/>
                                    <div>
                                        <input id="photo" type="hidden" name="photo" value="" />
                                        <a class="easyui-linkbutton" onclick="javascript:uploadfile();" data-options="iconCls:'icon-upload'" >上传照片</a>
                                    </div>
                                </td>
                            </tr>
                            <tr >
                                <td class="ui-form-table-dt">姓名：</td>
                                <td class="ui-form-table-dd"> <input class="easyui-validatebox" name="trueName" data-options=""></input> </td>
                            </tr>
                            <tr>
                                <td class="ui-form-table-dt">身份证号：</td>
                                <td class="ui-form-table-dd"><input class="easyui-numberbox" name="idcard" data-options=""></input> </td>
                            </tr>
                            <tr >
                                <td class="ui-form-table-dt">手机：</td>
                                <td class="ui-form-table-dd"> <input class="easyui-numberbox" name="mobile" data-options=""></input> </td>
                                <td class="ui-form-table-dt">角色：</td>
                                <td class="ui-form-table-dd">
                                    <select class="easyui-combobox" disabled name="userRight" style="width: 184px;" >
                                        <option value="1">系统管理员</option>
                                        <option value="2">信息录入员</option>
                                        <option value="3">普通用户</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="ui-form-table-dt">住址：</td>
                                <td class="ui-form-table-dd"> <input class="easyui-validatebox" name="address" data-options=""></input> </td>
                                <td class="ui-form-table-dt">QQ：</td>
                                <td class="ui-form-table-dd"> <input class="easyui-numberbox" name="qq" data-options=""></input> </td>
                            </tr>
                            <tr>
                                <td class="ui-form-table-dt">部门：</td>
                                <td class="ui-form-table-dd"> <input class="easyui-validatebox" name="dept" data-options=""></input> </td>
                                <td class="ui-form-table-dt">头衔：</td>
                                <td class="ui-form-table-dd"><input class="easyui-validatebox" name="rank" data-options=""></input></td>
                            </tr>
                            <tr>
                                <td class="ui-form-table-dd" colspan="4" align="right">
			                        <a class="easyui-linkbutton" onclick="javascript:dlg4.dialog('open');" data-options="iconCls:'icon-edit'">修改密码</a>
			                        <a class="easyui-linkbutton" onclick="javascript:form4.submit();" data-options="iconCls:'icon-save'">保存</a>
                                </td>
                            </tr>
                        </table>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>


        <div id="dlg1" class="easyui-dialog" data-options="iconCls:'icon-save', closed:true, buttons:'#btns1', modal:true,  inline:true,title:'用户管理'" style="width: 400px; height: 300px; padding: 10px;">
            <form id="form1">
                <table border="0" cellspacing="0" cellpadding="0" class="ui-form-table" width="100%">
                    <tr>
                        <td class="ui-form-table-dt">用户名：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" id="username1" name="username" data-options="" required="true" ></input>
                            <input type="hidden" name="userId" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">姓名：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" name="trueName" data-options="" required="true"></input> </td>
                    </tr>
                    <tr >
                        <td class="ui-form-table-dt">头衔：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" name="rank" data-options=""></input> </td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">手机：</td>
                        <td class="ui-form-table-dd"><input class="easyui-numberbox" name="mobile" data-options=""></input> </td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">QQ：</td>
                        <td class="ui-form-table-dd"><input class="easyui-numberbox" name="qq" data-options=""></input> </td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">角色：</td>
                        <td class="ui-form-table-dd">
                            <select class="easyui-combobox"  name="userRight"
                                style="width: 184px;" required="true">
                                <option value="1">系统管理员</option>
                                <option value="2">信息录入员</option>
                                <option value="3">普通用户</option>
                            </select>
                        </td>
                    </tr>
                </table>
                <div id="btns1">
                    <a class="easyui-linkbutton" onclick="javascript:$('#form1').submit(); " data-options="iconCls:'icon-save'">保存</a>
                    <a class="easyui-linkbutton" onclick="javascript:$('#dlg1').dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
                </div>
            </form>
        </div>

        <div id="dlg4" class="easyui-dialog" data-options="iconCls:'icon-save', closed:true, buttons:'#btns5', modal:true,  inline:true,title:'修改密码'" style="width: 400px; height: 300px; padding: 10px;">
            <form id="form5">
                <table border="0" cellspacing="0" cellpadding="0" class="ui-form-table" width="100%">
                    <tr>
                        <td class="ui-form-table-dt">旧密码：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="password" name="oldPassword" data-options="required:true"></input> 
                            <input type="hidden" name="userId" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">新密码：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="password" name="newPassword" data-options="required:true"></input> </td>
                    </tr>

                    <tr>
                        <td class="ui-form-table-dt">确认新密码：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="password" name="confirmPassword" data-options="required:true"></input> </td>
                    </tr>
                </table>
                <div class="demo-info">
                    <div class="demo-tip icon-tip"></div>
                    <div>
                        密码建议：为了安全，请输入6位以上包含数字(0-9),
                        大小写字符(A-Z,a-z)和特殊字符(例如*^%$)密码
                    </div>
                </div>
                <div id="btns5">
                    <a class="easyui-linkbutton" onclick="javascript:$('#form5').submit(); " data-options="iconCls:'icon-save'">保存</a>
                    <a class="easyui-linkbutton" onclick="javascript:$('#dlg4').dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
                </div>
            </form>
        </div>

        <div id="dlg2" class="easyui-dialog" data-options="iconCls:'icon-save', closed:true, buttons:'#btns2', modal:true,  inline:true,title:'板块管理'" style="width: 400px; height: 300px; padding: 10px;">
            <form id="form2">
                <table border="0" cellspacing="0" cellpadding="0" class="ui-form-table" width="100%">
                    <tr>
                        <td class="ui-form-table-dt">所属区县：</td>
                        <td class="ui-form-table-dd">
                            <input class="easyui-combotree" name="cityNo" data-options="url:'getCityList.do',method:'get', lines:true" style="width: 185px;" required="true">
                            <input type="hidden" name="sectorId" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">板块：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" name="sectorName" data-options="" required="true"></input> </td>
                    </tr>
                </table>
                <div id="btns2">
                    <a class="easyui-linkbutton" onclick="javascript:$('#form2').submit(); " data-options="iconCls:'icon-save'">保存</a>
                    <a class="easyui-linkbutton" onclick="javascript:$('#dlg2').dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
                </div>
            </form>
        </div>
        <div id="dlg3" class="easyui-dialog" data-options="iconCls:'icon-save', closed:true, buttons:'#btns3', modal:true,  inline:true,title:'楼盘管理'" style="width: 400px; height: 300px; padding: 10px;">
            <form id="form3">
                <table border="0" cellspacing="0" cellpadding="0" class="ui-form-table" width="100%">
                    <tr>
                        <td class="ui-form-table-dt">目标区县：</td>
                        <td class="ui-form-table-dd">
                            <input class="easyui-combotree" name="cityNo" required="true" data-options="url:'getCityList.do',method:'get',onChange:search_sectorid, lines:true" style="width: 185px;">
                            <input type="hidden" name="buildingsId" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">目标板块：</td>
                        <td class="ui-form-table-dd"> <select class="easyui-combobox" id="sectorId" required="true" data-options="textField:'sectorName',valueField:'sectorId'" name="sectorId" style="width: 184px;" ></select> </td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">小区名称：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" name="buildingsName" data-options="" required="true"></input> </td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">小区地址：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" name="buildingsAddress" data-options="" required="true"></input> </td>
                    </tr>
                </table>
                <div id="btns3">
                    <a class="easyui-linkbutton" onclick="javascript:$('#form3').submit(); " data-options="iconCls:'icon-save'">保存</a>
                    <a class="easyui-linkbutton" onclick="javascript:$('#dlg3').dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
                </div>
            </form>
        </div>
        <script src="../resources/util.js" type="text/javascript" charset="utf-8"></script>
        <script src="system.js" type="text/javascript" charset="utf-8"></script>
    </body>
</html>
