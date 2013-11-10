var JSON;JSON||(JSON={});
(function(){function k(a){return a<10?"0"+a:a}function o(a){p.lastIndex=0;return p.test(a)?'"'+a.replace(p,function(a){var c=r[a];return typeof c==="string"?c:"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+a+'"'}function l(a,j){var c,d,h,m,g=e,f,b=j[a];b&&typeof b==="object"&&typeof b.toJSON==="function"&&(b=b.toJSON(a));typeof i==="function"&&(b=i.call(j,a,b));switch(typeof b){case "string":return o(b);case "number":return isFinite(b)?String(b):"null";case "boolean":case "null":return String(b);case "object":if(!b)return"null";
e+=n;f=[];if(Object.prototype.toString.apply(b)==="[object Array]"){m=b.length;for(c=0;c<m;c+=1)f[c]=l(c,b)||"null";h=f.length===0?"[]":e?"[\n"+e+f.join(",\n"+e)+"\n"+g+"]":"["+f.join(",")+"]";e=g;return h}if(i&&typeof i==="object"){m=i.length;for(c=0;c<m;c+=1)typeof i[c]==="string"&&(d=i[c],(h=l(d,b))&&f.push(o(d)+(e?": ":":")+h))}else for(d in b)Object.prototype.hasOwnProperty.call(b,d)&&(h=l(d,b))&&f.push(o(d)+(e?": ":":")+h);h=f.length===0?"{}":e?"{\n"+e+f.join(",\n"+e)+"\n"+g+"}":"{"+f.join(",")+
"}";e=g;return h}}if(typeof Date.prototype.toJSON!=="function")Date.prototype.toJSON=function(){return isFinite(this.valueOf())?this.getUTCFullYear()+"-"+k(this.getUTCMonth()+1)+"-"+k(this.getUTCDate())+"T"+k(this.getUTCHours())+":"+k(this.getUTCMinutes())+":"+k(this.getUTCSeconds())+"Z":null},String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(){return this.valueOf()};var q=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
p=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,e,n,r={"\u0008":"\\b","\t":"\\t","\n":"\\n","\u000c":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"},i;if(typeof JSON.stringify!=="function")JSON.stringify=function(a,j,c){var d;n=e="";if(typeof c==="number")for(d=0;d<c;d+=1)n+=" ";else typeof c==="string"&&(n=c);if((i=j)&&typeof j!=="function"&&(typeof j!=="object"||typeof j.length!=="number"))throw Error("JSON.stringify");return l("",
{"":a})};if(typeof JSON.parse!=="function")JSON.parse=function(a,e){function c(a,d){var g,f,b=a[d];if(b&&typeof b==="object")for(g in b)Object.prototype.hasOwnProperty.call(b,g)&&(f=c(b,g),f!==void 0?b[g]=f:delete b[g]);return e.call(a,d,b)}var d,a=String(a);q.lastIndex=0;q.test(a)&&(a=a.replace(q,function(a){return"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)}));if(/^[\],:{}\s]*$/.test(a.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,
"]").replace(/(?:^|:|,)(?:\s*\[)+/g,"")))return d=eval("("+a+")"),typeof e==="function"?c({"":d},""):d;throw new SyntaxError("JSON.parse");}})();

var rselectTextarea = /^(?:select|textarea)/i;
var	l_rinput = /^(?:color|date|datetime|datetime-local|email|hidden|month|number|password|range|search|tel|text|time|url|week|textarea)$/i;
var rCRLF = /\r?\n/g;

var _template_re = /(?:{)(\w+?)(?:})/g;
var format = function(str, col) {
    return str.replace(_template_re, function(m, n) {
        return (col[n] || col[n]  == 0) ? col[n] : "";
    });
};

$.fn.serializeJson  = function() {
    // don't do anything if we didn't get any elements
    if ( this.length < 1) { 
        return false; 
    }

    var data = {};
    var lookup = data; //current reference of data
    var selector = ':input[type!="checkbox"][type!="radio"], input:checked';
    var parse = function() {
        // data[a][b] becomes [ data, a, b ]
        var named = (this.name || "").replace(/\[([^\]]+)?\]/g, ',$1').split(',');
        var type = $(this).data("type"); 
        var cap = named.length - 1;
        var $el = $( this );

        // Ensure that only elements with valid `name` properties will be serialized
        if ( named[ 0 ] ) {
            for ( var i = 0; i < cap; i++ ) {
                // move down the tree - create objects or array if necessary
                lookup = lookup[ named[i] ] = lookup[ named[i] ] ||
                    ( named[ i + 1 ] === "" ? [] : {} );
            }

            // at the end, push or assign the value
            if ( lookup.length !==  undefined ) {
                lookup.push( $el.val() );
            }else {
                var _v = $el.val(); 
                lookup[ named[ cap ] ]  = ((type == "number" && (_v || _v  == '0')) ? parseFloat( _v, 10) : _v);
            }

            // assign the reference back to root
            lookup = data;
        }
    };

    // first, check for elements passed into this function
    this.filter( selector ).each( parse );

    // then parse possible child elements
    this.find( selector ).each( parse );

    // return data
    return data;
};

