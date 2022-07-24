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
		 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>当前用户信息</span></div>
	</div>
	 <table class="edit_table" >
 		<tr>
		 	<td class="td_info">用户账号:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="adminName" name="adminName" value="${session_admin.adminName}"/> 
		 	</td>   
		 	<td>
		 		<label class="validate_info" id="adminName_msg"></label>
		 	</td> 
 		</tr>
		<tr>
			<td class="td_info">用户密码:</td>	
			<td>
				<input readonly="readonly" type="text"  class="txtbox"  name="password"  id="password" value="******" />
			</td> 
			<td><label  class="validate_info" id="password_msg" ></label></td>	
 		</tr>

 		<tr>
 			<td class="td_info">备注信息:</td>	
 			<td>
				<input readonly="readonly" type="text"  class="txtbox"  name="note"  id="note"  value="${session_admin.note}"/>
			</td> 
			<td><label  class="validate_info" id="note_msg" ></label></td>
 		</tr>
 		<tr>
 			<td class="td_info">最后更新日期:</td>	
 			<td>
				<input readonly="readonly" type="text"  class="txtbox"  name="editDate"  id="editDate"  value="${session_admin.editDate}"/>
			</td> 
			<td><label  class="validate_info" id="editDate_msg" ></label></td>
 		</tr>
 		
	</table>
</body>
</html>