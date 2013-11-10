var map, geo, info_window; 
function init_graph() {
    map = new BMap.Map("graph");  
    geo = new BMap.Geocoder();    
    info_window = new BMap.InfoWindow('');
    map.centerAndZoom(new BMap.Point(112.98, 28.19), 11);  
    map.addControl(new BMap.NavigationControl());  
    map.addControl(new BMap.NavigationControl());  
    map.addControl(new BMap.ScaleControl());  
    map.addControl(new BMap.OverviewMapControl());  
    map.addControl(new BMap.MapTypeControl());  
    map.setCurrentCity("长沙"); 
};
var w_rs = $("#w_rs"); 
var tb_rs = $("#tb_rs");
var info_content = _.template($("#house_info").html()); 
var test_template_data = {"name":"长房时代城", "address":"人人乐广场", "area":"岳麓区", "level":"四级", "bussiness":"住宅" }; 
$(function () {
    w_rs.window("close");  
    $("#dg_rs").datagrid({
        fit:true 
    }); 
    init_graph(); 
});

$("#btn_search").on("click", function (e) {
    w_rs.window("open");  
    $("#dg_rs").datagrid({"url":"graph.json"}); 
});

$("#btn_mode").on("click", function (e) {
    var txt = $(this).find(".l-btn-text").text(); 
    if (txt  == "切换到表格模式") {
        $("#graph_table").show();   
        $("#graph").hide();   
        var inited = tb_rs.data("inited"); 
        if (!inited) {
            tb_rs.data("inited", true);  
            tb_rs.datagrid({ fit:true }); 
        }
        $(this).find(".l-btn-text").text("切换到地图模式");
    }else {
        $("#graph_table").hide();   
        $("#graph").show();   
        $(this).find(".l-btn-text").text("切换到表格模式");
    }
});

function format_action(val, row) {
    return "<a href='javascript:void(0)' onclick='search_house.call(this)' class='easyui-linkbautton l-btn' data-house='" + row["house_name"] + "' > <span class='l-btn-left'><span class='l-btn-text'>点击查看地图</span></span> </a>"; 
};

function search_house() {
    w_rs.window("close");  
    $("#graph_table").hide();   
    $("#graph").show();   
    var house_name = $(this).data("house"); 
    // 将地址解析结果显示在地图上，并调整地图视野  
    geo.getPoint(house_name, function(point){    
        if (point) {    
            map.centerAndZoom(point, 16);    
            var marker = new BMap.Marker(point); 
            map.addOverlay(marker);    

            marker.addEventListener("click", function(){          
                info_window.setContent(info_content(test_template_data)); 
                this.openInfoWindow(info_window);
            });
        }    
    }, "长沙市");    
}

