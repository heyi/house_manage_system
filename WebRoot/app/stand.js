var table1 = $("#table1"), dlg_info = $("#dlg_info"),dlg3 =  $("#dlg3");

function search_database() {
    var rs = form2.serializeJson(); 
    table1.datagrid("load", { "params": JSON.stringify(rs)}); 
};

var dfd_datagrid = $.Deferred();
$.getJSON("../resources/data/database.json",function (rs) {
    $("#tree1").tree("loadData", rs[2].children);
});

var tp1 =_.template($("#tp1").html());

dfd_datagrid.done(function () {
    table1.datagrid({
        fit: true,
        url: "searchInfomation.do", 
        pagination: true, 
        rownumbers:true, 
        fitColumns:true, 
        singleSelect:true, 
        columns:[[
            {width:80, field:'infoTitle', title:"标题"}, 
            {width:80, field:'catagoryName', title:"所属分类"}, 
            {width:80, field:'insertTime', title:"录入时间"} 
        ]] , 
        onDblClickRow: function (i, r) {
            for(var o in r ) {
                if(!r[o]) r[o] = '&nbsp;'
            }
            dlg_info.html(tp1(r)); 
            dlg3.dialog("open");
        }
    });
}); 

var params = {};

function search_key(node) {
    var id = node.id; 
    params["catagoryId"] = id;
    table1.datagrid("load", { "params": JSON.stringify(params)});
};

$("#input-search").on("change", function (e) {
    var key = $(this).val(); 
    params["key"] = key;
    table1.datagrid("load", { "params":JSON.stringify(params) });
}); 

$(function () {
    dfd_datagrid.resolve(); 
});
