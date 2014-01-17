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
        <script>
        var userLevel = <%=(user!=null?user.getUserRight():"0")%>
        </script>
        <style type="text/css" media="all">
            #main .datagrid-wrap { border: 0px; }
            .sf { padding: 5px 5px; }
            .sf-tb td,#dlg_info td { padding: 6px 4px; }
            .easyui-validatebox,.easyui-numberbox { width: 180px; }
            #w_rs td { padding: 5px; }
            #w_rs table { width: 100%; }
            #dlg_info {background:none; border:none;}
            #dlg_info table { width:99%; margin:auto; margin-top: 5px;}
            <%-- #dlg_info td {border-left:1px solid #95B8E7;border-bottom:1px solid #95B8E7;}--%>
            <%-- #dlg_info td:last-child {border-right:1px solid #95B8E7;}--%>
            #dlg_info td:first-child{width: 120px;}
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
	                            <li ><a href="parcel.jsp" class="ui-layout-nav-active">土地交易案例</a></li>
	                            <li><a href="house.jsp">房产交易案例</a></li>
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

        <div data-options="region:'west',split:true" title="选择地区:"
            style="width: 200px;">
            <ul class="easyui-tree" data-options="url:'getCityList.do',method:'get',lines:true, onLoadSuccess:makeCityKeys, onClick:search_parcel"></ul>
        </div>
         <div id="main" data-options="region:'center'" style="width: 100%;">
            <div class="easyui-layout" data-options="fit:true">
                <div data-options="region:'north',split:true,border:false" title="查询条件" style="height: 140px; overflow: hidden;">
                    <form class="sf" method="post" id="form2">
                        <table border="0" cellspacing="0" cellpadding="0" class="ui-form-table" width="100%">
                            <tr>
                                <td nowrap="nowrap" class="ui-form-table-dt">挂&nbsp;牌&nbsp;号：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                                    name="listNo" data-options="" style="width: 130px;"></input></td>
                                <td nowrap="nowrap" class="ui-form-table-dt">行政区域：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd">
                                    <input id="city" class="easyui-validatebox" readonly data-options="" style="width: 130px;">
                                    <input type="hidden" name="city" value="" />
                                </td>
                                <td nowrap="nowrap" class="ui-form-table-dt">土地坐落：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                                    name="locate" data-options="" style="width: 130px;"></input></td>
                                
                            </tr>
                            <tr>
                                <td nowrap="nowrap" class="ui-form-table-dt">土地面积：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd"><select name="operator1" style="width: 45px;">
                                        <option value="&gt; ">&gt;</option>
                                        <option value="&lt; ">&lt;</option>
                                        <option value="=">=</option>
                                        <option value="&lt;= ">&lt;=</option>
                                        <option value="&gt;= ">&gt;=</option>
                                    </select> <input class="easyui-numberbox" type="text" name="acreage"
                                    style="width: 80px;"></input> m2</td>
                                <td nowrap="nowrap" class="ui-form-table-dt">级&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd"><select class="easyui-combobox" id="level" name="level" 
                                        style="width: 130px;" data-options="onLoadSuccess:makeLevelKeys">
                                        <option value="全部">全部</option>
                                        <option value="一级">一级</option>
		                                <option value="二级">二级</option>
		                                <option value="三级">三级</option>
		                                <option value="四级">四级</option>
		                                <option value="五级">五级</option>
		                                <option value="六级">六级</option>
		                                <option value="七级">七级</option>
                                </select></td>
                                <td nowrap="nowrap" class="ui-form-table-dt">土地用途：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd"><input id='ctree1' class="easyui-validatebox" name="useNo"
                                    
                                    style="width: 130px;"></td>
                                <!--  
                                <td nowrap="nowrap">容积率：</td>
                                <td><input class="easyui-numberbox"
                                    data-options="precision:2,groupSeparator:','" type="text"
                                    name="areaRatio"></input></td>
                                    -->
                            </tr>
                            <tr>
                                <td nowrap="nowrap" class="ui-form-table-dt">成交单价：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd"><select name="operator2" style="width: 45px;">
                                        <option value="&gt; ">&gt;</option>
                                        <option value="&lt; ">&lt;</option>
                                        <option value="=">=</option>
                                        <option value="&lt;= ">&lt;=</option>
                                        <option value="&gt;= ">&gt;=</option>
                                    </select> <input class="easyui-numberbox"
                                    data-options="precision:2,groupSeparator:','" type="text"
                                    name="unitPrice1" style="width: 80px;"></input> 元/m2</td>
                                <td nowrap="nowrap" class="ui-form-table-dt">成交时间：</td>
                                <td nowrap="nowrap" class="ui-form-table-dd" ><input name="startDate" type="text"
                                    class="easyui-datebox" style="width: 100px"> 至 <input
                                    name="endDate" type="text" class="easyui-datebox"
                                    style="width: 100px"></td>
                                <td colspan="2" class="ui-form-table-dd"><a class="easyui-linkbutton" onclick="javascript:parcel_search(); " data-options="iconCls:'icon-search'" >查询</a>
                                    <a class="easyui-linkbutton" id="btn_view" data-options="iconCls:'icon-map'" data-mode="table" onclick="javascript:graphInfo.call(this); ">切换到地图模式</a>
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

        <%@include file="footer.jsp" %>

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
            title="查看土地案例" style="width: 800px; height: 550px;">
            <div id="dlg_info"></div>
        </div>
        <div id="w_rs" class="easyui-dialog"
            data-options="iconCls:'icon-save', closed:true, buttons:'#btns', modal:true,  inline:true,title:'新增土地案例'"
            style="width: 900px; height: 580px; padding: 10px;">
            <form id="parcel_form">
                <table border="0" cellspacing="0" cellpadding="0" class="ui-form-table">
                    <tr>
                        <td class="ui-form-table-dt">案例编号：</td>
                        <td class="ui-form-table-dd">
                        <input class="easyui-validatebox" type="text" 
                            name="caseNo" data-options="" required="true"></input> 
                        </td>
                        <td class="ui-form-table-dt">挂牌号：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                            name="listNo" data-options="" required="true"></input> <input
                            class="easyui-validatebox" type="hidden" value="" name="landId" />
                        </td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">成交时间：</td>
                        <td class="ui-form-table-dd"><input name="dealTime" type="text" class="easyui-datebox"
                            style="" required="true"></td>
                        <td class="ui-form-table-dt">行政区域：</td>
                        <td class="ui-form-table-dd"><input class="easyui-combotree" name="city" required="true" data-options="url:'getCityList.do',method:'get',onClick:changeLatlng, lines:true" style="width: 175px;"></td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">土地坐落：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                            name="locate" data-options=""></input></td>
                        <td class="ui-form-table-dt">地图位置：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="hidden" disabled name="lat" style="width: 90px;"></input>
                            <input class="easyui-validatebox" type="hidden" disabled name="lng" style="width: 90px;"></input>
                            <a href="#" id="btn_gp" class="easyui-linkbutton" data-options="iconCls:'icon-locate'">标注地图</a></td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">级别：</td>
                        <td class="ui-form-table-dd"><select class="easyui-combobox" name="level"
                                style="width: 194px;" >
                                <option value="一级">一级</option>
                                <option value="二级">二级</option>
                                <option value="三级">三级</option>
                                <option value="四级">四级</option>
                                <option value="五级">五级</option>
                                <option value="六级">六级</option>
                                <option value="七级">七级</option>
                        </select></td>
                        <td class="ui-form-table-dt">用途：</td>
                        <td class="ui-form-table-dd"><input class="easyui-combotree" name="useNo"
                            data-options="url:'../resources/data/land.json',method:'get',lines:true"
                            style="width: 230px;" ></td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">用途比例：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                            name="useScale" ></input></td>
                        <td class="ui-form-table-dt">面积(m2)：</td>
                        <td class="ui-form-table-dd"><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="acreage" required="true"></input></td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">容积率：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text" name="areaRatio"></input></td>
                        <td class="ui-form-table-dt">出让年限：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text" name="ageLimit"></input></td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">起始价(万元)：</td>
                        <td class="ui-form-table-dd"><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="startingPrice"></input></td>
                        <td class="ui-form-table-dt">成交总价(万元)：</td>
                        <td class="ui-form-table-dd"><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="totalPrice" required="true"></input></td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">成交单价(元/m2)：</td>
                        <td class="ui-form-table-dd"><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="unitPrice1" ></input> </td>
                        <td class="ui-form-table-dt">成交单价(万元/亩)：</td>
                        <td class="ui-form-table-dd"><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="unitPrice2" ></input> </td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">楼面地价(元/m2)：</td>
                        <td class="ui-form-table-dd"><input class="easyui-numberbox"
                            data-options="precision:2,groupSeparator:','" type="text"
                            name="floorPrice"></input> </td>
                        <td class="ui-form-table-dt">成交单位：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                            name="dealUnit" data-options="" required="true"></input></td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">竞价次数：</td>
                        <td class="ui-form-table-dd"><input type="text" data-options="groupSeparator:','"
                            class="easyui-numberbox" name="bidTimes" style="width: 184px;" />
                        </td>
                        <td class="ui-form-table-dt">评估报告：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                            disabled name="assessmentReport" data-options=""></input> <a
                                href="#" class="easyui-linkbutton upload"
                                data-options="iconCls:'icon-upload'">上传</a></td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">成交确认书：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                            disabled name="dealConfirmation" data-options=""></input> <a
                                href="#" class="easyui-linkbutton upload"
                                data-options="iconCls:'icon-upload'">上传</a></td>
                        <td class="ui-form-table-dt">出让公告：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                            disabled name="transferNotice" data-options=""></input> <a
                                href="#" class="easyui-linkbutton upload"
                                data-options="iconCls:'icon-upload'">上传</a></td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">规划设计条件书：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                            disabled name="designSheets" data-options=""></input> <a href="#"
                                class="easyui-linkbutton upload"
                                data-options="iconCls:'icon-upload'">上传</a></td>
                        <td class="ui-form-table-dt">出让须知：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                            disabled name="grantNotice" data-options=""></input> <a
                                href="#" class="easyui-linkbutton upload"
                                data-options="iconCls:'icon-upload'">上传</a></td>
                    </tr>
                    <tr>
                        <td class="ui-form-table-dt">测绘成果：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                            disabled name="mappingResult" data-options=""></input> <a href="#"
                                class="easyui-linkbutton upload"
                                data-options="iconCls:'icon-upload'">上传</a></td>
                        <td class="ui-form-table-dt">实物照片：</td>
                        <td class="ui-form-table-dd"><input class="easyui-validatebox" type="text"
                            disabled name="img" data-options=""></input> <a
                                href="#" class="easyui-linkbutton upload"
                                data-options="iconCls:'icon-upload'">上传</a></td>
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
            <a class="easyui-linkbutton" id="view_graph" onclick="javascript:flag='view'; w_gp.window('open');  " data-options="iconCls:'icon-map'">查看地图</a>
            <a class="easyui-linkbutton" onclick="doprint('dlg'); " data-options="iconCls:'icon-print'">打印</a>
            <a class="easyui-linkbutton" onclick="javascript:$('#dlg').window('close'); "data-options="iconCls:'icon-cancel'">关闭</a>
        </div>
        <script type="text/template" id="parcel_tp">
            <table cellspacing="0"  >
                 <tr>
                    <td nowrap="nowrap">案例编号：</td>
                    <td colspan="3"><@= caseNo @> </td>
                    
                </tr>
                <tr>
                    <td nowrap="nowrap">挂牌号：</td>
                    <td><@= listNo @> </td>
                    <td nowrap="nowrap">成交时间：</td>
                    <td><@= dealTime @> </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">行政区域：</td>
                    <td><@= cityName @> </td>
                    <td nowrap="nowrap">土地坐落：</td>
                    <td><@= locate @> </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">级别：</td>
                    <td><@= level @> </td>
                    <td nowrap="nowrap">用途：</td>
                    <td><@= useNo @> </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">用途比例：</td>
                    <td><@= useScale @> </td>
                    <td nowrap="nowrap">面积：</td>
                    <td><@= acreage @> </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">容积率：</td>
                    <td><@= areaRatio @> </td>
                    <td nowrap="nowrap">出让年限：</td>
                    <td><@= ageLimit @> </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">起始价(万元)：</td>
                    <td><@= startingPrice @> </td>
                    <td nowrap="nowrap">成交总价(万元)：</td>
                    <td><@= totalPrice @> </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">成交单价(元/m2)：</td>
                    <td><@= unitPrice1 @> </td>
                    <td nowrap="nowrap">成交单价(万元/亩)：</td>
                    <td><@= unitPrice2 @> </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">楼面地价(元/m2)：</td>
                    <td><@= floorPrice @> </td>
                    <td nowrap="nowrap">成交单位：</td>
                    <td><@= dealUnit @> </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">竞价次数：</td>
                    <td><@= bidTimes @> </td>
                    <td>&nbsp; </td>
                    <td>&nbsp; </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">成交确认书：</td>
                    <td >
                        <a href="../uploadfile/<@= dealConfirmation @>">
                            <@= dealConfirmation @>
                        </a>
                    </td>
                    <td nowrap="nowrap">出让公告：</td>
					<td >
                        <a href="../uploadfile/<@= transferNotice @>">
                            <@= transferNotice @>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">规划设计条件书：</td>
                    <td >
                        <a href="../uploadfile/<@= designSheets @>">
                            <@= designSheets @>
                        </a>
                    </td>
					<td nowrap="nowrap">出让须知：</td>
					<td >
                        <a href="../uploadfile/<@= grantNotice @>">
                            <@= grantNotice @>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">测绘成果:</td>
                    <td >
                        <a href="../uploadfile/<@= mappingResult @>" >
                            <@= mappingResult @>
                        </a>
                    </td>
					<td nowrap="nowrap">实物照片：</td>
					<td >
                        <a href="../uploadfile/<@= img @>" target="_blank">
                            <@= img @>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">评估报告:</td>
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
