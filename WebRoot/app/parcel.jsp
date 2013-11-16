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
        <title>土地交易案例</title>
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
            .sf { padding: 5px 5px; }
            .sf-tb td,#dlg_info td { padding: 6px 4px; }
            .easyui-validatebox,.easyui-numberbox { width: 180px; }
            #w_rs td { padding: 5px; }
            #w_rs table { width: 100%; }
            #dlg_info {background:none; border:none;}
            #dlg_info table { width: 500px; margin:auto; margin-top: 5px;}
            <%-- #dlg_info td {border-left:1px solid #95B8E7;border-bottom:1px solid #95B8E7;}--%>
            <%-- #dlg_info td:last-child {border-right:1px solid #95B8E7;}--%>
            #dlg_info td:first-child{width: 120px;}
        </style>

    </head>
    <body class="easyui-layout">
        <div data-options="region:'north',border:false" class="" style="width: 50px; ">
            <div class="ui-layout-head">
                <div class="ui-layout-nav">
                    <div class="ui-layout-nav-contain">
                        <ul class="ui-layout-nav-tab">
                            <li ><a href="parcel.jsp" class="ui-layout-nav-active">土地交易案例</a></li>
                            <li><a href="house.jsp">房产交易案例</a></li>
                            <li><a href="database.jsp">资料库</a></li>
                            <li><a href="system.jsp">系统管理</a></li>
                            <li><a href="../logout.do">退出系统</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div data-options="region:'west',split:true" title="选择地区:"
            style="width: 200px;">
            <ul class="easyui-tree"
                data-options="url:'../resources/data/city.json',method:'get',lines:true, onLoadSuccess:makeCityKeys, onClick:search_parcel"></ul>
        </div>
         <div id="main" data-options="region:'center'" style="width: 100%;">
            <div class="easyui-layout" data-options="fit:true">
                <div data-options="region:'north',split:true,border:false" title="查询条件" style="height: 190px; padding: 2px">
                    <form class="sf" method="post" id="form2">
                        <table class="sf-tb" width="100%">
                            <tr>
                                <td nowrap="nowrap">挂牌号：</td>
                                <td><input class="easyui-validatebox" type="text"
                                    name="listNo" data-options=""></input></td>
                                <td nowrap="nowrap">行政区域：</td>
                                <td>
                                    <input id="city" class="easyui-validatebox" readonly data-options="" style="width: 185px;">
                                    <input type="hidden" name="city" value="" />
                                </td>
                                <td nowrap="nowrap">土地坐落：</td>
                                <td><input class="easyui-validatebox" type="text"
                                    name="locate" data-options=""></input></td>
                                <td nowrap="nowrap">土地用途：</td>
                                <td><input id='ctree1' class="easyui-combotree" name="useNo"
                                    data-options="url:'../resources/data/land.json',method:'get', lines:true,
                                    onLoadSuccess:makeLandKeys"
                                    style="width: 230px;"></td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">土地面积：</td>
                                <td><select name="operator1" style="width: 60px;">
                                        <option value="&gt; ">&gt;</option>
                                        <option value="&lt; ">&lt;</option>
                                        <option value="=">=</option>
                                        <option value="&lt;= ">&lt;=</option>
                                        <option value="&gt;= ">&gt;=</option>
                                    </select> <input class="easyui-numberbox" type="text" name="acreage"
                                    style="width: 115px;"></input></td>
                                <td nowrap="nowrap">级别：</td>
                                <td><select class="easyui-combobox" id="level" name="level" value='1'
                                        style="width: 184px;" data-options="onLoadSuccess:makeLevelKeys">
                                        <option value="1">一级</option>
                                        <option value="2">二级</option>
                                        <option value="3">三级</option>
                                        <option value="4">四级</option>
                                        <option value="5">五级</option>
                                        <option value="6">六级</option>
                                        <option value="7">七级</option>
                                </select></td>
                                <td nowrap="nowrap">容积率：</td>
                                <td><input class="easyui-numberbox"
                                    data-options="precision:2,groupSeparator:','" type="text"
                                    name="areaRatio"></input></td>
                                <td nowrap="nowrap">成交时间：</td>
                                <td><input name="startDate" type="text"
                                    class="easyui-datebox" style="width: 100px"> 到 <input
                                    name="endDate" type="text" class="easyui-datebox"
                                    style="width: 100px"></td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">成交单价：</td>
                                <td><select name="operator2" style="width: 60px;">
                                        <option value="&gt; ">&gt;</option>
                                        <option value="&lt; ">&lt;</option>
                                        <option value="=">=</option>
                                        <option value="&lt;= ">&lt;=</option>
                                        <option value="&gt;= ">&gt;=</option>
                                    </select> <input class="easyui-numberbox"
                                    data-options="precision:2,groupSeparator:','" type="text"
                                    name="unitPrice1" style="width: 115px;"></input></td>
                                <td colspan="6"><a class="easyui-linkbutton" onclick="javascript:parcel_search(); ">查询</a>
                                    <a class="easyui-linkbutton" id="btn_view" data-mode="table" onclick="javascript:graphInfo.call(this); ">切换到地图模式</a>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div data-options="region:'center',border:false">
                    <table id="tb_rs"> </table>
                    <div class="graph" id="_graph" style="display:none; "> </div>
                </div>
            </div>
        </div>

        <div data-options="region:'south',border:false"
            style="height: 25px; background: #E0ECFF; padding: 5px;">当前登录用户：<%=username%></div>

        <div class="easyui-dialog" id="w_gp"
            data-options="iconCls:'icon-save', closed:true,modal:true, buttons:'#btns2',  inline:true,
            onOpen:show_gp"
            title="地图定位" style="width: 800px; height: 580px;">
            <div id="graph" style="width: 100%; height: 100%;"></div>
        </div>
        <div id="btns2">
            <a class="easyui-linkbutton" onclick="javascript:w_gp.dialog('close'); " data-options="iconCls:'icon-save'">确定</a>
            <a class="easyui-linkbutton" onclick="javascript:w_gp.dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
        </div>

        <div class="easyui-dialog" id="dlg"
            data-options="iconCls:'icon-save',onOpen:adjustButton,  closed:true,modal:true,buttons:'#btns_view'"
            title="查看土地案例" style="width: 540px; height: 486px;">
            <div id="dlg_info"></div>
        </div>
        <div id="w_rs" class="easyui-dialog"
            data-options="iconCls:'icon-save', closed:true, buttons:'#btns', modal:true,  inline:true,title:'新增土地案例'"
            style="width: 800px; height: 580px; padding: 10px;">
            <form id="parcel_form">
                <table cellspacing="0">
                    <tr>
                        <td>挂牌号：</td>
                        <td><input class="easyui-validatebox" type="text"
                            name="listNo" data-options=""></input> <input
                            class="easyui-validatebox" type="hidden" value="" name="landId" />
                        </td>
                        <td>成交时间：</td>
                        <td><input name="dealTime" type="text" class="easyui-datebox"
                            style=""></td>
                    </tr>
                    <tr>
                        <td>行政区域：</td>
                        <td><input class="easyui-combotree" name="city" data-options="url:'../resources/data/city.json',method:'get', lines:true" style="width: 185px;"></td>
                        <td>土地坐落：</td>
                        <td><input class="easyui-validatebox" type="text"
                            name="locate" data-options=""></input></td>
                    </tr>
                    <tr>
                        <td>级别：</td>
                        <td><select class="easyui-combobox" name="level"
                                style="width: 184px;">
                                <option value="1">一级</option>
                                <option value="2">二级</option>
                                <option value="3">三级</option>
                                <option value="4">四级</option>
                                <option value="5">五级</option>
                                <option value="6">六级</option>
                                <option value="7">七级</option>
                        </select></td>
                        <td>用途：</td>
                        <td><input class="easyui-combotree" name="useNo"
                            data-options="url:'../resources/data/land.json',method:'get',lines:true"
                            style="width: 230px;"></td>
                    </tr>
                    <tr>
                        <td>用途比例：</td>
                        <td><input class="easyui-validatebox" type="text"
                            name="useScale"></input></td>
                        <td>面积：</td>
                        <td><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="acreage"></input></td>
                    </tr>
                    <tr>
                        <td>容积率：</td>
                        <td><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="areaRatio"></input></td>
                        <td>出让年限：</td>
                        <td><input class="easyui-numberbox" data-options=""
                            type="text" name="ageLimit"></input></td>
                    </tr>
                    <tr>
                        <td>起始价：</td>
                        <td><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="startingPrice"></input> 万元</td>
                        <td>成交总价：</td>
                        <td><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="totalPrice"></input> 万元</td>
                    </tr>
                    <tr>
                        <td>成交单价：</td>
                        <td><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="unitPrice1"></input> 元/平方米</td>
                        <td>成交单价：</td>
                        <td><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="unitPrice2"></input> 万元/亩</td>
                    </tr>
                    <tr>
                        <td>楼面地价：</td>
                        <td><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="floorPrice"></input> 元/平方米</td>
                        <td>成交单位：</td>
                        <td><input class="easyui-validatebox" type="text"
                            name="dealUnit" data-options=""></input></td>
                    </tr>
                    <tr>
                        <td>竞价次数：</td>
                        <td><input type="text" data-options="groupSeparator:','"
                            class="easyui-numberbox" name="bidTimes" style="width: 184px;" />
                        </td>
                        <td>地图位置：</td>
                        <td><input class="easyui-validatebox" type="text" disabled name="lat" style="width: 90px;"></input>
                            <input class="easyui-validatebox" type="text" disabled name="lng" style="width: 90px;"></input>
                            <a href="#" id="btn_gp" class="easyui-linkbutton">地图定位</a></td>
                    </tr>
                    <tr>
                        <td>成交确认书：</td>
                        <td colspan=3><input class="easyui-validatebox" type="text"
                            disabled name="dealConfirmation" data-options=""></input> <a
                                href="#" class="easyui-linkbutton upload"
                                data-options="iconCls:'icon-save'">上传</a></td>
                    </tr>
                    <tr>
                        <td>规划设计条件书：</td>
                        <td colspan=3><input class="easyui-validatebox" type="text"
                            disabled name="designSheets" data-options=""></input> <a href="#"
                                class="easyui-linkbutton upload"
                                data-options="iconCls:'icon-save'">上传</a></td>
                    </tr>
                    <tr>
                        <td>测绘成果：</td>
                        <td colspan=3><input class="easyui-validatebox" type="text"
                            disabled name="mappingResult" data-options=""></input> <a href="#"
                                class="easyui-linkbutton upload"
                                data-options="iconCls:'icon-save'">上传</a></td>
                    </tr>
                    <tr>
                        <td>评估报告：</td>
                        <td colspan=3><input class="easyui-validatebox" type="text"
                            disabled name="assessmentReport" data-options=""></input> <a
                                href="#" class="easyui-linkbutton upload"
                                data-options="iconCls:'icon-save'">上传</a></td>
                    </tr>
                </table>
                <div id="btns">
                    <a class="easyui-linkbutton"
                        onclick="javascript:$('#parcel_form').submit(); "
                        data-options="iconCls:'icon-save'">保存</a> <a
                        class="easyui-linkbutton"
                        onclick="javascript:$('#w_rs').window('close'); "
                        data-options="iconCls:'icon-cancel'">关闭</a>
                </div>
            </form>
        </div>
        <div id="btns_view">
            <a class="easyui-linkbutton" id="view_graph" onclick="javascript:flag='view'; w_gp.window('open');  " data-options="iconCls:'icon-save'">查看地图</a>
            <a class="easyui-linkbutton" onclick="doprint('dlg'); " data-options="iconCls:'icon-save'">打印</a>
            <a class="easyui-linkbutton" onclick="javascript:$('#dlg').window('close'); "data-options="iconCls:'icon-cancel'">关闭</a>
        </div>
        <script type="text/template" id="parcel_tp">
            <table cellspacing="0" border='1' >
                <tr>
                    <td>挂牌号：</td>
                    <td><@= listNo @> </td>
                    <td>成交时间：</td>
                    <td><@= dealTime @> </td>
                </tr>
                <tr>
                    <td>行政区域：</td>
                    <td><@= cityName @> </td>
                    <td>土地坐落：</td>
                    <td><@= locate @> </td>
                </tr>
                <tr>
                    <td>级别：</td>
                    <td><@= levelName @> </td>
                    <td>用途：</td>
                    <td><@= useNoName @> </td>
                </tr>
                <tr>
                    <td>用途比例：</td>
                    <td><@= useScale @> </td>
                    <td>面积：</td>
                    <td><@= acreage @> </td>
                </tr>
                <tr>
                    <td>容积率：</td>
                    <td><@= areaRatio @> </td>
                    <td>出让年限：</td>
                    <td><@= ageLimit @> </td>
                </tr>
                <tr>
                    <td>起始价：</td>
                    <td><@= startingPrice @> </td>
                    <td>成交总价：</td>
                    <td><@= totalPrice @> </td>
                </tr>
                <tr>
                    <td>成交单价：</td>
                    <td><@= unitPrice1 @> </td>
                    <td>成交单价：</td>
                    <td><@= unitPrice2 @> </td>
                </tr>
                <tr>
                    <td>楼面地价：</td>
                    <td><@= floorPrice @> </td>
                    <td>成交单位：</td>
                    <td><@= dealUnit @> </td>
                </tr>
                <tr>
                    <td>竞价次数：</td>
                    <td><@= bidTimes @> </td>
                    <td>&nbsp; </td>
                    <td>&nbsp; </td>
                </tr>
                <tr>
                    <td>成交确认书：</td>
                    <td colspan=3>
                        <a href="../uploadfile/<@= dealConfirmation @>">
                            <@= dealConfirmation @>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td>规划设计条件书：</td>
                    <td colspan=3>
                        <a href="../uploadfile/<@= designSheets @>">
                            <@= designSheets @>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td>测绘成果:</td>
                    <td colspan=3>
                        <a href="../uploadfile/<@= mappingResult @>">
                            <@= mappingResult @>
                        </a>
                </tr>
                <tr>
                    <td>评估报告:</td>
                    <td colspan=3>
                        <a href="../uploadfile/<@= assessmentReport @>">
                            <@= assessmentReport @>
                        </a>
                    </td>
                </tr>
            </table>       
        </script>
        <script src="../resources/util.js" type="text/javascript" charset="utf-8"></script>
        <script src="parcel.js" type="text/javascript" charset="utf-8"></script>
    </body>
</html>
