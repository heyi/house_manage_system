(function($) {
    var cache = [];
    //模板处理用到的方法
    var format = function(str, col) {
        return str.replace(/(?:{)(\w+?)(?:})/g, function(m, n) {
            return col[n] ? col[n] : "";
        });
    };
    //xhr 请求失败后默认处方法.
    var error_function = function() {
        alert("请求数据有误,请检查网络或联系系统管理员.");
    };
    $.fn.DataGrid = function(opts) {
        if (opts === undefined && this.length > 0) {
            return cache[this[0].id] ? cache[this[0].id] : null;
        }
        var tmp;
        for (var i = 0; i < this.length; i++) {
            tmp = new DataGrid(this[i], opts);
            if (this[i].id) cache[this[i].id] = tmp;
        }
        return this.length === 1 ? tmp: this;
    };
    var DataGrid = function(containerEl, opts) {
        if (typeof containerEl === "string" || containerEl instanceof String) {
            this.container = document.getElementById(containerEl);
        } else {
            this.container = containerEl;
        }
        this.el = $(this.container); 
        if (!this.container) {
            alert("Error finding container for DataGrid " + containerEl);
            return;
        }
        this.options = $.extend({}, DataGrid.prototype.options, opts); 
        this._init(); 
    };
    DataGrid.prototype = {
        options: {
            ajaxOpts: null,
            ajax_one_param: false,
            sidx : "", 
            data: null,
            sord : "asc", 
            page : 1, 
            rows : 10, 
            is_pagination: true, 
            pagechange : null,
            width: null, 
            title: "",
            is_sort_client: true,
            multiselect: true,
            model: [],
            root: "data",
            keyName: "pid",
            is_sort: false,  
            sequence: false,
            cellclick:null, 
            success: null, 
            rowclick: null
        },
        _init: function() {
            this._generate_html();
        },
        //私有方法,有根目录时取到正确的值.
        _getAccessor: function(obj, expr) {
            var ret, p, prm = [],
            i;
            if (typeof expr === 'function') {
                return expr(obj);
            }
            ret = obj[expr];
            if (ret === undefined) {
                try {
                    if (typeof expr === 'string') {
                        prm = expr.split('.');
                    }
                    i = prm.length;
                    if (i) {
                        ret = obj;
                        while (ret && i) {
                            p = prm.shift();
                            ret = ret[p];
                            i--; 
                        }
                    }
                } catch(e) {}
            }
            return ret;
        },
        update_title: function(title) {
            this.container.find("caption").text(title);
        },
        refresh: function(htmls) {
            var p = this.options; 
            var self = this;
            if (p.ajaxOpts) {
                var _success;
                if ($.isFunction(p.success)) {
                     _success = p.success.clone() ; 
                }
                if ($.isFunction(p.ajaxOpts["success"])) {
                     _success = p.ajaxOpts["success"].clone() ; 
                }
                if ($.isFunction(p.ajaxOpts["error"])) {
                    var _error = p.ajaxOpts["error"].clone(); 
                }

                p.ajaxOpts.success = function(response) {
                    if (!self.el.data("init")) {
                        htmls = htmls || [];
                        htmls.push("<tbody>");
                        htmls.push(self._get_process_data(response));
                        htmls.push("</tbody>");
                        $(self.container).append(htmls.join(""));

                        self.el.data("init", true); 
                    }else {
                        self.el.find("tbody").children().remove();
                        self.el.find("tbody").append(self._get_process_data(response));
                    }
                    if (_success  && $.isFunction(_success)) {
                        _success.call(self, response);  
                    }
                    if (p.is_pagination) {
                       self.dfd.resolve();  
                       var total = $(self.container).data("total");
                       var tt = p["total"];
                       if (!total) {
                           $(self.container).data("total",tt);
                       }
                       if (total !== tt) {
                           var start = p["page"];
                           self.page_bar.pagination("show",p["records"],start);
                           $(self.container).data("total",tt);
                       }
                    }
                    return this;
                };
                p.ajaxOpts.error = function() {
                    error_function.call(self);  
                    if (_error  && $.isFunction(_error)) {
                        _error.call(self) ;  
                    }
                    return this;
                };
                var data = (p.ajaxOpts || {})["data"] || {};
                if (p["ajax_one_param"] && $.type(data["data"]) == 'string') {
                   data = $.parseJSON(data["data"]); 
                }
                data["rows"] = p.rows;
                data["page"] = p.page;
                data["start"] = (p.page - 1) * p.rows;
                data["sidx"] = p.sidx;
                data["sord"] = p.sord;
                data["nb"] = new Date().getTime();
                p.ajaxOpts["data"] = p["ajax_one_param"] ? {data:JSON.stringify(data)} : data;

                $.ajax($.extend({},p.ajaxOpts));
            }else {
                if ($.type(p.data) === "array") {
                    if (!self.el.data("init")) {
                        htmls = htmls || [];
                        htmls.push("<tbody>");
                        htmls.push(self._get_process_data(p.data));
                        htmls.push("</tbody>");
                        $(self.container).append(htmls.join(""));

                        self.el.data("init", true); 
                    }else {
                        self.el.find("tbody").children().remove();
                        self.el.find("tbody").append(self._get_process_data(p.data));
                    }
                    if ($.isFunction(p["success"])) {
                       p["success"].call(self, p.data);  
                    }
                }
            }
        },
        reset : function () {
            var self = this;
            var p = this.options; 
            self.el.find("tbody").children().remove();
            self.dataset = {};
            self.sort_ds = [];
            if (p.is_pagination) {
                self.page_bar.pagination("show",0,1);
            }
        },
        _get_process_data: function(response) {
            var opts = this.options;
            var model = opts.model;
            var keyName = opts.keyName,
            htmls = [],
            rvalue = "";
            var self = this;
            var counter = 0;
            if (opts.is_pagination) {
                counter = (opts["page"] - 1) * opts["rows"]; 
            }

            self.dataset = {};
            self.sort_ds = [];
            var rs = response; 
            if ($.type(rs) === "string") {
                rs = $.parseJSON(response);
            }
            opts["records"] = rs["records"] || 0; 
            opts["total"] = rs["total"] || 0; 
            opts["page"] = rs["page"] || 1; 
            rs = opts.root ? this._getAccessor(rs, opts.root) : rs; 

            for (var i = 0; i < rs.length; i++) {
                var tr = rs[i];
                var key = tr[keyName];
                self.dataset[key] = tr;
                self.sort_ds.push(tr);
                htmls.push("<tr id='" + key + "'>");
                if (opts.sequence) {
                    counter++;
                    htmls.push("<td width=3%>" + counter + "</td>");
                }
                if (opts.multiselect) {
                    htmls.push("<td width=3%><input type='checkbox'></td>");
                }
                $.map(model, function(v, k) {
                    rvalue = tr[v["name"]];
                    if (v.rendered) {
                        var _rvalue = v.rendered.call(self, rvalue, tr);
                        htmls.push("<td class='rendered' val='" + rvalue + "'>" + _rvalue + "</td>");
                    } else {
                        htmls.push("<td>" + rvalue + "</td>");
                    }
                });
                htmls.push("</tr>");
            }
            return htmls.join("");
        },
        _sort : function(sort_type,sort_name,sort_dir,is_sort) {
            var p = this.options;
            var counter = 0;
            if (opts.is_pagination) {
                counter = (opts["page"] - 1) * opts["rows"]; 
            }
            if (!p.is_sort_client) {
                p.sidx = sort_name;
                p.sord = (sort_dir === "up" ? "asc" : "desc");
                this.refresh();
                return ;
            }
            var keyName = p.keyName,model = p.model;
            var ds = this.sort_ds;
            if (is_sort) {
                ds = ds.reverse(); 
            }else{
                ds = ds.sort(function(a,b) {
                    return convert(sort_type,a[sort_name]) - convert(sort_type,b[sort_name]); 
                });
            }
            this.sort_ds = ds,htmls = [];
            for (var i = 0; i < ds.length; i += 1) {
                var r = ds[i]   ;
                var key = r[keyName];
                htmls.push("<tr id='" + key + "'>");
                if (p.sequence) {
                    counter ++;
                    htmls.push("<td width=3%>"+counter+"</td>");
                }
                if (p.multiselect) {
                    htmls.push("<td width=3%><input type='checkbox'></td>");
                }
                $.map(model, function(v, k) {
                    rvalue = r[v["name"]] || "";
                    if (v.rendered) {
                        var _rvalue = v.rendered.call(self, rvalue, tr);
                        htmls.push("<td class='rendered' val='" + rvalue + "'>" + _rvalue + "</td>");
                    } else {
                        htmls.push("<td>" + rvalue + "</td>");
                    }
                });
                htmls.push("</tr>");
            }
            this.el.find("tbody").find("tr").remove().end().append(htmls.join(""));
        },
        _generate_html: function() {
            var self = this;
            var p = this.options;
            var model = p.model;
            var keyName = p.keyName;
            var title = p.title;
            var htmls = ["<thead><tr>"];
            var rvalue = "";
            if ( !! title) {
                htmls.unshift("<caption>" + title + "</caption>");
            }
            if (p.sequence) {
                htmls.push("<th width=3%></th>");
            }
            if (p.multiselect) {
                htmls.push("<th width=3%><input type='checkbox'></th>");
            }
            var _th = "<th >{text}</th>";
            var _sort_th = "<th  data-sorttype={sorttype} data-sortname={name}>{text}&nbsp;<i class='icon-sort'></i></th>"; 
            for (var i = 0; i < model.length; i++) {
                var col = model[i];
                if (col.sorttype) {
                    htmls.push(format(_sort_th, col));
                }else {
                    htmls.push(format(_th, col));
                }
            }
            htmls.push("</tr></thead>");

            if (p.ajaxOpts) {
                self.refresh(htmls); 
            }else {
                $(self.container).append(  htmls.join("") );
            }
            //事件处理
            self.el.click(function(e) {
                var nodeName = e.target.nodeName;
                var _target = $(e.target);

                if (p.is_sort) {
                    //排序处理
                    if (nodeName  === "TH") {
                        var sort_type = _target.data("sorttype");
                        var sort_name = _target.data("sortname");
                        if (!sort_name) {
                            return false;  
                        }
                        var sd = _target.data("sort_dir"), dir, is_sort = false;

                        var old_sort_name = self.el.data("sort_name"); 
                        if (old_sort_name  &&  old_sort_name  !== sort_name) {
                            self.el.data("sort_col").find("i").attr("class", "icon-sort");  
                        }
                        if (sd) {
                            dir = (sd == "up" ? "down" : "up");
                            _target.find("i").attr("class","icon-sort-" + dir); 
                            _target.data("sort_dir",dir);
                            is_sort = true;
                        }else{
                            _target.data("sort_dir","up");
                            _target.find("i").attr("class","icon-sort-up");
                            dir = "up";
                        }
                        self._sort(sort_type,sort_name,dir,is_sort);
                        self.el.data("sort_col", _target); 
                        self.el.data("sort_name", sort_name); 
                        return false; 
                    }
                }

                var tr = _target.parents("tr"); 
                var trs = self.el.find("tr", "tbody"); 
                if (nodeName !==  "TH" && _target.parent("th").length == 0 && !_target.is("[type=checkbox]")) {
                    //行点击事件处理.
                    var cls = _target.parents("td").attr("class");
                    var id = _target.parents("tr")[0].id;
                    var val = _target.text();
                    if (tr.length === 1 || cls === "rendered") {
                        if ($.isFunction(p.rowclick)) {
                            if (cls === "rendered") val = _target.parents("td").attr("val");
                            p.rowclick.call(_target, id, val, self.dataset[id],self);
                        }
                        if (_target.is(".action") || _target.is("a")) {
                            if ($.isFunction(p.cellclick)) {
                                if (cls === "rendered") val = _target.parents("td").attr("val");
                                p.cellclick.call(_target, id, val, self.dataset[id],self);
                            }
                        }

                        trs.removeClass("error"); 
                        trs.find("[type=checkbox]", "td:first-child").prop("checked",false);
                        tr.addClass("error");
                        tr.find("[type=checkbox]", "td:first-child").prop("checked",true);
                    }
                }

                if (_target.is("[type=checkbox]") && _target.parent().is("td:first-child")) {
                    if (_target.prop("checked")) {
                        tr.addClass("error");  
                    }else {
                        tr.removeClass("error"); 
                    }
                }

                if (_target.is("[type=checkbox]")  && _target.parent().is("th:first-child")) {
                    if (_target.prop("checked")) {
                        trs.addClass("error");  
                    }else {
                        trs.removeClass("error"); 
                    }
                    var chks = trs.find("[type=checkbox]", "td:first-child"); 
                    chks.prop("checked", chks.prop("checked")); 
                }
            });

            if (p.width) {
                self.el.width(p.width); 
            }
            //初始化分页条.
            if (p.is_pagination) {
                self.dfd = $.Deferred(); 
                self.dfd.done(function () {
                    var page_bar_id = self.el.attr("id") + "_pagination";  
                    var page_bar = $("#" + page_bar_id).pagination({
                        onChange:function (page) { p["page"] = page; self.refresh(); if($.isFunction(p.pagechange)){
                            p.pagechange.call(self,page);
                        } },
                        pageRows : p["rows"],
                        total: p["records"]
                    }); 
                    page_bar.pagination("show");
                    self.page_bar = page_bar;
                });
            }
            return true;
        }
    };
    function convert(sort_type,sValue) {
        switch (sort_type) {  
            case "int":  
                return parseInt(sValue);  
            case "float":  
                return parseFloat(sValue);  
            case "date":  
                return new Date(Date.parse(sValue));  
            default:  
                return sValue.toString();  
        }  
    }
}(jQuery));

