var flag = "add"; 
var action_url = "insertInfomation.do";
var table1 = $("#table1"), form1 = $("#form1"), form2 = $("#form2"),dlg1 = $("#dlg1"),dlg_info = $("#dlg_info"),dlg3 =  $("#dlg3");

var params = {};
function search_key(node) {
    var id = node.id; 
    params["catagoryId"] = id;
    table1.datagrid("load", { "params": JSON.stringify(params)});
};

function search_database() {
    var rs = form2.serializeJson(); 
    params["infoTitle"] = rs["infoTitle"];
    if(!params["catagoryId"]) params["catagoryId"] = "3";
    table1.datagrid("load", { "params": JSON.stringify(params)}); 
};

var dfd_datagrid = $.Deferred();
//var editor = CKEDITOR.replace( 'ckeditor' );
var editor = CKEDITOR.replace( 'ckeditor',
	    {
			uiColor: '#14B8C4',
			width: '740px', //宽度
			height: '300px', //高度
			toolbar: [
			  		{ name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
					{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker' ], items: [ 'Scayt' ] },
					{ name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
					{ name: 'insert', items: [ 'Image', 'Table', 'HorizontalRule', 'SpecialChar' ] },
					{ name: 'tools', items: [ 'Maximize' ] },
					{ name: 'others', items: [ '-' ] },
					{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Strike', '-', 'RemoveFormat' ] },
					{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote' ] },
					{ name: 'styles', items: [ 'Styles', 'Format' ] }
			  	]
		});

$.getJSON("../resources/data/database.json",function (rs) {
    $("#tree1").tree("loadData", rs[2].children);
    $("#tree2").combotree("loadData", rs[2].children);
});

var toolbar = [{
    text: '添加',
    iconCls: 'icon-add',
    handler: function() {
        flag = "add";
        dlg1.dialog("open").dialog('setTitle','添加资料模板');
        form1.form("clear");
        editor.setData("");
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
            dlg1.dialog("open").dialog('setTitle','修改资料模板');
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
        	$.messager.confirm('提示','确实要删除吗？',function(m){
        		if(m){
		            $.ajax({url:"deleteInfomation.do?id=" + r.infoId}).success(function (result) {
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
}];

if (userLevel!=1&&userLevel!=2) {
   toolbar = []; 
}

var tp1 =_.template($("#tp1").html());

dfd_datagrid.done(function () {
    table1.datagrid({
        fit: true,
        url: "searchInfomation.do", 
        queryParams:{ params: JSON.stringify({catagoryId: "3"}) },
        pagination: true, 
        rownumbers:true, 
        fitColumns:true, 
        singleSelect:true, 
        toolbar:toolbar,
        columns:[[
            {width:80, field:'ck', checkbox:true}, 
            {width:80, field:'infoTitle', title:"标题"}, 
            {width:80, field:'catagoryName', title:"所属分类"}, 
            {width:80, field:'insertTime', title:"录入时间"} 
        ]] , 
        onDblClickRow: function (i, r) {
            r_view = $.extend({},r); 
            for(var o in r ) {
                if(!r[o]) r[o] = '&nbsp;'
            }
            dlg_info.html(tp1(r)); 
            dlg3.dialog("open");
        }
    });
}); 

form1.submit(function (e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    var isValid = form1.form("validate");
    if (!isValid) { return; }
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
    var el = $(this).parents('td').find("input");
    uploadfile(el);
});


$(function () {
    dfd_datagrid.resolve(); 
});
