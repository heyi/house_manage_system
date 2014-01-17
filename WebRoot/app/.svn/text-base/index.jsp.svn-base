<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>房地产信息管理系统</title>
<link href="common.css" rel="stylesheet" type="text/css" />
<script src="<c:url value="/resources/js/jquery.js"/>" type="text/javascript" charset="utf-8"></script> 

<style>
BODY,DIV,FORM,UL,OL,LI,DL,DT,DD,H1,H2,H3,H4,H5,H6,H7{PADDING:0; MARGIN: 0px; border:0;FONT-SIZE: 12px;font-family:微软雅黑,Arial, Helvetica, sans-serif; line-height:160%; color:#333}
body{background: url(images/back.jpg) center top no-repeat #5a5d91; text-align:center}
.metro{width: 840px;height: 560px; background: url(images/m.png) center top no-repeat; margin:auto; position: relative;}
.metro a{ width: 140px;height: 50px; padding-top: 90px; display: block; font-size: 18px;color: #fff; position: absolute; background: url(images/i.png) -0px -0px no-repeat;}

.metro a:hover{ color:#CF6}
#a1{ left: 560px;top: 140px; background-position: -560px -140px;}
#a2{ left: 140px;top: 280px; background-position: -140px -280px;}
#a3{ left: 280px;top: 280px; background-position: -280px -280px;}

#a4{ left: 560px;top: 280px; background-position: -560px -280px;}
#a5{ left: 700px;top: 280px; background-position: -700px -280px;}
#a6{ left: 280px;top: 420px; background-position: -280px -420px;}
#a7{ left: 560px;top: 420px; background-position: -560px -420px;}

#a1:hover{ left: 560px;top: 140px; background-position: -560px -142px;}
#a2:hover{ left: 140px;top: 280px; background-position: -140px -282px;}
#a3:hover{ left: 280px;top: 280px; background-position: -280px -282px;}
#a4:hover{ left: 560px;top: 280px; background-position: -560px -282px;}
#a5:hover{ left: 700px;top: 280px; background-position: -700px -282px;}
#a6:hover{ left: 280px;top: 420px; background-position: -280px -422px;}

#a7{ left: 560px;top: 420px; background-position: -560px -420px;}

h1{ position: absolute; right: 300px;top: 140px; }
.time{ position: absolute; left: 350px;top: 29px; }
.time div{color: #fff; font-size: 18px; text-align:left; font-weight: bold;}
.day{position: absolute; left: 220px;top: 18px; font-size: 100px;color: #fff; height: 100px; line-height: 100px; }
</style>

<script>
window.onload = function(){
	var d_date = $("#d_date"),d_day = $("#d_day"),d_month = $("#d_month"),d_year = $("#d_year");
	var week = "日,一,二,三,四,五,六".split(',');
	
	var d = new Date();
	d_date.text("星期" + week[d.getDay()]);
	d_year.text(d.getFullYear());
	d_month.text(d.getMonth()+1 + "月");
	d_day.text(d.getDate());
}
</script>
</head>


<body>
<div class="metro">
	<div class="time">
    	<div id="d_year" class="year"></div>
    	<div id="d_month" class="month"></div>
    	<div id="d_date" class="week"></div>
    </div>
    <div id="d_day" class="day"></div>
    <h1><img src="images/tit.png" alt=""></h1>
    <a href="parcel.jsp" id="a1">土地案例</a>
    <a href="storeforsale.jsp" id="a2">房地产案例</a>
    <a href="law2.jsp" id="a3">政策法规</a>
    <a href="javascript:alert('正在建设中')" id="a4">统计分析</a>
    <a href="market2.jsp" id="a5">市场分析</a>
    <a href="stand2.jsp" id="a6">标准化模板</a>
    <a href="system.jsp" id="a7">系统管理</a>
</div>


                    
</body>
</html>