$.fn.serializeDisabled = function () {
    var obj = {};
    $(':disabled[name]', this).each(function () { 
        obj[this.name] = $(this).val(); 
    });
    return $.param(obj);
};

$.fn.serializeAll = function(){
    $this = $(this);
    return $this.serialize() + '&' + $this.serializeDisabled();
};

if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (searchElement /*, fromIndex */ ) {
        "use strict";
        if (this == null) {
            throw new TypeError();
        }
        var t = Object(this);
        var len = t.length >>> 0;
        if (len === 0) {
            return -1;
        }
        var n = 0;
        if (arguments.length > 1) {
            n = Number(arguments[1]);
            if (n != n) { // shortcut for verifying if it's NaN
                n = 0;
            } else if (n != 0 && n != Infinity && n != -Infinity) {
                n = (n > 0 || -1) * Math.floor(Math.abs(n));
            }
        }
        if (n >= len) {
            return -1;
        }
        var k = n >= 0 ? n : Math.max(len - Math.abs(n), 0);
        for (; k < len; k++) {
            if (k in t && t[k] === searchElement) {
                return k;
            }
        }
        return -1;
    }
}

function bindData(form,rs) {
    form.map(function() {
        return this.elements ? jQuery.makeArray(this.elements) : this;
    }).filter(function() {
        if (rs[this.name] === 0) {
           return true; 
        }
        return (rs[this.name] && this.type != "file");
    }).each(function(i, elem) {
        var name = this.name;
        var val = rs[this.name];
        var type = this.type;
        if (type === "radio" && this.value == val) {
            $(this).attr("checked", true);
        }
        if ("checkbox" === type) {
            if (val == 1) {
                $(this).attr("checked", true);
            }else{
            	$(this).attr("checked", false);
            }
        }
        $(this).val(val);
    });
};

var get_request = (function() {
    var objs = {};
    var str = location.search ? location.search : location.hash;
    str.replace(/(\w+)(?:=)([^&]+)/gi, function($1, $2, $3) {
        objs[$2] = $3;
    });
    return function() {
        var arg = arguments;
        return arg[0] ? objs[arg[0]] : objs;
    };
})();

function error_func() {
    alert("请求数据有误,请检查网络或联系系统管理员.");
    $(".btn-success").button("reset");
}

