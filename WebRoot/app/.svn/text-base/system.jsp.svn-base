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
        <script src="http://api.map.baidu.com/api?v=1.5&ak=C0e1334aab91d623969240a6e098acb7&sk=7c93af0bd6efdc6610cc6026153a92c9" type="text/javascript" charset="utf-8"> 
        </script> <script src="../resources/jquery.min.js"></script>
        <script type="text/javascript" src="../resources/jquery.easyui.min.js"></script>
        <script src="../resources/locale/easyui-lang-zh_CN.js" type="text/javascript" charset="utf-8"></script>
        <script src="../resources/underscore-min.js"></script>

        <style type="text/css" media="all">
        	#main .datagrid-wrap { border: 0px; }
            .easyui-validatebox,.easyui-numberbox { width: 180px; }
            .sf,.sf1 { padding: 10px; border: 1px solid #95B8E7; margin-bottom: 10px; }
            .sf1{width: 600px;}
            .sf1 td {padding: 5px 4px;}
            #dlg1 td { padding: 2px 4px; }
            .nav {width: 90px; margin:auto; text-align:center;}
            .nav li {padding:15px 0px; list-style-type: none;}
            .nav a {text-decoration: none; padding:5px 0px; display:block;border-radius: 10px; background:#eee;}
            .nav a:hover, .nav a.active { color: #fff; background-color: #0E2D5F; }
            #dlg_info table { width: 98%; padding: 1%; }
            .demo-info { background: #FFFEE6; color: #8F5700; padding: 12px; }
            .demo-tip { width: 16px; height: 16px; margin-right: 8px; float: left; }
            .icon-tip { background: url('../resources/images/tip.png') no-repeat center center; }
        </style>
    </head>
    <body class="easyui-layout">
        <div data-options="region:'north',border:false" class="" style="width: 50px; ">
            <div class="ui-layout-head">
                <div class="ui-layout-nav">
                    <div class="ui-layout-nav-contain">
                        <ul class="ui-layout-nav-tab">
                            <li ><a href="parcel.jsp" >土地交易案例</a></li>
                            <li><a href="house.jsp">房产交易案例</a></li>
                            <li><a href="database.jsp">资料库</a></li>
                            <li class="ui-layout-nav-last ui-layout-nav-active"><a href="system.jsp">系统管理</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div data-options="region:'west',split:true" title="案例类型"
            style="width: 200px;">
            <ul class='nav'>
                <li>
                    <a href="javascript:void(0)" data-key="1" >用户管理</a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-key="2">
                        模块维护
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-key="3">楼盘字典</a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-key="4">个人信息</a>
                </li>
            </ul>
        </div>
        <div id="main" data-options="region:'center'" style="width: 100%; position:relative;">
            <div id="tab1" class="easyui-tabs" data-options="fit:true,border:false,onSelect:tab_select">
                <div title="用户管理" style="padding:2%;">
                    <form class="sf" id="sform1" method="post" method="post">
                        关键筛选:
                        <input class="easyui-validatebox" name="username" data-options="" placeholder="可输入用户名或姓名进行筛选"></input> 
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" >查询</a>
                    </form>
                    <div style="position:absolute;bottom:0px; top:90px; left:0px;  right:0px; padding:2%;     ">
                        <table cellspacing="0" id="table1"></table>
                    </div>
                </div>
                <div title="模块维护" data-options="" style="overflow:hidden; padding:2%;">
                    <form class="sf" id="sform2" method="post">
                        关键筛选:
                        <input class="easyui-validatebox" name="sectorName" data-options="" placeholder="输入板块名称"></input> 
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" >查询</a>
                    </form>
                    <div style="position:absolute;bottom:0px; top:90px; left:0px;  right:0px; padding: 2%;     ">
                        <table cellspacing="0" id="table2"></table>
                    </div>
                </div>
                <div title="楼盘字典" data-options="" style="overflow:hidden;padding:2%;border-sizeing:border-box;">
                    <div style="width:22%; float:left;">
                        <ul class="easyui-tree" data-options="url:'../resources/data/city.json',method:'get',lines:true,title:'板块列表',onClick:search_sector"></ul>
                    </div>
                    <div style="width:76%; position:relative; display:inline-block;height:450px;border: 1px solid #95B8E7; "> 
                        <form class="sf" id="sform3" method="post" style="border:none;border-bottom: 1px solid #95B8E7;">
                            关键筛选:
                            <input class="easyui-validatebox" name="" data-options="" placeholder="输入板块名称"></input> 
                            <input type="hidden" name="cityNo" id="cityNo" value="" />
                            <a class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                        </form>
                        <div style="position:absolute;bottom:0px; top:70px; left:0px;  right:0px;">
                            <table cellspacing="0" id="table3"></table>
                        </div>
                    </div>
                </div>
                <div title="个人信息" data-options="" style="overflow:hidden;padding:2%;border-sizeing:border-box;">
                    <form class="sf1" id="form4"  method="post">
                        <table cellspacing="0" width="100%" style="margin-bottom:20px;">
                            <tr>
                                <td>用户名：</td>
                                <td><input class="easyui-validatebox" id="username" disabled name="username" data-options=""></input>
                                    <input type="hidden" name="userId" value="" />
                                </td>
                                <td>角色：</td>
                                <td>
                                    <select class="easyui-combobox" disabled name="userRight" style="width: 184px;" >
                                        <option value="1">系统管理员</option>
                                        <option value="2">信息录入员</option>
                                        <option value="3">普通用户</option>
                                    </select>
                                </td>
                            </tr>
                            <tr >
                                <td>姓名：</td>
                                <td> <input class="easyui-validatebox" name="trueName" data-options=""></input> </td>
                                <td rowspan=3 colspan=2 style="text-align:center;">
                                    <img id="img_photo" src="" alt="" style="width:80px;height:70px;"/>
                                    <div>
                                        <input id="photo" type="hidden" name="photo" value="" />
                                        <a class="easyui-linkbutton" onclick="javascript:uploadfile();" data-options="iconCls:'icon-save'" >上传照片</a>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>身份证号：</td>
                                <td><input class="easyui-numberbox" name="idcard" data-options=""></input> </td>
                            </tr>
                            <tr >
                                <td>手机：</td>
                                <td> <input class="easyui-numberbox" name="mobile" data-options=""></input> </td>
                            </tr>
                            <tr>
                                <td>住址:</td>
                                <td> <input class="easyui-validatebox" name="address" data-options=""></input> </td>
                                <td>QQ:</td>
                                <td> <input class="easyui-numberbox" name="qq" data-options=""></input> </td>
                            </tr>
                            <tr>
                                <td>部门:</td>
                                <td> <input class="easyui-validatebox" name="dept" data-options=""></input> </td>
                                <td>头衔:</td>
                                <td><input class="easyui-validatebox" name="rank" data-options=""></input></td>
                            </tr>
                        </table>
                        <a class="easyui-linkbutton" onclick="javascript:dlg4.dialog('open');" data-options="iconCls:'icon-remove'">修改密码</a>
                        <a class="easyui-linkbutton" onclick="javascript:form4.submit();" data-options="iconCls:'icon-save'">保存</a>
                    </form>
                </div>
            </div>
        </div>
        <div data-options="region:'south',border:false" style="height: 25px; background: #E0ECFF; padding: 5px;">当前登录用户：<%=username%></div>
        

        <div id="dlg1" class="easyui-dialog" data-options="iconCls:'icon-save', closed:true, buttons:'#btns1', modal:true,  inline:true,title:'用户管理'" style="width: 600px; height: 300px; padding: 10px;">
            <form id="form1">
                <table cellspacing="0" width="100%">
                    <tr>
                        <td>用户名：</td>
                        <td><input class="easyui-validatebox" id="username" name="username" data-options=""></input>
                            <input type="hidden" name="userId" value="" />
                        </td>
                        <td>姓名：</td>
                        <td><input class="easyui-validatebox" name="trueName" data-options=""></input> </td>
                    </tr>
                    <tr >
                        <td>头衔：</td>
                        <td><input class="easyui-validatebox" name="rank" data-options=""></input> </td>
                        <td>手机：</td>
                        <td><input class="easyui-numberbox" name="mobile" data-options=""></input> </td>
                    </tr>
                    <tr>
                        <td>QQ：</td>
                        <td><input class="easyui-numberbox" name="qq" data-options=""></input> </td>
                        <td>角色：</td>
                        <td>
                            <select class="easyui-combobox"  name="userRight"
                                style="width: 184px;" >
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
                <table cellspacing="0" width="100%">
                    <tr>
                        <td>旧密码：</td>
                        <td><input class="easyui-validatebox" type="password" name="oldPassword" data-options=""></input> 
                            <input type="hidden" name="userId" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>新密码:</td>
                        <td><input class="easyui-validatebox" type="password" name="newPassword" data-options=""></input> </td>
                    </tr>

                    <tr>
                        <td>确认新密码:</td>
                        <td><input class="easyui-validatebox" type="password" name="confirmPassword" data-options=""></input> </td>
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
                <table cellspacing="0" width="100%">
                    <tr>
                        <td>所属区县：</td>
                        <td>
                            <input class="easyui-combotree" name="cityNo" data-options="url:'../resources/data/city.json',method:'get', lines:true" style="width: 185px;">
                            <input type="hidden" name="sectorId" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>板块:</td>
                        <td><input class="easyui-validatebox" name="sectorName" data-options=""></input> </td>
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
                <table cellspacing="0" width="100%">
                    <tr>
                        <td>目标区县：</td>
                        <td>
                            <input class="easyui-combotree" name="cityNo" data-options="url:'../resources/data/city.json',method:'get',onChange:search_sectorid, lines:true" style="width: 185px;">
                            <input type="hidden" name="buildingsId" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>目标板块:</td>
                        <td> <select class="easyui-combobox" id="sectorId" name="sectorId" style="width: 184px;" ></select> </td>
                    </tr>
                    <tr>
                        <td>小区名称:</td>
                        <td><input class="easyui-validatebox" name="sectorName" data-options=""></input> </td>
                    </tr>
                    <tr>
                        <td>小区地址:</td>
                        <td><input class="easyui-validatebox" name="buildingsName" data-options=""></input> </td>
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
