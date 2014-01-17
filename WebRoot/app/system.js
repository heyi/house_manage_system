var tab1 = $("#tab1");
var form1 = $("#form1"),sform1 = $("#sform1"),table1 = $("#table1"),dlg1 = $("#dlg1");
var form2 = $("#form2"),sform2 = $("#sform2"),table2 = $("#table2"),dlg2 = $("#dlg2");
var form3 = $("#form3"),sform3 = $("#sform3"),table3 = $("#table3"),dlg3 = $("#dlg3");
var form4 = $("#form4"),form5 = $("#form5"),dlg4 = $("#dlg4");

var key, objs = {
    1 : {form:form1,sform:sform1,flag:"add",dlg:dlg1, search_url:"showUsers.do", save_url: "saveUser.do",update_url:"updateUser.do",action_url:"",table:table1,id:"userId",delete_url:"deleteUser.do?userId="},
    2 : {form:form2,sform:sform2,flag:"add",dlg:dlg2, search_url:"searchSector.do",save_url: "insertSector.do", update_url:"updateSector.do",action_url:"",table:table2,id:"sectorId",delete_url:"deleteSector.do?id="}, 
    3 : {form:form3,sform:sform3,flag:"add",dlg:dlg3, search_url:"searchBuildings.do",save_url: "insertBuildings.do",update_url:"updateBuildings.do",action_url:"",table:table3,id:"buildingsId",delete_url:"deleteBuildings.do?id="}
}

function uploadfile() {
    var rs = window.showModalDialog("uploadFile.jsp", null, "dialogWidth=300px;dialogHeight=100px;resizable=false;status=no;scroll=no;location=no;toolbar=no;menubar=no");
    if (rs) {
        img_url= "../uploadfile/" + rs;
        $("#img_photo").prop("src",img_url);
        $("#photo").val(img_url)
    }
}
function search_sectorid(newValue,oldValue) {
   $.ajax({url:"getSectorListByCityNo.do?cityNo=" + newValue}).done( function (rs) {
       $("#sectorId").combobox("loadData",rs);   
   });
};

