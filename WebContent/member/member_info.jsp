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
	<link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>  
	<link rel="stylesheet" type="text/css" href="css/validate.css"  ></link>  
	<script type="text/javascript"  src="js/jquery-1.8.0.js"></script>
	<style>
		input{
			color:red;
		}
	</style>
</head>

<body>
	<div class ="div_title">
		 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>会员信息</span></div>
	</div>
	<table class="edit_table" >
 		<tr>
		 	<td class="td_info">会员账号:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="memberNo" name="memberNo" value="${member.memberNo}"/> 
		 	</td>   
		 	<td class="td_info">会员姓名:</td>
			<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="memberName" name="memberName" value="${member.memberName}"/> 
		 	</td> 
 		</tr>
 		
 		<tr>
		 	<td class="td_info">联系电话:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="phone" name="phone" value="${member.phone}"/> 
		 	</td>   
		 	<td class="td_info">电子邮箱:</td>
			<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="email" name="email" value="${member.email}"/> 
		 	</td> 
 		</tr>
		
		<tr>
		 	<td class="td_info">注册日期:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="registerDate" name="registerDate" value="${member.registerDate}"/> 
		 	</td>   
		 	<td class="td_info">身份证号:</td>
			<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="idCard" name="idCard" value="${member.idCard}"/> 
		 	</td> 
 		</tr>
 		
 		<tr>
		 	<td class="td_info">登录次数:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="loginCounts" name="loginCounts" value="${member.loginCounts}"/> 
		 	</td>   
		 	<td class="td_info">最后登录时间:</td>
			<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="lastLoginDate" name="lastLoginDate" value="${member.lastLoginDate}"/> 
		 	</td> 
 		</tr>
 		
		<tr>
		 	<td class="td_info">会员常用ip:</td>	
		 	<td class="td_input_short" id="iptd"> 
		 	</td>   
		 	<td class="td_info">会员等级:</td>
			<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="memberLevel" name="memberLevel" value="${member.memberLevel}"/> 
		 	</td> 
 		</tr>
		<tr>
 			<td></td>
 			<td class="td_input_short"> 
		 		<input id="back" class="form_btn" type="button" value="返回" />
		 	</td> <td></td>
 		</tr>
 		
	</table>
</body>
<script>
	var str="${member.ip}";
	var arrip=str.split(",");
	for(var i=0;i<arrip.length;i++){
		var ipinput="<input readonly='readonly' class='txtbox' id='ip"+(i+1)+"' name='ip"+(i+1)+"' value='"+arrip[i]+"'><br>"; 
		$("#iptd").append(ipinput);
	}
	$("#back").click(function(){
		window.location.href="MemberServlet.do?flag=manage";
	});

</script>
</html>