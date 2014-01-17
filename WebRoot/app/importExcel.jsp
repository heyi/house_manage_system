<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>从EXCEL导入数据</title>
</head>
<script>
window.onload = function(){
	var myObj = window.dialogArguments;
	//alert("importExcel.do?excelType=" + myObj.excelType + "&houseType=" + myObj.houseType + "&dealType=" + myObj.dealType);
	var form = document.getElementById("form1");
	form.action = "importExcel.do?excelType=" + myObj.excelType + "&houseType=" + myObj.houseType + "&dealType=" + myObj.dealType;
}
</script>
<body>
	<form id="form1" name="form1" method="post"	enctype="multipart/form-data" target="upload_target">
		<input type="file" name="imgUrl"><br> <input
			type="submit" value="上传并导入">
	</form>
	<iframe width="0" height="0" id="upload_target" src="#" name="upload_target"></iframe>
</body>
</html>