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
        <title>房产交易案例</title>
        <link rel="stylesheet" type="text/css" href="../resources/themes/default/easyui.css">
        <link rel="stylesheet" type="text/css" href="../resources/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="../resources/themes/common.css">
        </script> <script src="../resources/jquery.min.js"></script>
        <script type="text/javascript" src="../resources/jquery.easyui.min.js"></script>
        <script src="../resources/locale/easyui-lang-zh_CN.js" type="text/javascript" charset="utf-8"></script>
        <script src="../resources/underscore-min.js"></script>
        <script src="../resources/ckeditor/ckeditor.js"></script>

        <style type="text/css" media="all">
        	#main .datagrid-wrap { border: 0px; }
            .easyui-validatebox,.easyui-numberbox { width: 180px; }
            .sf { padding: 5px 5px; }
            .sf-tb td,#dlg_info td  { padding: 6px 4px; }
            #dlg1 td { padding: 2px 4px; }
            .nav {width: 90px; margin:auto; text-align:center;}
            .nav li {padding:15px 0px; list-style-type: none;}
            .nav a {text-decoration: none; padding:5px 0px; display:block;border-radius: 10px; background:#eee;}
            .nav a:hover, .nav a.active { color: #fff; background-color: #0E2D5F; }
            #dlg_info table { width: 98%; padding: 1%; }
        </style>
    </head>
    <body class="easyui-layout">
        <div data-options="region:'north',border:false" class="" style="width: 50px; ">
            <div class="ui-layout-head">
                <div class="ui-layout-nav">
                    <div class="ui-layout-nav-contain">
                        <ul class="ui-layout-nav-tab">
                            <li ><a href="parcel.jsp" >土地交易案例</a></li>
                            <li><a href="house.jsp" >房产交易案例</a></li>
                            <li><a href="database.jsp" class="ui-layout-nav-active">资料库</a></li>
                            <li class="ui-layout-nav-last"><a href="system.jsp">系统管理</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div data-options="region:'west',split:true" title="资料库"
            style="width: 200px;">
            <ul class='nav'>
                <li>
                    <a href="javascript:void(0)" data-index="0">政策法规</a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-index="1" > 市场分析 </a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-index="2" >标准化模板</a>
                </li>
            </ul>
        </div>
        <div id="main" data-options="region:'center'" style="width: 100%;">
            <div class="easyui-layout" data-options="fit:true">
                <div data-options="region:'north',split:true,border:false" title="查询条件" style="height: 110px; padding: 2px">
                    <form class="sf" method="post" id="form2">
                        <table class="sf-tb" width="100%">
                            <tr>
                                <td nowrap="nowrap">标题：</td>
                                <td><input class="easyui-validatebox" name="infoTitle" data-options=""></input> </td>

                                <td nowrap="nowrap">所属分类：</td>
                                <td> <input class="easyui-combotree" name="catagoryId" id="tree2" data-options="lines:true" style="width: 200px;">
                                <td colspan="2"><a class="easyui-linkbutton" onclick="javascript:search_database(); ">查询</a></td>
                        </table>
                    </form>
                </div>
                <div data-options="region:'center',border:false">
                    <table id="table1"> </table>
                </div>
            </div>
        </div>

        <div data-options="region:'south',border:false"
            style="height: 25px; background: #E0ECFF; padding: 5px;">当前登录用户：<%=username%></div>

        <div class="easyui-dialog" id="dlg3"
            data-options="iconCls:'icon-save', closed:true,modal:true,buttons:'#btns_view', inline:true"
            title="查看资料" style="width: 500px; height: 400px;;">
            <div id="dlg_info" style="width: 100%%; padding:5%;text-align:center; box-sizing:border-box; ">
            </div>
        </div>

        <div id="dlg1" class="easyui-dialog" data-options="iconCls:'icon-save', closed:true, buttons:'#btns', modal:true,  inline:true,title:'添加资料'"
            style="width: 800px; height: 550px; padding: 10px;">
            <form id="form1">
                <table cellspacing="0" width="100%">
                    <tr>
                        <td>标题：</td>
                        <td><input class="easyui-validatebox" name="infoTitle" data-options=""></input>
                            <input type="hidden" name="infoId" value="" />
                        </td>
                        <td>所属分类：</td>
                        <td> <input class="easyui-combotree" id="tree1" name="catagoryId" data-options="lines:true" style="width: 200px;">
                    </tr>
                    <tr rowspan=3 >
                        <td>内容：</td>
                        <td colspan=3>
                            <textarea id="ckeditor" name="content"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>附件：</td>
                        <td colspan=3><input class="easyui-validatebox" type="text" disabled name="attachment" data-options=""></input>
                            <a href="#" class="easyui-linkbutton upload" data-options="iconCls:'icon-save'">上传</a></td>
                    </tr>
                </table>
                <div id="btns">
                    <a class="easyui-linkbutton" onclick="javascript:$('#form1').submit(); " data-options="iconCls:'icon-save'">保存</a>
                    <a class="easyui-linkbutton" onclick="javascript:$('#dlg1').dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
                </div>
            </form>
        </div>
        <script type="text/template" id="tp1">
            <h4 ><@= infoTitle @> </h4>
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
            <a class="easyui-linkbutton" onclick="javascript:flag='view'; dlg2.dialog('open');  " data-options="iconCls:'icon-save'">查看地图</a>
            <a class="easyui-linkbutton" onclick="doprint('dlg3'); " data-options="iconCls:'icon-save'">打印</a>
            <a class="easyui-linkbutton" onclick="javascript:dlg3.dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
        </div>
        <script src="../resources/util.js" type="text/javascript" charset="utf-8"></script>
        <script src="database.js" type="text/javascript" charset="utf-8"></script>
    </body>
</html>