var toolbar =  [{
    text: '添加',
    iconCls: 'icon-add',
    handler: function() {
        var o = objs[key];
        o["flag"] = "add";
        if (o["form"] == form1) {
            $("#username1").removeAttr("disabled"); 
        }
        o["dlg"].dialog("open");
        o["form"].form("clear");
    }
},
'-', {
    text: '修改',
    iconCls: 'icon-edit',
    handler: function() {
        var o = objs[key];
        o["flag"] = "update";
        var r = o["table"].datagrid("getSelected"); 
        if (r) {
            o["form"].form("load", r); 
            if (o["form"] == form1) {
                $("#username1").attr("disabled", "disabled"); 
            }else if (o["form"] == form3) {
                $.ajax({url:"getSectorListByCityNo.do?cityNo=" + r["cityNo"]}).done( function (rs) {
                    $("#sectorId").combobox("loadData",rs);
                    $("#sectorId").combobox("setValue",r["sectorId"]);   
                });
            }
            o["dlg"].dialog("open", r); 
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
        var o = objs[key];
        var r = o.table.datagrid("getSelected"); 
        if (r) {
        	$.messager.confirm('提示','确实要删除吗？',function(m){
        		if(m){
		            $.ajax({url:o["delete_url"] + r[o["id"]]}).success(function (result) {
		                if (result == "yes") {
		                    o.table.datagrid("reload"); 
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
}];

var _toolbar = $.extend(true,[],toolbar);
if (userLevel!=1&&userLevel!=2) {
    toolbar = []; 
}
if (userLevel!=1) { _toolbar = []; }


$.ajax({url:"getUserinfo.do"}).done(function (rs) {
    form4.form("load",rs);
    if (rs["photo"]) {
        $("#img_photo").prop("src",rs["photo"]);
    }
});

function search() {
    var o = objs[key];
    var rs = o["sform"].serializeJson(); 
    o["table"].datagrid("load", { "params": JSON.stringify(rs)}); 
}

$(".sf").find("a.easyui-linkbutton").on("click",function (e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    search();
});

var role = { 1: "系统管理员", 2:"信息录入员", 3: "普通用户" };

table1.datagrid({
    fit: true,
    url: "showUsers.do", 
    pagination: true, 
    rownumbers:true, 
    fitColumns:true, 
    singleSelect:true, 
    toolbar:_toolbar,
    columns:[[
        {width:80, field:'ck', checkbox:true}, 
        {width:80, field:'username', title:"用户名"}, 
        {width:80, field:'userRight', title:"角色",formatter: function(v, r, i){ return role[v]}}, 
        {width:80, field:'trueName', title:"姓名"}, 
        {width:80, field:'idcard', title:"头衔"}, 
        {width:80, field:'mobile', title:"手机"}, 
        {width:80, field:'qq', title:"QQ"} 
    ]] , 
    onDblClickRow: function (i, r) {
    }
});

table2.datagrid({
    fit: true,
    url: "searchSector.do", 
    pagination: true, 
    rownumbers:true, 
    fitColumns:true, 
    singleSelect:true, 
    toolbar:toolbar,
    columns:[[
        {width:80, field:'ck', checkbox:true}, 
        {width:80, field:'cityName', title:"所属区县"}, 
        {width:80, field:'sectorName', title:"板块名称"} 
    ]] , 
    onDblClickRow: function (i, r) {
    }
});

table3.datagrid({
    fit: true,
    url: "searchBuildings.do", 
    pagination: true, 
    rownumbers:true, 
    fitColumns:true, 
    singleSelect:true, 
    toolbar:toolbar,
    columns:[[
        {width:80, field:'ck', checkbox:true}, 
        {width:80, field:'buildingsName', title:"楼盘名称"}, 
        {width:80, field:'buildingsAddress', title:"楼盘地址"},  
        {width:80, field:'cityName', title:"所在区县"}, 
        {width:80, field:'sectorName', title:"所在板块"},  
        {width:80, field:'pinyin', title:"楼盘拼音"}
    ]] , 
    onDblClickRow: function (i, r) {
    }
});

function search_sector(node) {
    $("#cityNo").val(node.id);
    search();
};

form4.submit(function (e) {
    e.preventDefault();
    e.stopImmediatePropagation();

    var isValid = form4.form("validate");
    if (!isValid) { return; }
    var rs = form4.serializeJson();
    $.ajax({
        url: "updateUser.do",
        data: {
            data: JSON.stringify(rs)
        }
    }).success(function(result) {
        if (result == "yes") {
            $.messager.alert("提示","保存成功！","ok"); 
        } else {
            $.messager.alert("错误","保存失败！","error"); 
        }
    });
});

form5.submit(function (e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    var isValid = form5.form("validate");
    if (!isValid) { return; }
    var rs = form5.serializeJson();
    if (rs["newPassword"] !== rs["confirmPassword"]) {
        $.messager.alert("错误","两次密码不一致！","error"); 
        return false;
    }
    $.ajax({
        url: "editPassword.do",
        data: {
            user: JSON.stringify(rs)
        }
    }).success(function(rs) {
        if (rs.result == "yes") {
            $.messager.alert("提示","保存成功！","ok"); 
        } else {
            $.messager.alert("错误","保存失败！","error"); 
        }
    });
});

$("#form1,#form2, #form3").submit(function (e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    var isValid = $(this).form("validate");
    if (!isValid) { return; }

    var o = objs[key];
    var rs = o.form.serializeJson();
    if (o.flag === "update") {
        o.action_url = o.update_url;
    }else {
        o.action_url = o.save_url;
    }
    $.ajax({
        url: o.action_url,
        data: {
            data: JSON.stringify(rs)
        }
    }).success(function(result) {
        if (result == "yes") {
            o.dlg.dialog("close");
            o.table.datagrid("reload"); 
            o.form.form("clear");
        } else {
            $.messager.alert("错误","保存失败！","error"); 
        }
    });
});

$(".nav").on("click","a",function (e) {
    key = $(this).data("key");
    $('.nav').find("a").removeClass("active");
    $(this).addClass("active");
    tab1.tabs("select",key-1);
});
var navs = $(".nav").find("a");

function tab_select(title,index) {
    key = index + 1;
    $('.nav').find("a").removeClass("active");
    $(navs[index]).addClass("active");
};

setTimeout(function () {
    $(navs[0]).trigger("click");
},10);

function checkUsername(username) {
   $.ajax({
       url:"checkUserName.do", 
       data: {username:username}
   }).done(function (rs) {
       if (rs  === "yes") {
           $.messager.alert("警告","该用户名已经存在","warning"); 
           self.focus();
           self.blur(); 
           $(self).val(""); 
       }
   });
}

$("#username1").on("focusout",function (e) {
    if (!this.value) {
    	$.messager.alert("警告","用户名不能为空","error"); 
        return false;
    }
    var opt ={ 
        url : "checkUserName.do",
        data:{ 
            username : this.value,
            nb: new Date().getTime()
        },
        success: function (rs) {
            if (rs == "yes") {
            	$.messager.alert("警告","该用户名已经存在","error"); 
                $("#username1").val("");
            }  
        }
    };
    $.ajax(opt);
    return false;
});

