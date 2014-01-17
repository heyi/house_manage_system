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
         
        <script src="../resources/jquery.min.js"></script>
        <script type="text/javascript" src="../resources/jquery.easyui.min.js"></script>
        <script src="../resources/locale/easyui-lang-zh_CN.js" type="text/javascript" charset="utf-8"></script>
        <script src="../resources/underscore-min.js"></script>
		<script>
		        var userLevel = <%=(user!=null?user.getUserRight():"0")%>
        </script>
        <style type="text/css" media="all">
        	#main .datagrid-wrap { border: 0px; }
            .easyui-validatebox,.easyui-numberbox { width: 180px; }
            .sf { padding: 3px 3px; }
            .sf-tb td,#dlg_info td  { padding: 6px 4px; }
            #dlg1 td { padding: 2px 4px; }
            #dlg1 .easyui-validatebox,#dlg1 .easyui-numberbox { width: 145px; }
            #fs_container input[type='checkbox'] { margin:4px 4px 4px 4px; }
            .nav-item img {display:block;width:80px;margin:auto;}
            a.nav-item  {color:#000;text-decoration: none; display:block;border-radius: 2px; text-align:center;width:100px; margin:5px auto; padding: 5px;border: 1px #ffffff solid;}
            a.nav-item:hover {color:#000;background:url(../resources/images/tab-bg.gif) repeat-x;border: 1px #8FB1DB solid; }
            a.active {color:#000;background:url(../resources/images/tree-over-bg.gif) repeat-x;border: 1px #8FB1DB solid; }
            #dlg_info table { width: 100%;}
            #dlg_info td:nth-child(even) {width: 110px;}
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
	                            <li><a href="parcel.jsp" >土地交易案例</a></li>
	                            <li><a href="house.jsp" class="ui-layout-nav-active">房产交易案例</a></li>
	                            <li><a href="law2.jsp">政策法规</a></li>
	                            <li><a href="market2.jsp">市场分析</a></li>
	                            <li><a href="stand2.jsp">标准化模板</a></li>
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
        </div>

        <div data-options="region:'west',split:true" title="案例类型" style="width: 180px;overflow:hidden;">
            <div  class="easyui-accordion" data-options ='border:false,fit:true'>
                <div title="商铺"  style="">
                    <a href="storeforsale.jsp" class="nav-item " data-houseType="1" data-dealType="1">
                        <img src="../resources/images/shop.png" alt="shop" border="0"/>
                        商铺售价案例
                    </a>
                    <a href="storeforhire.jsp" class="nav-item" data-houseType="1" data-dealType="2">
                        <img src="../resources/images/shop.png" alt="shop" border="0"/> 商铺租赁案例</a>
                </div>
                <div title="住宅"  style="" selected=true>
                    <a  class="nav-item active" data-houseType="2" data-dealType="1">
                        <img src="../resources/images/house.png" alt="shop" border="0"/>
                        住宅售价案例
                    </a>
                    <a href="houseforhire.jsp" class="nav-item" data-houseType="2" data-dealType="2">
                        <img src="../resources/images/house.png" alt="shop" border="0"/>
                        住宅租赁案例</a>
                </div>
                <div title="办公">
                    <a href="officeforsale.jsp" class="nav-item" data-houseType="3" data-dealType="1">
                        <img src="../resources/images/office.png" alt="shop" border="0"/>
                        办公售价案例</a>
                    <a href="officeforhire.jsp" class="nav-item" data-houseType="3" data-dealType="2">
                        <img src="../resources/images/office.png" alt="shop" border="0"/>
                        办公租赁案例</a>
                </div>
                <div title="工业">
                    <a href="industryforsale.jsp" class="nav-item" data-houseType="4" data-dealType="1">
                        <img src="../resources/images/factory.png" alt="shop" border="0"/>
                        工业售价案例</a>
                    <a href="industryforhire.jsp" class="nav-item" data-houseType="4" data-dealType="2">
                        <img src="../resources/images/factory.png" alt="shop" border="0"/>
                        工业租赁案例</a>
                </div>
            </div>
        </div>
        <div id="main" data-options="region:'center'" style="width: 100%;">
            <div class="easyui-layout" data-options="fit:true">
                <div data-options="region:'north',split:true,border:false" title="查询条件" style="height: 140px; overflow: hidden;">
                    <form class="sf" method="post" id="form2">
                        <table border="0" cellspacing="0" cellpadding="0" class="ui-form-table" width="100%">
                            <tr>
                                <td nowrap="nowrap" class="ui-form-table-dt">行政区域：</td>
                                <td class="ui-form-table-dd"> <input class="easyui-combotree" name="cityNo" data-options="url:'getCityList.do',onClick:_changeLatlng,onLoadSuccess:makeCityKeys,method:'get', lines:true" style="width: 188px;">
                                    <input type="hidden" name="houseType" value="2" />
                                    <input type="hidden" name="dealType" value="1" />
                                </td>
                                <td nowrap="nowrap" class="ui-form-table-dt">房屋位置：</td>
                                <td class="ui-form-table-dd"><input class="easyui-validatebox" name="locate" data-options="" style="width: 190px;"></input></td>
                                <td nowrap="nowrap" class="ui-form-table-dt">房屋结构：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd">
                                    <select class="easyui-combobox"  name="structure"
                                        style="width: 184px;" data-options="">
                                        <option value="全部">全部</option>
                                        <option value="框架">框架</option>
                                        <option value="剪力">剪力</option>
                                        <option value="钢混">钢混</option>
                                        <option value="木混">木混</option>
                                        <option value="砖木">砖木</option>
                                        <option value="其它">其它</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" class="ui-form-table-dt">建筑年代：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd">
	                                <select name="operator3" style="width: 60px;">
	                                        <option value="&gt; ">&gt;</option>
	                                        <option value="&lt; ">&lt;</option>
	                                        <option value="=">=</option>
	                                        <option value="&lt;= ">&lt;=</option>
	                                        <option value="&gt;= ">&gt;=</option>
	                                </select>
                                    <select class="easyui-combobox" name="buildingDate" style="width: 125px;" data-options="valueField:'id',textField:'text', url:'../resources/data/year.json'">
                                    </select>
                                </td>
								<td nowrap="nowrap" class="ui-form-table-dt">建筑面积：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd">
                                    <select name="operator1" style="width: 60px;">
                                        <option value="&gt; ">&gt;</option>
                                        <option value="&lt; ">&lt;</option>
                                        <option value="=">=</option>
                                        <option value="&lt;= ">&lt;=</option>
                                        <option value="&gt;= ">&gt;=</option>
                                    </select>
                                    <input class="easyui-numberbox" type="text" name="constructionArea" style="width: 125px;" data-options="precision:2,groupSeparator:','">
                                    </input> m2
                                </td>
                                <td nowrap="nowrap" class="ui-form-table-dt">土地使用权类型：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd">
                                    <select class="easyui-combobox"  name="landUseRight"
                                        style="width: 184px;" data-options="">
                                        <option value="全部">全部</option>
                                        <option value="出让">出让</option>
                                    	<option value="划拔">划拔</option>
                                    </select>
                                </td>
                                
                            </tr>
                            <tr>
                                <td nowrap="nowrap" class="ui-form-table-dt">成交单价：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd">
	                                <select name="operator2" style="width: 60px;">
	                                        <option value="&gt; ">&gt;</option>
	                                        <option value="&lt; ">&lt;</option>
	                                        <option value="=">=</option>
	                                        <option value="&lt;= ">&lt;=</option>
	                                        <option value="&gt;= ">&gt;=</option>
	                                </select> 
	                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="unitPrice" style="width: 120px;"></input> 元/m2
	                            </td>
	                            <td nowrap="nowrap" class="ui-form-table-dt">成交时间：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd">
	                                <input name="startDate" type="text"
	                                    class="easyui-datebox" style="width: 90px"> 至 <input
	                                    name="endDate" type="text" class="easyui-datebox"
	                                    style="width: 90px">
	                            </td>
                                <td colspan="2" class="ui-form-table-dd">
                                    <a class="easyui-linkbutton" onclick="javascript:search_house(); " data-options="iconCls:'icon-search'" >查询</a>
                                    <a class="easyui-linkbutton" id="btn_view" data-options="iconCls:'icon-map'" data-mode="table" onclick="javascript:graphInfo.call(this); ">切换到地图模式</a>
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

        <%@include file="footer.jsp" %>

        <div class="easyui-dialog" id="dlg2"
            data-options="iconCls:'icon-save', buttons:'#btns2', closed:true,modal:true,  inline:true,onOpen:show_gp "
            title="地图定位" style="width: 850px; height: 660px;">
            <div id="graph" style="width: 100%; height: 100%;"></div>
        </div>

        <div class="easyui-dialog" id="dlg3"
            data-options="iconCls:'icon-save', onOpen:adjustButton,  closed:true,modal:true,buttons:'#btns_view', inline:true"
            title="查看商铺售价案例" style="width: 980px; height: 600px;;">
            <div id="dlg_info" style="width: 98%; padding:1%; "></div>
        </div>
        <div id="btns2">
            <a class="easyui-linkbutton" onclick="javascript:$('#dlg2').dialog('close'); " data-options="iconCls:'icon-save'">确定</a>
            <a class="easyui-linkbutton" onclick="javascript:$('#dlg2').dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
        </div>

        <div id="dlg1" class="easyui-dialog" data-options="iconCls:'icon-save', closed:true, buttons:'#btns', modal:true,  inline:true,title:'新增房产案例'"
            style="width: 980px; height: 600px; padding: 2px;">
            <form id="form1">
                <fieldset style="border:1px solid #95B8E7; padding:5px;">
                    <legend>基本信息</legend>
                    <table border="0" cellspacing="0" cellpadding="0" class="ui-form-table">
                        <tr>
                            <td class="ui-form-table-dt">区县：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-combotree" name="cityNo" data-options="url:'getCityList.do',method:'get',onClick:changeLatlng,lines:true,onChange:show_buildings" style="width: 149px;" required="true"> 
                            </td>
                            <td class="ui-form-table-dt">小区楼盘：</td>
                            <td class="ui-form-table-dd">
                                <select class="easyui-combobox" id="s_building" name="houseName"
                                    style="width: 149px;" data-options="textField:'buildingsName',valueField:'buildingsName'" required="true"></select>
                            </td>
                            <td class="ui-form-table-dt">栋号及房号：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-validatebox" type="text" name="houseNo" data-options="" required="true"></input>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui-form-table-dt">所在楼层：</td>
                            <td class="ui-form-table-dd">
                                <input name="floor" class="easyui-numberspinner" style="width:149px;" data-options="min:1,max:200" required="true">
                            </td>
                            <td class="ui-form-table-dt">总楼层：</td>
                            <td class="ui-form-table-dd">
                                <input name="totalFloor" class="easyui-numberspinner" style="width:149px;" data-options="min:1,max:200" required="true">
                            </td>
                            <td class="ui-form-table-dt">层高(m)：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="floorHeight" required="true"></input>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui-form-table-dt">房屋位置：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-validatebox" type="text" name="locate"></input>
                            </td>
                            <td class="ui-form-table-dt">建筑年代：</td>
                            <td class="ui-form-table-dd">
                                <select class="easyui-combobox" name="buildingDate" style="width: 149px;" data-options="valueField:'id',textField:'text', url:'../resources/data/year.json'" required="true">
                                </select>
                            </td>
                            <td class="ui-form-table-dt">建筑面积(m2)：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="constructionArea" required="true"></input>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui-form-table-dt">公摊面积(m2)：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="poolArea"></input>
                            </td>
                            <td class="ui-form-table-dt">房屋结构：</td>
                            <td class="ui-form-table-dd">
                                <select class="easyui-combobox"  name="structure" style="width:149px;" data-options="" required="true">
                                    <option value="框架" selected>框架</option>
                                    <option value="剪力">剪力</option>
                                    <option value="钢混">钢混</option>
                                    <option value="木混">木混</option>
                                    <option value="砖木">砖木</option>
                                    <option value="其它">其它</option>
                                </select>
                            </td>
                            <td class="ui-form-table-dt">土地使用权类型：</td>
                            <td class="ui-form-table-dd">
                                <select class="easyui-combobox"  name="landUseRight" style="width:149px;" data-options="" required="true">
                                    <option value="出让">出让</option>
                                    <option value="划拔">划拔</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui-form-table-dt">土地终止日期：</td>
                            <td class="ui-form-table-dd">
                                <input name="landExpiredDate" type="text" class="easyui-datebox" style="width: 149px" required="true">
                            </td>
                            <td class="ui-form-table-dt">临街状况：</td>
                            <td class="ui-form-table-dd"><input class="easyui-validatebox" data-options="" type="text" name="streetSide"></input></td>
                            <td class="ui-form-table-dt">临街长度(m)：</td>
                            <td class="ui-form-table-dd"><input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="streetLength"></input></td>
                        </tr>
                        <tr>
                            <td class="ui-form-table-dt">进深(m)：</td>
                            <td class="ui-form-table-dd"><input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="depth"></input></td>
                            <td class="ui-form-table-dt">装修情况：</td>
                            <td class="ui-form-table-dd">
                                <select class="easyui-combobox" id="level" name="decorateSituation" style="width:149px;" data-options="">
                                    <option value="毛坯">毛坯</option>
                                    <option value="简单装修">简单装修</option>
                                    <option value="中等装修">中等装修</option>
                                    <option value="精装修">精装修</option>
                                    <option value="豪华装修">豪华装修</option>
                                </select>
                            </td>
                            <td class="ui-form-table-dt">成新状况：</td>
                            <td class="ui-form-table-dd"><input class="easyui-validatebox" data-options="" type="text" name="newSituation"></input></td>
                        </tr>
                        <tr>
                            <td class="ui-form-table-dt">案例编号：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-validatebox"  type="text" name="caseNo"></input>
                            </td>
                            <td class="ui-form-table-dt">电梯配套：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-validatebox"  type="text" name=""></input>
                            </td>
                            <td class="ui-form-table-dt">标注地图：</td>
                            <td class="ui-form-table-dd">
                                <a class="easyui-linkbutton" onclick="javascript:dlg2.dialog('open');" data-options="iconCls:'icon-locate'">标注地图</a>
                                <input type="hidden" name="lat" value="" />
                                <input type="hidden" name="lng" value="" />
                                <input type="hidden" name="houseType" value="" />
                                <input type="hidden" name="dealType" value="" />
                                <input type="hidden" name="houseId" value="" />
                            </td>
                        </tr>
                        <tr>
                        	<td class="ui-form-table-dt">停车配套：</td>
                            <td colspan=5 class="ui-form-table-dd">
                                <select class="easyui-combobox"  name="parkingFacilities" style="width:149px;" data-options="">
                                    <option value="地上">地上</option>
                                    <option value="地下">地下</option>
                                </select>
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
                    <table border="0" cellspacing="0" cellpadding="0" class="ui-form-table">
                        <tr>
                            <td class="ui-form-table-dt">成交时间：</td>
                            <td class="ui-form-table-dd">
                                <input name="dealTime" type="text" class="easyui-datebox" style="width: 149px" required="true">
                            </td>
                            <td class="ui-form-table-dt">成交总价(元)：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="totalPrice" required="true"></input>
                            </td>
                            <td class="ui-form-table-dt">成交单价(元/m2)：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="unitPrice" required="true"> </input>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui-form-table-dt">实际用途：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-validatebox" data-options="" type="text" name="realUse"></input>
                            </td>
                            <td class="ui-form-table-dt">经营业态：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-validatebox" data-options="" type="text" name="businessState"></input>
                            </td>
                            <td class="ui-form-table-dt">物业管理费(元)：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="propertyManagementFee"></input>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui-form-table-dt">租赁情况：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-validatebox" data-options="" type="text" name="hireState"></input>
                            </td>
                            <td class="ui-form-table-dt">租金总价(元/月)：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="hirePrice"></input> 
                            </td>
                            <td class="ui-form-table-dt">租金单价(元/m2)：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="hireUnitPrice"></input>
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="ui-form-table-dt">租赁期限：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-validatebox" type="text" name="hireExpiredDate" ></input>
                            </td>
                            <td class="ui-form-table-dt">转让费(元)：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="transferFee"></input>
                                
                            </td>
                            <td class="ui-form-table-dt">押金(元)：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-numberbox" data-options="precision:2,groupSeparator:','" type="text" name="deposit"></input>
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="ui-form-table-dt">联系电话：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-validatebox" data-options="" type="text" name="contactTel"></input>
                            </td>
                            <td class="ui-form-table-dt">备注：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-validatebox" data-options="" type="text" name="remark"></input>
                            </td>
                            <td class="ui-form-table-dt">案例收集人：</td>
                            <td class="ui-form-table-dd">
                                <input class="easyui-validatebox" data-options="" type="text" name="collecter"></input>
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellspacing="0" cellpadding="0" class="ui-form-table">
                        <tr>
                            <td class="ui-form-table-dt" >成交合同：</td>
                            <td class="ui-form-table-dd" ><input class="easyui-validatebox" type="text" disabled name="contract" data-options=""></input> <a href="#" class="easyui-linkbutton upload" data-options="iconCls:'icon-upload'">上传</a></td>
                            <td class="ui-form-table-dt" >实物照片：</td>
                            <td class="ui-form-table-dd" ><input class="easyui-validatebox" type="text" disabled name="img" data-options=""></input> <a href="#" class="easyui-linkbutton upload" data-options="iconCls:'icon-upload'">上传</a></td>
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
                <table cellspacing="0" >
					<tr>
                        <td>案例编号：</td>
                        <td colspan=5><@= caseNo @> </td>
                    </tr>
                    <tr>
                        <td>区县：</td>
                        <td><@= cityName @> </td>
                        <td>小区楼盘：</td>
                        <td><@= houseName @> </td>
                        <td>栋号及房号：</td>
                        <td><@= houseNo @> </td>
                    </tr>
                    <tr>
                        <td>所在楼层：</td>
                        <td><@= floor @> </td>
                        <td>总楼层：</td>
                        <td><@= totalFloor @> </td>
                        <td>层高(m)：</td>
                        <td><@= floorHeight @> </td>
                    </tr>
                    <tr>
                        <td>房屋位置：</td>
                        <td><@= locate @> </td>
                        <td>建筑年代：</td>
                        <td><@= buildingDate @> </td>
                        <td>建筑面积(m2)：</td>
                        <td><@= constructionArea @>  </td>
                    </tr>
                    <tr>
                        <td>公摊面积(m2)：</td>
                        <td><@= poolArea @> </td>
                        <td>房屋结构：</td>
                        <td><@= structure @> </td>
                        <td>土地使用权类型：</td>
                        <td><@= landUseRight @> </td>
                    </tr>
                    <tr>
                        <td>土地终止日期：</td>
                        <td><@= landExpiredDate @> </td>
                        <td>临街状况：</td>
                        <td><@= streetSide @> </td>
                        <td>临街长度(m)：</td>
                        <td><@= streetLength @> </td>
                    </tr>
                    <tr>
                        <td>进深(m)：</td>
                        <td><@= depth @> </td>
                        <td>装修情况：</td>
                        <td><@= decorateSituation @> </td>
                        <td>成新状况：</td>
                        <td><@= newSituation @> </td>
                    </tr>
                    <tr>
                        <td colspan=6>
                            <div style="padding:10px 30px; margin-top:5px;">
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
                        <td>成交总价(万元)：</td>
                        <td><@= totalPrice @>  </td>
                        <td>成交单价(元/m2)：</td>
                        <td><@= unitPrice @>  </td>
                    </tr>
                    <tr>
                        <td>实际用途：</td>
                        <td><@= realUse @> </td>
                        <td>经营业态：</td>
                        <td><@= businessState @> </td>
                        <td>物业管理费(元)：</td>
                        <td><@= propertyManagementFee @> </td>
                    </tr>
                    <tr>
                        <td>租赁情况：</td>
                        <td><@= hireState @> </td>
                        <td>租金总价：</td>
                        <td><@= hirePrice @> </td>
                        <td>租金单价(元/m2)：</td>
                        <td><@= hireUnitPrice @> </td>
                    </tr>
                    <tr>
                        <td>租赁期限：</td>
                        <td><@= hireExpiredDate @> </td>
                        <td>转让费(元)：</td>
                        <td><@= transferFee @> </td>
                        <td>押金(元)：</td>
                        <td><@= deposit @> </td>
                    </tr>
                    <tr>
                        <td>联系电话：</td>
                        <td><@= contactTel @> </td>
                        <td>备注：</td>
                        <td><@= remark @> </td>
                        <td>案例收集人：</td>
                        <td><@= collecter @> </td>
                    </tr>
                    <tr>
                        <td colspan=1 nowrap="nowrap">成交合同:</td>
                        <td colspan=5>
                            <a href="../uploadfile/<@= contract @>">
                                <@= contract @>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan=1 nowrap="nowrap">实物照片:</td>
                        <td colspan=5>
                            <a href="../uploadfile/<@= img @>" target="_blank">
                                <@= img @>
                            </a>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </script>
        <div id="btns_view">
            <a class="easyui-linkbutton" id="view_graph" onclick="javascript:flag='view'; dlg2.dialog('open');  " data-options="iconCls:'icon-map'">查看地图</a>
            <a class="easyui-linkbutton" onclick="doprint('dlg3'); " data-options="iconCls:'icon-print'">打印</a>
            <a class="easyui-linkbutton" onclick="javascript:dlg3.dialog('close'); " data-options="iconCls:'icon-cancel'">关闭</a>
        </div>
        <script src="../resources/util.js" type="text/javascript" charset="utf-8"></script>
        <script src="houseforsale.js" type="text/javascript" charset="utf-8"></script>
        <script src="http://api.map.baidu.com/api?v=1.5&ak=C0e1334aab91d623969240a6e098acb7&sk=7c93af0bd6efdc6610cc6026153a92c9" type="text/javascript" charset="utf-8"> 
        </script>
    </body>
</html>
