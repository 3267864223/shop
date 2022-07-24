<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title></title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
	<script src="js/jquery-1.8.0.js"></script>
 	<link rel="stylesheet" type="text/css" href="css/login.css" ></link>
 	<script>
  		$(function(){
  			$("#btn_img").click(function(){
  				$.ajax({
  					url:"LoginServlet?flag=login",
  					data:{adminName:$("#adminName").val(),password:$("#password").val()},
  					success:function(state){
  						if(state=="1"){
  							alert("登录成功");
  							window.location.href="main.html";
  						}else if(state=="2"){
  							alert("用户已锁定，无法登录，请联系管理员");
  						}else{
  							alert("账号或密码错误，请重试");
  						}
  					}
  				})
  			});
  		});
  	</script>
</head>

<body>
	<div id="div_center">
	<div id="div_inputbox">
		<input type="text" id="adminName" value="g" />
		<input type="password" id="password" />
	</div>
	<input id="btn_img" type="image" src="images/bg_login_button.jpg" />
</div>
</body>
</html>