// 房屋类型（houseType），交易类型（dealType）。房屋类型：1商铺，2住宅，3办公，4工业。交易类型：1出售，2出租
var flag = "add",houseType,dealType; 
var action_url = "insertHouse.do";
var table1 = $("#table1"), form1 = $("#form1"), form2 = $("#form2"),dlg1 = $("#dlg1"),dlg2 = $("#dlg2"), $lat = form1.find("[name=lat]"), $lng = form1.find("[name=lng]"),$ht = $("body").find("[name=houseType]") ,$dt = $("body").find("[name=dealType]"),dlg_info = $("#dlg_info"),dlg3 =  $("#dlg3");

var fs_container = $("#fs_container");
var map, geo,marker, point,  lat = 28.19, lng = 119;
var bmap, mode;
var facilities = "水,有线电视,空调,暖气,电梯,家具,物业管理,电,冰箱,微波炉,宽带,储藏/地下室,露台/花园,商务中心,煤气/天然气,洗衣机,热水器,电话,灶具,停车位,健身设备".split(",");
var cityKeys = {}; 

function makeCityKeys(node, rs) {
    setKeys(rs, cityKeys); 
};

var gp = $("#_graph");  
function mClickEvent (r){
    var ds = r ; 
    return function () {
        var fas = ds["supportingFacilities"];
        if (fas && fas.length >= 0) {
            ds["supportingFacilities"] = fas.join(",");
        }
        r_view = ds; 
        dlg_info.html(house_tp(ds)); 
        dlg3.dialog("open");
    };
}

function graphInfo() {
    mode = $(this).data("mode"); 
    if (mode  == "table") {
        $(this).find(".l-btn-text").text("切换到表格模式");
        $(this).data("mode", "graph");
        gp.show();
        init_graph_info(); 
        mode = "graph"; 
    }else {
        $(this).find(".l-btn-text").text("切换到地图模式");
        $(this).data("mode", "table");
        mode = "table"; 
        gp.hide(); 
    }
};

function setKeys(rs, keys) {
    for (var i = 0, l = rs.length; i < l; i ++) {
        var r = rs[i];
        keys[r.id] = r.text;  
        if (r.children) {
            setKeys(r.children, keys);  
        }
    }
};

function init_graph_info () {
    $("#_graph").children().remove(); 
    bmap = new BMap.Map("_graph");
    var p = new BMap.Point(lng, lat);
    bmap.centerAndZoom(p, 11);
    bmap.addControl(new BMap.NavigationControl());
    bmap.addControl(new BMap.NavigationControl());
    bmap.addControl(new BMap.ScaleControl());
    bmap.addControl(new BMap.OverviewMapControl());
    bmap.addControl(new BMap.MapTypeControl());
    var rs = table1.datagrid("getData").rows; 
    for (var i = 0, l = rs.length; i < l; i ++) {
        var r = rs[i];
        if (r.lat  &&  r.lng) {
            var p = new BMap.Point(r.lng, r.lat);
            var m = new BMap.Marker(p, 11);
            bmap.centerAndZoom(p, 11);
            bmap.addOverlay(m);
            r["cityName"] = cityKeys[r.city]; 
            m.addEventListener("click", mClickEvent(r));
        }
    }
};

function setLatlng(lat, lng) {
    form1.find("[name=lat]").val(lat);
    form1.find("[name=lng]").val(lng);
}

function init_graph(lat, lng) {
    map = new BMap.Map("graph");
    geo = new BMap.Geocoder();
    point = new BMap.Point(lng, lat);
    map.centerAndZoom(point, 11);
    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.ScaleControl());
    map.addControl(new BMap.OverviewMapControl());
    map.addControl(new BMap.MapTypeControl());
};
function adjustButton() {
    if (mode == "graph") {
        $("#view_graph").hide();  
    }else {
        $("#view_graph").show();  
    }
};

function show_gp() {
    $("#graph").children().remove(); 
    lat = $lat.val() || lat;
    lng = $lng.val() || lng;

    if (flag  === 'view') {
        lat =  r_view["lat"] || lat; 
        lng =  r_view["lng"] || lng; 
    }

    init_graph(lat, lng); 
    marker = new BMap.Marker(point, 11);
    map.addOverlay(marker);
    if (flag !== 'view') {
        marker.enableDragging();
        marker.addEventListener("dragend", function(e) {
            setLatlng(e.point.lat, e.point.lng); 
        });
    }
};

function init_fas() {
    var rs = [];
    for (var i = 0, l =facilities.length; i < l; i ++) {
        var f = facilities[i];
        rs.push("<input type='checkbox' name='SupportingFacilities[]' value='" + f + "' >" + "<span style='display:inline-block;width:78px;' >" + f + "</span>");
        if ((i+1) % 7 == 0) {
            rs.push("<br/>"); 
        }
    }
    fs_container.html(rs.join(''));
};

