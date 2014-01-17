var w_rs = $("#w_rs"), w_gp = $("#w_gp"),table1 = $("#tb_rs"),dlg_info = $("#dlg_info");  
var flag = "add", form1, $lat, $lng, r_view = {},form2 = $("#form2"); 
var action_url = "insertLand.do";
var map, geo,marker, point,  _lat = lat = 28.19580849444327, _lng = lng = 112.95644760131836;
var bmap, mode;
var dfd_datagrid = $.Deferred();

function importfile() {
	var o = {
			"excelType":"land",//房地产是house，土地交易是land
			"houseType":"",
			"dealType":""
	};
    var rs = window .showModalDialog( "importExcel.jsp", o, "dialogWidth=300px;dialogHeight=100px;resizable=false;status=no;scroll=no;location=no;toolbar=no;menubar=no");
    if (rs === "ok") {
        table1.datagrid("reload"); 
    }
};

var gp = $("#_graph"), marker_trash=[];  
function mClickEvent (r){
    var ds = r 
    return function () {
        r["cityName"] = cityKeys[r.city]; 
        r["useNoName"] = landKeys[r.useNo]; 
        r["levelName"] = levelKeys[r.level]; 
        dlg_info.html(parcel_tp(r)); 
        r_view = r; 
        $("#dlg").dialog("open"); 
    };
}

function adjustButton() {
    if (mode == "graph") {
        $("#view_graph").hide();  
    }else {
        $("#view_graph").show();  
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
            bmap.addOverlay(m);
            m.addEventListener("click", mClickEvent(r));
        }
    }
};

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

cityKeys = {}; 
landKeys = {}; 
levelKeys = {}; 

function parcel_search() {
    var rs = form2.serializeJson(); 
    table1.datagrid("load", { "params": JSON.stringify(rs)}); 
};

function search_parcel(node) {
    form2.find("[name=city]").val(node.id);  
    form2.find("#city").val(node.text);  
    lat = node.attributes.lat || lat;
    lng = node.attributes.lng || lng;
    parcel_search(); 
};

function changeLatlng(node) {
    _lat = node.attributes.lat || _lat;
    _lng = node.attributes.lng || _lng;
    init_graph(_lat,_lng);
};

function makeLevelKeys(){
    var rs = form2.find("#level").combobox("getData"); 
    for (var i = 0, l = rs.length; i < l; i ++) {
        var r = rs[i];
        levelKeys[r.value] = r.text; 
    }
}

function makeCityKeys(node, rs) {
    setKeys(rs, cityKeys); 
};

function makeLandKeys(node, rs) {
    setKeys(rs, landKeys); 
    dfd_datagrid.resolve(); 
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

var toolbar = [{
    text: '添加',
    iconCls: 'icon-add',
    handler: function() {
        flag = "add";
        w_rs.dialog("open").dialog('setTitle','添加土地交易案例');
        $('#parcel_form').form('clear');
    }
},
'-', {
    text: '修改',
    iconCls: 'icon-edit',
    handler: function() {
        flag = "update";
        var r = table1.datagrid("getSelected"); 
        if (r) {
            for(var o in r ) {
                if(r[o] ==  '&nbsp;') r[o] = '';
            }
            form1.form("load", r); 
            w_rs.dialog("open").dialog('setTitle','修改土地交易案例');
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
        	$.messager.confirm('提示','确实要删除吗？',function(m){
        		if(m){
		            $.ajax({url:"deleteLand.do?id=" + r.landId}).success(function (result) {
		                if (result == "yes") {
		                    table1.datagrid("reload"); 
		                }else{
		                    $.messager.alert("系统信息","删除失败！","error"); 
		                }
		            });
        		}
        	});
        }else {
            $.messager.alert("警告","请选择要删除的行","warning"); 
        }
    }
},
'-',{
    text: '导入',
    iconCls: "icon-import",
    handler: function() {
        importfile();
    } }
];

if (userLevel!=1&&userLevel!=2) {
   toolbar = []; 
}

var parcel_tp =_.template($("#parcel_tp").html());
function init_graph() {
    map = new BMap.Map("graph");
    geo = new BMap.Geocoder();
    point = new BMap.Point(_lng, _lat);
    map.centerAndZoom(point, 11);
    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.ScaleControl());
    map.addControl(new BMap.OverviewMapControl());
    map.addControl(new BMap.MapTypeControl());
};

//dfd_datagrid.done(function () {
    table1.datagrid({
        fit: true,
        url: "searchLand.do", 
        pagination: true, 
        rownumbers:true, 
        fitColumns:false, 
        singleSelect:true, 
        toolbar:toolbar,
        frozenColumns:[[  
                        {width:80, field:'ck', checkbox:true},  
						{width:150, field:'caseNo', title:"案例编号"}, 
						{width:150, field:'listNo', title:"挂牌号"},   
                    ]],
        columns:[[
            {width:80, field:'dealTime', title:"成交时间"}, 
            {width:250, field:'locate', title:"位置"}, 
            {width:50, field:'level',title:'级别'}, 
            {width:80, field:'useNo',title:'用途'}, 
            {width:80, field:'useScale',title:'用途比例'}, 
            {width:80, field:'acreage', title:"面积(m2)"}, 
            {width:80, field:'areaRatio', title:"容积率"}, 
            {width:110, field:'totalPrice', title:"成交总价(万元)"}, 
            {width:110, field:'unitPrice1', title:"成交单价(元/m2)"}, 
            {width:110, field:'unitPrice2', title:"成交单价(万元/亩)"}, 
            {width:110, field:'floorPrice', title:"楼面地价(元/m2)"}
        ]], 
        onLoadSuccess: function (data) {
            var mode = $("#btn_view").data("mode");
            if (mode === 'graph') {
               init_graph_info(); 
            }
        },
        onDblClickRow: function (i, r) {
            r["cityName"] = cityKeys[r.city]; 
            r_view = $.extend({},r); 
            for(var o in r ) {
                if(!r[o]) r[o] = '&nbsp;'
            }
            dlg_info.html(parcel_tp(r)); 
            $("#dlg").dialog("open");
        }
    });
//}); 
function uploadfile(el) {
    var rs = window.showModalDialog("uploadFile.jsp", null, "dialogWidth=300px;dialogHeight=100px;resizable=false;status=no;scroll=no;location=no;toolbar=no;menubar=no");
    if (rs) {
        el.val(rs);
    }
}

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

function setLatlng(lat, lng) {
    form1.find("[name=lat]").val(lat);
    form1.find("[name=lng]").val(lng);
}

$(function() {
    $("#btn_gp").on("click", function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        w_gp.dialog("open");
    });

    $(".upload").on("click", function(e) {
        e.preventDefault();
        var el = $(this).parents('td').find("input");
        uploadfile(el);
    });
    form1 = $("#parcel_form");
    $lat = form1.find("[name=lat]");
    $lng = form1.find("[name=lng]");

    form1.submit(function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();

        var isValid = form1.form("validate");
        if (!isValid) { return; }

        var rs = form1.serializeJson();
        if (flag === "update") {
            action_url = "updateLand.do";
        }else {
            action_url = "insertLand.do";
        }
        $.ajax({
            url: action_url,
            data: {
                data: JSON.stringify(rs)
            }
        }).success(function(result) {
            if (result == "yes") {
                w_rs.dialog("close");
                table1.datagrid("reload"); 
                form1.form("clear");
            } else {
                $.messager.alert("错误","保存失败！","error"); 
            }
        });
    });
    form1.form("clear");
});