!function( $ ){

    "use strict"

    /* MODAL CLASS DEFINITION
     * ====================== */
    var cls = ["first", "last", "prev", "next"]; 
    var Pagination = function ( content, options ) {
        var that = this;
        this.options = options;
        this.$element = $(content).addClass('pagination').empty();
        var list = $('<ul/>').appendTo(this.$element);
        var btnPrev = this.btnPrev = $('<li class="prev p"><a href="#">' + this.options.prev + '</a></li>');
        var btnNext = this.btnNext = $('<li class="next p"><a href="#">'+this.options.next+'</a></li>');

        var btnFirst = this.btnFirst = $('<li class="first p"><a href="#">' + this.options.first + '</a></li>');
        var btnLast = this.btnLast = $('<li class="last p"><a href="#">'+this.options.last+'</a></li>');
        list.append(btnFirst).append(btnPrev).append(btnNext).append(btnLast);

        this.$element.on('click','li:enabled, li', function(e){
            e.preventDefault();
            var $this = $(this);
            if ($this.is(".disabled") || $this.is(".active")) {
                return false; 
            }
            var list = that.$element.find('ul');
            if ($this.hasClass('prev')){
                that.currentPage = parseInt(list.find('li.active a').text()) - 1; 

            }else if($this.hasClass('next')){
                that.currentPage = parseInt(list.find('li.active a').text()) + 1; 
            }else if($this.hasClass("first")){
                that.currentPage = 1; 
            }else if($this.hasClass("last"))
                that.currentPage = that.totalPages; 
            else{
                that.currentPage = parseInt($this.text());
            }
            that.load(--that.currentPage); 
        });
    }

    Pagination.prototype = {

        constructor: Pagination
        , show: function(total, start){
            if (total != null) {
                this.options.total = total   
            }
            if (start != null) {
                this.options.start = start;
            }
            this.currentPage = this.options.start - 1;
            this.totalPages = parseInt(this.options.total / this.options.pageRows);
            if (this.options.total % this.options.pageRows > 0) this.totalPages++;
            navigate.call(this, this.currentPage);
            if (this.options.initLoad){
                this.load(this.currentPage);
            }
        }
        , load: function (page){
            navigate.call(this, page);
            if (this.options.onChange) {
                this.options.onChange((this.currentPage + 1));
            }
        }
    }

    /* MODAL PRIVATE METHODS
     * ===================== */

    function _buildNavigation(startPage) {
        var s = this.options;
        var self = this;
        var list = this.$element.find('ul');
        if (s.total <= s.pageRows) return;
        var target = list.find('li.next');
        var htmls = []; 
        for (var i = startPage; i < startPage + s.length; i++) {
            if (i == this.totalPages) break;
            htmls.push("<li><a href='#' rel="+(i+1)+">" + (i+1) + "</a></li>"); 
        }
        $(htmls.join("")).insertBefore(target); 
    }

    function navigate(topage) {
        var s = this.options;
        var list = this.$element.find('ul');
        list.find("li").not(".p").remove();         
        var index = topage;
        var mid = s.length / 2;
        if (s.length % 2 > 0) mid = (s.length + 1) / 2;
        var startIndex = 0;
        if (topage >= 0 && topage < this.totalPages) {
            if (topage >= mid) {
                if (this.totalPages - topage > mid)
                    startIndex = topage - (mid - 1);
                else if (this.totalPages > s.length)
                    startIndex = this.totalPages - s.length;
            }
            _buildNavigation.call(this, startIndex); 
            list.find('li').removeClass('active');
            list.find('li a[rel='+(index+1)+']').parent().addClass('active');
        }
        _showRequiredButtons.call(this);
    }

    function _showRequiredButtons() {
        var s = this.options;
        if (this.totalPages > 1) {
            if (this.currentPage > 0){ 
                this.btnPrev.removeClass('disabled'); 
                this.btnFirst.removeClass('disabled'); 
            }
            else{ 
                this.btnPrev.addClass('disabled'); 
                this.btnFirst.addClass('disabled'); 
            }

            if (this.currentPage == this.totalPages - 1){
                this.btnNext.addClass('disabled'); 
                this.btnLast.addClass('disabled'); 
            }
            else{ 
                this.btnNext.removeClass('disabled');
                this.btnLast.removeClass('disabled');
            }
        }
        else {
            this.btnPrev.addClass('disabled');
            this.btnNext.addClass('disabled');
            this.btnFirst.addClass('disabled');
            this.btnLast.addClass('disabled');
        }
    }


    /* MODAL PLUGIN DEFINITION
     * ======================= */

    $.fn.pagination = function (option) {
        var args = Array.prototype.slice.call(arguments);
        args.shift();
        return this.each(function () {
            var $this = $(this)
            , data = $this.data('pagination')
            , options = $.extend({}, $.fn.pagination.defaults, typeof option == 'object' && option);
            if (!data) $this.data('pagination', (data = new Pagination(this, options)));
            if (typeof option == 'string') data[option].apply(data, args);
        })
    }

    $.fn.pagination.defaults = {
        total: 0,
        pageRows: 10,
        length: 10,
        next: '下一页',
        prev: '上一页',
        first: '首页',
        last: '尾页',
        start: 1,
        initLoad: false,
        onChange: null
    }

    $.fn.pagination.Constructor = Pagination;

}( window.jQuery );