function search_house() {
    var rs = form2.serializeJson(); 
    table1.datagrid("load", { "params": JSON.stringify(rs)}); 
};

function show_buildings(newValue,oldValue) {
    var rs = {"cityNo" : newValue};
    $("#s_building").combobox("reload","getBuildings.do?params=" + JSON.stringify(rs));
};

function bind_chks(rs) {
    fs_container.find("input[type='checkbox']").each(function (i,el) {
        if (rs.indexOf(el.value) >= 0) {
            $(el).prop("checked",true); 
        }
    });
};

//全选，全不选
$("input[type='radio']").on("change",function () {
    var cks = fs_container.find("input[type='checkbox']");
    if (this.value == 1) {
        cks.prop("checked",true); 
    }else {
        cks.prop("checked",false); 
    }
});

var toolbar = [{
    text: '添加',
    iconCls: 'icon-add',
    handler: function() {
        flag = "add";
        dlg1.dialog("open").dialog('setTitle','添加房产交易案例');
        form1.form("clear");
        $ht.val($ht.data("housetype"));
        $dt.val($dt.data("dealtype"));
    }
},
'-', {
    text: '修改',
    iconCls: 'icon-edit',
    handler: function() {
        flag = "update";
        var r = table1.datagrid("getSelected"); 
        if (r) {
            form1.form("load", r); 
            bind_chks(r["supportingFacilities"] || '');
            dlg1.dialog("open").dialog('setTitle','添加房产交易案例');
        }else {
            $.messager.alert("警告","请选择要修改的行","warning"); 
        }
    }
},
'-',
{
    text: '删除',
    iconCls: 'icon-remove',
    handler: function() {
        var r = table1.datagrid("getSelected"); 
        if (r) {
            $.ajax({url:"deleteHouse.do?id=" + r.houseId}).success(function (result) {
                if (result == "yes") {
                    table1.datagrid("reload"); 
                    $.messager.alert("系统信息","删除成功！","info"); 
                }else{
                    $.messager.alert("系统信息","删除失败！","error"); 
                }
            });
        }else {
            $.messager.alert("警告","请选择要删除的行","warning"); 
        }
    }
}];

var house_tp =_.template($("#house_tp").html());
table1.datagrid({
    fit: true,
    url: "searchHouse.do", 
    pagination: true, 
    rownumbers:false, 
    fitColumns:true, 
    singleSelect:true, 
    toolbar:toolbar,
    columns:[[
        {width:80, field:'ck', checkbox:true}, 
        {width:80, field:'houseId', title:"序号"}, 
        {width:80, field:'houseName', title:"房屋名称"}, 
        {width:80, field:'houseNo', title:"栋号及房号"}, 
        {width:80, field:'dealTime', title:"成交时间"}, 
        {width:80, field:'cityNo', title:"所属区域"}, 
        {width:80, field:'locate', title:"具体位置"}, 
        {width:80, field:'areaNo', title:"区域代码"}, 
        {width:80, field:'realUse', title:"实际用途"} 
    ]] , 
    onLoadSuccess: function (data) {
        var mode = $("#btn_view").data("mode");
        if (mode === 'graph') {
            init_graph_info(); 
        }
    },
    onDblClickRow: function (i, r) {
        r["cityName"] = cityKeys[r.city]; 
        var fas = r["supportingFacilities"];
        if (fas && fas.length >= 0) {
            r["supportingFacilities"] = fas.replace(/[\[\]\"]/g,""); 
        }
        r_view = r; 
        dlg_info.html(house_tp(r)); 
        dlg3.dialog("open");
    }
});
form1.submit(function (e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    var rs = form1.serializeJson();
    var fas = rs["supportingFacilities"];
    if (flag === "update") {
        action_url = "updateHouse.do";
    }else {
        action_url = "insertHouse.do";
    }
    if (fas && fas.length >= 0) {
        rs["supportingFacilities"] = fas.join(",");
    }
    $.ajax({
        url: action_url,
        data: {
            data: JSON.stringify(rs)
        }
    }).success(function(result) {
        if (result == "yes") {
            dlg1.dialog("close");
            table1.datagrid("reload"); 
            form1.form("clear");
        } else {
            $.messager.alert("错误","保存失败！","error"); 
        }
    });
});

$(".nav").on("click","a",function (e) {
    var housetype = $(this).data("housetype") ;
    var dealtype = $(this).data("dealtype") ;
    $ht.data("housetype",housetype).val(housetype); 
    $dt.data("dealtype",dealtype).val(dealtype); 

    $('.nav').find("a").removeClass("active");
    $(this).addClass("active");
    search_house();
});

setTimeout(function () { $(".nav").find("a:first").trigger("click");
},0);

$(function () {
    init_fas();
});