$(function () {
    // if ($.browser.msie && $.type($.prototype.datepicker) == "function") {
    //     $("input[type=date]","body").datepicker({}); 
    // }   
    if ($.browser.msie && $.browser.version < 9) {
        $(".modal .table td:nth-child(odd)").css("text-align","right"); 
    }
    (function () {
        var m_ds = {
            real_time: [], 
            sys: [
                {a:'sys',b:'irrgation_area',c:'灌区维护'},
                {a:'sys',b:'water',c:'水源地维护'},
                {a:'sys',b:'flux',c:'水位流量维护'},
                {a:'sys',b:'sluice_flux',c:'闸位流量维护'},
                {a:'sys',b:'capacity',c:'库容维护'},
                {a:'sys',b:'canal',c:'渠系维护'},
                {a:'sys',b:'institution',c:'管理机构维护'},
                {a:'sys',b:'station',c:'站点配置'},
                {a:'sys',b:'video',c:'视频监控配置'},
                {a:'sys',b:'user',c:'用户管理'}
            ], 
            reports: [
                /*{a:'reports',b:'water',c:'水情监测汇总'},*/
                /*{a:'reports',b:'rainfall',c:'雨情监测汇总'},*/
                /*{a:'reports',b:'sluice',c:'闸门监测汇总'},*/
                {a:'reports',b:'history',c:'历史数据汇总'},
                {a:'reports',b:'telecontrol',c:'历史遥控汇总'},
                {a:'reports',b:'alarm',c:'历史报警汇总'}, 
                {a:'reports',b:'sms',c:'历史短信汇总'}
                /*{a:'reports',b:'#',c:'站所汇总'}*/
            ], 
            district:[
               {a:'district',b:'district',c:'基本信息'},
               {a:'district',b:'#',c:'组织机构'},
               {a:'district',b:'#',c:'建筑物'},
               {a:'district',b:'#',c:'用水协会'}
            ],
            gis : [],
            warning : [
                {a:"warning",b:"recipient_manage",c:'接收人管理'},
                {a:"warning",b:"alarm_set",c:'短信配置'}
            ],
            remote_monitor : []
        };
        var model = get_request("model"),sys_menu = $("#sys_menu"),htmls = [];
        var li_template = '<li > <a href="../{a}/{b}{d}?model={e}">{c}</a> </li>';
        var ds = m_ds[model];
        if (ds) {
            if (ds.length == 0) {
               sys_menu.parents(".navbar").hide(); 
               $(".main_body").css("top",63);
               return ;
            }
            for (var i = 0; i <ds.length; i += 1) {
                var r = ds[i];
                if (r["b"] == "#") {
                	htmls.push("<li > <a href=\"javascript:alert('本功能模块正在建设中！')\">"+r["c"]+"</a> </li>");
                }else {
                    r["e"] = model;
                    r["d"] = ".jsp";
                    htmls.push(format(li_template,r));
                }
            }
            sys_menu.append(htmls.join(""));
        }
    }());
});

function form_validate(c_mes) {
    var msg = [], ol = $("#validate_info"), _id = [];
    var self = this; 
    $(this).find("input").each(function (i,el) {
        var v = this.value, t = $(this).data("type"), required = $(this).data("required"), pattern = $(this).data("pattern"); 
        var length = $(this).data("length"),length_between = $(this).data("length_between");
        var lblname = $(this).parent().prev().text().replace(":",""); 
        if (!lblname) {
            lblname = $(this).data("label");  
        }
        lblname = "[" + lblname + "]";
        if (v) {
            if (t) {
                if (t == "number") {
                    if (!/^\d+?(\.\d+)?$/.test(v)) {
                        msg.push(lblname + "必须是数字!");  
                        _id.push(this.name); 
                    }
                    var max = $(this).data("max");
                    if (max  &&  v > max) {
                        msg.push(lblname + "必须小于" + max + "!");  
                        _id.push(this.name); 
                    }
                    var min = $(this).data("min");
                    if (min  &&  v < min) {
                        msg.push(lblname + "必须大于" + min + "!");  
                        _id.push(this.name); 
                    }
                }
            }
            if (length && ("" + v).length !== length ) {
                msg.push(lblname + "长度必须等于" + length + "!");  
                _id.push(this.name); 
            }
            if (length_between) {
                var l = length_between.split(","); 
                var lt = ("" + v).length;
                if (lt < l[0] || lt > l[1]) {
                    msg.push(lblname+ "长度必须是" + l[0] + "--" + l[1] + "位!"); 
                    _id.push(this.name); 
                }
            }
            if (pattern) {
                var patt = new RegExp(pattern,"i");
                if (!patt.test(v)) {
                    msg.push(lblname+ "格式不正确!"); 
                    _id.push(this.name); 
                }
            }
        }else {
            if (required) {
                msg.push(lblname+ "不能为空!"); 
                _id.push(this.name); 
            }
        }
    });
    if ($.type(c_mes) == "array") {
        for (var i = 0; i <c_mes.length; i += 1) {
            var c = c_mes[i];
            msg.push(c);
        }
    }
    if (msg.length > 0 ) {
        alert(msg.join("\n"));
        $(self).find("[name=" + _id[0] +"]").focus(); 
        return false; 
    }
    return true; 
};

