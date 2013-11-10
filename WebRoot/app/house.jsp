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
        <script src="http://api.map.baidu.com/api?v=1.5&ak=C0e1334aab91d623969240a6e098acb7&sk=7c93af0bd6efdc6610cc6026153a92c9" type="text/javascript" charset="utf-8"> 
        </script> <script src="../resources/jquery.min.js"></script>
        <script type="text/javascript" src="../resources/jquery.easyui.min.js"></script>
        <script src="../resources/locale/easyui-lang-zh_CN.js" type="text/javascript" charset="utf-8"></script>
        <script src="../resources/underscore-min.js"></script>

        <style type="text/css" media="all">
        	#main .datagrid-wrap { border: 0px; }
            .easyui-validatebox,.easyui-numberbox { width: 180px; }
            .sf { padding: 5px 5px; }
            .sf-tb td,#dlg_info td  { padding: 6px 4px; }
            #dlg1 td { padding: 2px 4px; }
            #dlg1 .easyui-validatebox,#dlg1 .easyui-numberbox { width: 145px; }
            #fs_container input[type='checkbox'] { margin:5px 4px 5px 5px; }
            .nav {width: 90px; margin:auto; text-align:center;}
            .nav img {display:block;width:50px;margin:auto;}
            .nav li {padding:15px 0px; list-style-type: none;}
            .nav a {text-decoration: none; padding:5px 0px; display:block;border-radius: 10px; background:#eee; text-align:center;}
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
                            <li><a href="house.jsp" class="ui-layout-nav-active">房产交易案例</a></li>
                            <li><a href="database.jsp">资料库</a></li>
                            <li class="ui-layout-nav-last"><a href="system.jsp">系统管理</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div data-options="region:'west',split:true" title="案例类型"
            style="width: 200px;">
            <ul class='nav'>
                <li>
                    <a href="javascript:void(0)" class="active" data-houseType="1" data-dealType="1">
                        <img src="../resources/images/shop.png" alt="shop" />
                        商铺交易案例
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-houseType="1" data-dealType="2">
                        <img src="../resources/images/shop.png" alt="shop" /> 商铺租凭案例</a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-houseType="2" data-dealType="1">
                        <img src="../resources/images/house.png" alt="shop" />
                        住宅交易案例
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-houseType="2" data-dealType="2">
                        <img src="../resources/images/house.png" alt="shop" />
                        住宅租赁案例</a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-houseType="3" data-dealType="1">
                        <img src="../resources/images/office.png" alt="shop" />
                        办公交易案例</a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-houseType="3" data-dealType="2">
                        <img src="../resources/images/office.png" alt="shop" />
                        办公租赁案例</a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-houseType="4" data-dealType="1">
                        <img src="../resources/images/factory.png" alt="shop" />
                        工业交易案例</a>
                </li>
                <li>
                    <a href="javascript:void(0)" data-houseType="4" data-dealType="2">
                        <img src="../resources/images/factory.png" alt="shop" />
                        工业租赁案例</a>
                </li>
            </ul>
        </div>
        <div id="main" data-options="region:'center'" style="width: 100%;">
            <div class="easyui-layout" data-options="fit:true">
                <div data-options="region:'north',split:true,border:false" title="查询条件" style="height: 190px; padding: 2px">
                    <form class="sf" method="post" id="form2">
                        <table class="sf-tb" width="100%">
                            <tr>
                                <td nowrap="nowrap">行政区域：</td>
                                <td> <input class="easyui-combotree" name="cityNo" data-options="url:'../resources/data/city.json',onLoadSuccess:makeCityKeys,method:'get', lines:true" style="width: 186px;">
                                <input type="hidden" name="houseType" value="" />
                                <input type="hidden" name="dealType" value="" />
                                </td>
                                <td nowrap="nowrap">房屋位置：</td>
                                <td><input class="easyui-validatebox" name="locate" data-options=""></input></td>
                                <td nowrap="nowrap">房屋结构：</td>
                                <td>
                                    <select class="easyui-combobox"  name="structure"
                                        style="width: 184px;" data-options="">
                                        <option value="1">其它</option>
                                        <option value="2">框架</option>
                                        <option value="3">剪力</option>
                                        <option value="4">钢混</option>
                                        <option value="5">木混</option>
                                        <option value="6">砖木</option>
                                    </select>
                                </td>
                                <td nowrap="nowrap">建筑面积：</td>
                                <td>
                                    <select name="operator1" style="width: 60px;">
                                        <option value="&gt; ">&gt;</option>
                                        <option value="&lt; ">&lt;</option>
                                        <option value="=">=</option>
                                        <option value="&lt;= ">&lt;=</option>
                                        <option value="&gt;= ">&gt;=</option>
                                    </select>
                                    <input class="easyui-numberbox" type="text" name="constructionArea" style="width: 115px;" data-options="precision:2,groupSeparator:','">
                                    </input>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">建筑年代：</td>
                                <td>
                                    <select class="easyui-combobox" name="buildingDate" style="width: 184px;" data-options="valueField:'id',textField:'text', url:'../resources/data/year.json'">
                                    </select>
                                </td>

                                <td nowrap="nowrap">成交单价：</td>
                                <td><select name="operator2" style="width: 60px;">
                                        <option value="&gt; ">&gt;</option>
                                        <option value="&lt; ">&lt;</option>
                                        <option value="=">=</option>
                                        <option value="&lt;= ">&lt;=</option>
                                        <option value="&gt;= ">&gt;=</option>
                                    </select> <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="unitPrice" style="width: 115px;"></input></td>
                                <td nowrap="nowrap">土地使用权类型：</td>
                                <td>
                                    <select class="easyui-combobox"  name="landUseRight"
                                        style="width: 184px;" data-options="">
                                        <option value="1">出让</option>
                                    </select>
                                </td>
                                <td nowrap="nowrap">成交时间：</td>
                                <td><input name="startDate" type="text"
                                    class="easyui-datebox" style="width: 100px"> 到 <input
                                    name="endDate" type="text" class="easyui-datebox"
                                    style="width: 100px"></td>
                            </tr>
                            <tr>
                                <td colspan="8">
                                    <a class="easyui-linkbutton" onclick="javascript:search_house(); ">查询</a>
                                    <a class="easyui-linkbutton" data-mode="table" onclick="javascript:graphInfo.call(this); ">切换到地图模式</a>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div data-options="region:'center',border:false" style="position:relative; ">
                    <table id="table1"> </table>
                    <div class="graph" id="_graph" style="display:none; "> </div>
                </div>
            </div>
        </div>

        <div data-options="region:'south',border:false"
            style="height: 25px; background: #E0ECFF; padding: 5px;">当前登录用户：<%=username%></div>

        <div class="easyui-dialog" id="dlg2"
            data-options="iconCls:'icon-save', buttons:'#btns2', closed:true,modal:true,  inline:true,onOpen:show_gp "
            title="地图定位" style="width: 850px; height: 660px;">
            <div id="graph" style="width: 100%; height: 100%;"></div>
        </div>

        <div class="easyui-dialog" id="dlg3"
            data-options="iconCls:'icon-save', onOpen:adjustButton,  closed:true,modal:true,buttons:'#btns_view', inline:true"
            title="查看房产案例" style="width: 800px; height: 600px;;">
            <div id="dlg_info" style="width: 98%; padding:1%; "></div>
        </div>
        <div id="btns2">
            <a class="easyui-linkbutton" onclick="javascript:$('#dlg2').dialog('close'); " data-options="iconCls:'icon-save'">确定</a>
            <a class="easyui-linkbutton" onclick="javascript:$('#dlg2').dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
        </div>

        <div id="dlg1" class="easyui-dialog" data-options="iconCls:'icon-save', closed:true, buttons:'#btns', modal:true,  inline:true,title:'新增房产案例'"
            style="width: 850px; height: 660px; padding: 10px;">
            <form id="form1">
                <fieldset style="border:1px solid #95B8E7; padding:5px;">
                    <legend>基本信息</legend>
                    <table cellspacing="0">
                        <tr>
                            <td>区县：</td>
                            <td>
                                <input class="easyui-combotree" name="cityNo" data-options="url:'../resources/data/city.json',method:'get', lines:true,onChange:show_buildings" style="width: 149px;"> 
                            </td>
                            <td>小区楼盘：</td>
                            <td>
                                <select class="easyui-combobox" id="s_building" name="houseName"
                                    style="width: 149px;" data-options=""></select>
                            </td>
                            <td>栋号及房号：</td>
                            <td>
                                <input class="easyui-validatebox" type="text" name="houseNo" data-options=""></input>
                            </td>
                        </tr>
                        <tr>
                            <td>楼层：</td>
                            <td>
                                <input name="floor" class="easyui-numberspinner" style="width:149px;" data-options="min:2,max:200">
                            </td>
                            <td>总楼层：</td>
                            <td>
                                <input name="totalFloor" class="easyui-numberspinner" style="width:149px;" data-options="min:2,max:200">
                            </td>
                            <td>层高：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="floorHeight"> m</input>
                            </td>
                        </tr>
                        <tr>
                            <td>房屋位置：</td>
                            <td>
                                <input class="easyui-validatebox" type="text" name="locate"></input>
                            </td>
                            <td>建筑年代：</td>
                            <td>
                                <select class="easyui-combobox" name="buildingDate" style="width: 149px;" data-options="valueField:'id',textField:'text', url:'../resources/data/year.json'">
                                </select>
                            </td>
                            <td>建筑面积：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="constructionArea"> m2</input>
                            </td>
                        </tr>
                        <tr>
                            <td>公推面积：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="poolArea"> m2</input>
                            </td>
                            <td>房屋结构：</td>
                            <td>
                                <select class="easyui-combobox"  name="structure" style="width:149px;" data-options="">
                                    <option value="1">其它</option>
                                    <option value="2">框架</option>
                                    <option value="3">剪力</option>
                                    <option value="4">钢混</option>
                                    <option value="5">木混</option>
                                    <option value="6">砖木</option>
                                </select>
                            </td>
                            <td>土地使用权类型：</td>
                            <td>
                                <select class="easyui-combobox"  name="landUseRight" style="width:149px;" data-options="">
                                    <option value="1">出让</option>
                                    <option value="2">划拔</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>土地终止日期：</td>
                            <td>
                                <input name="landExpiredDate" type="text" class="easyui-datebox" style="width: 149px">
                            </td>
                            <td>临街状况：</td>
                            <td><input class="easyui-validatebox" data-options="" type="text" name="streetSide"></input></td>
                            <td>临街长度：</td>
                            <td><input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="streetLength"></input> m</td>
                        </tr>
                        <tr>
                            <td>进深：</td>
                            <td><input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="depth"></input> m</td>
                            <td>装修情况：</td>
                            <td>
                                <select class="easyui-combobox" id="level" name="decorateSituation" style="width:149px;" data-options="">
                                    <option value="1">毛坯</option>
                                    <option value="2">简单装修</option>
                                    <option value="3">中等装修</option>
                                    <option value="4">精装修</option>
                                    <option value="5">豪华装修</option>
                                </select>
                            </td>
                            <td>成新状况：</td>
                            <td><input class="easyui-validatebox" data-options="" type="text" name="newSituation"></input></td>
                        </tr>
                        <tr>
                            <td>办公配套：</td>
                            <td><input class="easyui-validatebox" data-options="" type="text" name="officeFacilities"></input></td>
                            <td>停车配套：</td>
                            <td>
                                <select class="easyui-combobox"  name="parkingFacilities" style="width:149px;" data-options="">
                                    <option value="1">地上</option>
                                    <option value="2">地下</option>
                                </select>
                            </td>
                            <td>柱距：</td>
                            <td><input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="pilespacing"></input> m</td>
                        </tr>
                        <tr>
                            <td>行车梁：</td>
                            <td>
                                <select class="easyui-combobox"  name="craneBeam" style="width:149px;" data-options="">
                                    <option value="1">有行车梁</option>
                                    <option value="0">无行车梁</option>
                                </select>
                            </td>
                            <td>跨度：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="span"></input> m
                            </td>
                            <td></td>
                            <td>
                                <a class="easyui-linkbutton" onclick="javascript:dlg2.dialog('open');">标注地图</a>
                                <input type="hidden" name="lat" value="" />
                                <input type="hidden" name="lng" value="" />
                                <input type="hidden" name="houseType" value="" />
                                <input type="hidden" name="dealType" value="" />
                                <input type="hidden" name="houseId" value="" />
                            </td>
                        </tr>
                    </table>
                    <div style="padding:2px 4px;">
                        <span>配套设施：</span>
                        <label><input type="radio" name="fas"  value="1" /> 全选</label>
                        <label><input type="radio" name="fas"  value="0" /> 全不选</label>
                    </div>
                    <div id="fs_container" style="border:1px solid #95B8E7; padding:10px 30px; margin-top:5px;">
                    </div>
                </fieldset>
                <fieldset style="border:1px solid #95B8E7; padding:5px; margin-top:5px;">
                    <legend>业务信息</legend>
                    <table cellspacing="0">
                        <tr>
                            <td>成交时间：</td>
                            <td>
                                <input name="dealTime" type="text" class="easyui-datebox" style="width: 149px">
                            </td>
                            <td>成交总价：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="totalPrice"> 万元</input>
                            </td>
                            <td>成交单价：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="unitPrice"> 元/m2</input>
                            </td>
                        </tr>
                        <tr>
                            <td>实际用途：</td>
                            <td>
                                <input class="easyui-validatebox" data-options="" type="text" name="realUse"></input>
                            </td>
                            <td>经营业态：</td>
                            <td>
                                <input class="easyui-validatebox" data-options="" type="text" name="businessState"></input>
                            </td>
                            <td>物业管理费：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="propertyManagementFee"> 元</input>
                            </td>
                        </tr>
                        <tr>
                            <td>租赁情况：</td>
                            <td>
                                <input class="easyui-validatebox" data-options="" type="text" name="hireState"></input>
                            </td>
                            <td>租赁价格：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="hirePrice"></input> 元/月
                            </td>
                            <td>租赁单价：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="hireUnitPrice"></input>
                                元/m2
                            </td>
                        </tr>
                        <tr>
                            <td>租赁期限：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="hireExpiredDate"></input>
                            </td>
                            <td>转让费：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="transferFee"></input>
                                元
                            </td>
                            <td>押金：</td>
                            <td>
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="deposit"></input>
                                元
                            </td>
                        </tr>
                        <tr>
                            <td>联系电话：</td>
                            <td>
                                <input class="easyui-validatebox" data-options="" type="text" name="contactTel"></input>
                            </td>
                            <td>备注：</td>
                            <td>
                                <input class="easyui-validatebox" data-options="" type="text" name="remark"></input>
                            </td>
                            <td>案例收集人：</td>
                            <td>
                                <input class="easyui-validatebox" data-options="" type="text" name="collecter"></input>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <div id="btns">
                    <a class="easyui-linkbutton" onclick="javascript:$('#form1').submit(); " data-options="iconCls:'icon-save'">保存</a>
                    <a class="easyui-linkbutton" onclick="javascript:$('#dlg1').dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
                </div>
            </form>
        </div>
        <script type="text/template" id="house_tp">
            <fieldset style="border:1px solid #95B8E7; padding:5px;">
                <legend>基本信息</legend>
                <table cellspacing="0">
                    <tr>
                        <td>区县：</td>
                        <td><@= cityName @> </td>
                        <td>小区楼盘：</td>
                        <td><@= houseName @> </td>
                        <td>栋号及房号：</td>
                        <td><@= houseNo @> </td>
                    </tr>
                    <tr>
                        <td>楼层：</td>
                        <td><@= floor @> </td>
                        <td>总楼层：</td>
                        <td><@= totalFloor @> </td>
                        <td>层高：</td>
                        <td><@= floorHeight @> </td>
                    </tr>
                    <tr>
                        <td>房屋位置：</td>
                        <td><@= locate @> </td>
                        <td>建筑年代：</td>
                        <td><@= buildingDate @> </td>
                        <td>建筑面积：</td>
                        <td><@= constructionArea @> m2 </td>
                    </tr>
                    <tr>
                        <td>公推面积：</td>
                        <td><@= poolArea @> </td>
                        <td>房屋结构：</td>
                        <td><@=['其它','框架','剪力','钢混','木混','砖木'][ structure ] @> </td>
                        <td>土地使用权类型：</td>
                        <td><@= landUseRight == 1 ? '出让' : '划拔' @> </td>
                    </tr>
                    <tr>
                        <td>土地终止日期：</td>
                        <td><@= landExpiredDate @> </td>
                        <td>临街状况：</td>
                        <td><@= streetSide @> </td>
                        <td>临街长度：</td>
                        <td><@= streetLength @> </td>
                    </tr>
                    <tr>
                        <td>进深：</td>
                        <td><@= depth @> </td>
                        <td>装修情况：</td>
                        <td><@= ['毛坯','简单装修','中等装修','精装修','豪华装修'][decorateSituation] @> </td>
                        <td>成新状况：</td>
                        <td><@= newSituation @> </td>
                    </tr>
                    <tr>
                        <td>办公配套：</td>
                        <td><@= officeFacilities @> </td>
                        <td>停车配套：</td>
                        <td><@= parkingFacilities == 1 ? "地上" : "地下" @> </td>
                        <td>柱距：</td>
                        <td><@= pilespacing @> </td>
                    </tr>
                    <tr>
                        <td>行车梁：</td>
                        <td><@= craneBeam == 1 ? '有行车梁' : '无行车梁' @> </td>
                        <td>跨度：</td>
                        <td><@= span @> </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan=6>
                            <div style="border:1px solid #95B8E7; padding:10px 30px; margin-top:5px;">
                                <@= supportingFacilities @> 
                            </div>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <fieldset style="border:1px solid #95B8E7; padding:5px; margin-top:5px;">
                <legend>业务信息</legend>
                <table cellspacing="0">
                    <tr>
                        <td>成交时间：</td>
                        <td><@= dealTime @> </td>
                        <td>成交总价：</td>
                        <td><@= totalPrice @> 万元 </td>
                        <td>成交单价：</td>
                        <td><@= unitPrice @> 元/m2 </td>
                    </tr>
                    <tr>
                        <td>实际用途：</td>
                        <td><@= realUse @> </td>
                        <td>经营业态：</td>
                        <td><@= businessState @> </td>
                        <td>物业管理费：</td>
                        <td><@= propertyManagementFee @> 元 </td>
                    </tr>
                    <tr>
                        <td>租赁情况：</td>
                        <td><@= hireState @> </td>
                        <td>租赁价格：</td>
                        <td><@= hirePrice @> </td>
                        <td>租赁单价：</td>
                        <td><@= hireUnitPrice @> 元/m2</td>
                    </tr>
                    <tr>
                        <td>租赁期限：</td>
                        <td><@= hireExpiredDate @> </td>
                        <td>转让费：</td>
                        <td><@= transferFee @>元 </td>
                        <td>押金：</td>
                        <td><@= deposit @>元 </td>
                    </tr>
                    <tr>
                        <td>联系电话：</td>
                        <td><@= contactTel @> </td>
                        <td>备注：</td>
                        <td><@= remark @> </td>
                        <td>案例收集人：</td>
                        <td><@= collecter @> </td>
                    </tr>
                </table>
            </fieldset>
        </script>
        <div id="btns_view">
            <a class="easyui-linkbutton" id="view_graph" onclick="javascript:flag='view'; dlg2.dialog('open');  " data-options="iconCls:'icon-save'">查看地图</a>
            <a class="easyui-linkbutton" onclick="doprint('dlg3'); " data-options="iconCls:'icon-save'">打印</a>
            <a class="easyui-linkbutton" onclick="javascript:dlg3.dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
        </div>
        <script src="../resources/util.js" type="text/javascript" charset="utf-8"></script>
        <script src="house.js" type="text/javascript" charset="utf-8"></script>
    </body>
</html>
