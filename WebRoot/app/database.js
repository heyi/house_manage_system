var flag = "add"; 
var action_url = "insertInfomation.do";
var table1 = $("#table1"), form1 = $("#form1"), form2 = $("#form2"),dlg1 = $("#dlg1"),dlg_info = $("#dlg_info"),dlg3 =  $("#dlg3");
var database;

function search_database() {
    var rs = form2.serializeJson(); 
    table1.datagrid("load", { "params": JSON.stringify(rs)}); 
};

var dfd_datagrid = $.Deferred();
var editor = CKEDITOR.replace( 'ckeditor' );

$.getJSON("../resources/data/database.json",function (rs) {
   database = rs;
   $(".nav").find("a:first").trigger("click");
});

var toolbar = [{
    text: '添加',
    iconCls: 'icon-add',
    handler: function() {
        flag = "add";
        dlg1.dialog("open").dialog('setTitle','添加资料库');
        form1.form("clear");
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
            dlg1.dialog("open").dialog('setTitle','修改资料库');
            editor.setData(r.content);
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
            $.ajax({url:"deleteInfomation.do?id=" + r.infoId}).success(function (result) {
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

var tp1 =_.template($("#tp1").html());

dfd_datagrid.done(function () {
    table1.datagrid({
        fit: true,
        url: "searchInfomation.do", 
        pagination: true, 
        rownumbers:false, 
        fitColumns:true, 
        singleSelect:true, 
        toolbar:toolbar,
        columns:[[
            {width:80, field:'ck', checkbox:true}, 
            {width:80, field:'infoId', title:"序号"}, 
            {width:80, field:'infoTitle', title:"标题"}, 
            {width:80, field:'catagoryId', title:"所属分类"}, 
            {width:80, field:'insertTime', title:"录入时间"} 
        ]] , 
        onDblClickRow: function (i, r) {
            r_view = r; 
            dlg_info.html(tp1(r)); 
            dlg3.dialog("open");
        }
    });
}); 

form1.submit(function (e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    var rs = form1.serializeJson();
    rs["content"] = editor.getData();
    if (flag === "update") {
        action_url = "updateInfomation.do";
    }else {
        action_url = "insertInfomation.do";
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
            editor.setData("");
        } else {
            $.messager.alert("错误","保存失败！","error"); 
        }
    });
});

function uploadfile(el) {
    var rs = window.showModalDialog("uploadFile.jsp", null, "dialogWidth=300px;dialogHeight=100px;resizable=false;status=no;scroll=no;location=no;toolbar=no;menubar=no");
    if (rs) {
        el.val(rs);
    }
}

$(".upload").on("click", function(e) {
    e.preventDefault();
    uploadfile($(this).prev());
});

$(".nav").on("click","a",function (e) {
    var index = $(this).data("index");
    $("#tree1").combotree("loadData",database[index].children);
    $("#tree2").combotree("loadData",database[index].children);
    $('.nav').find("a").removeClass("active");
    $(this).addClass("active");
    search_database();
});


$(function () {
    dfd_datagrid.resolve(); 
});