$.ajaxSetup({
    contentType: "application/x-www-form-urlencoded; charset=utf-8",
    beforeSend: function () {
        $("#ajax_loading").show(); 
    },
    complete: function () {
        setTimeout(function () {
            $("#ajax_loading").hide(); 
        },100);
    }
});

function format_date (date){
    var date = date; 
    if (!date) {
        date = new  Date(); 
    }
    var d = date.getDate();
    var m = date.getMonth()+1;
    var y = date.getFullYear();
    return '' + y +'-'+ (m<=9?'0'+m:m) +'-'+ (d<=9?'0'+d:d);
}

function format_datetime (date,flag){
    var date = date; 
    if (!date) {
        date = new  Date(); 
    }
    var d = date.getDate();
    var m = date.getMonth()+1;
    var y = date.getFullYear();
    var h = date.getHours();
    var min = date.getMinutes();
    var s = date.getSeconds();
    var _date = '' + y +'-'+ (m<=9?'0'+m:m) +'-'+ (d<=9?'0'+d:d);
    return flag ? (_date + " 00:00:00") : (_date + " " + (h<=9?'0'+h:h) + ":" +(min<=9?'0'+min:min) +":" +(s<=9?'0'+s:s) ) 
}

function doprint(id_str){
    var el = document.getElementById(id_str);
    var iframe = (/MSIE (6|7|8)/).test(navigator.userAgent) ? 
        document.createElement('<iframe name="test_report">'):
        document.createElement('iframe');
    iframe.name = "test_report";
    var doc = null;
    iframe.setAttribute('style', 'position:absolute;width:0px;height:0px;left:-500px;top:-500px;');
    document.body.appendChild(iframe);

    var cssLink = document.createElement("link") 
    cssLink.href = "../../resources/css/print.css"; 
    cssLink .rel = "stylesheet";
    cssLink .type = "text/css"; 
    cssLink.media = "print";

    var a = setInterval( function(){
        try{
            doc = iframe.contentWindow.document;
            doc.body.appendChild(cssLink);
            $(doc.body).append(el.innerHTML).prop("id","simple");
            doc.close();
            iframe.contentWindow.focus();
            iframe.contentWindow.print();
            if (navigator.userAgent.indexOf("MSIE") > 0) { document.body.removeChild(iframe); }
            clearInterval(a);
        }
        catch(e){}
    }, 10 );
}

function numAdd(num1, num2) {
	return (num1 * 10000 + num2 * 10000) / 10000;
};
$.fn.modal.defaults["keyboard"] = false; 
$.fn.modal.defaults["backdrop"] = "static"; 

Function.prototype.clone = function() {
    var cloneObj = this;
    if(this.__isClone) {
      cloneObj = this.__clonedFrom;
    }

    var temp = function() { return cloneObj.apply(this, arguments); };
    for(var key in this) {
        temp[key] = this[key];
    }

    temp.__isClone = true;
    temp.__clonedFrom = cloneObj;

    return temp;
};

