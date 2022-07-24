<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    
	<script type="text/javascript" src="js/jquery-1.8.0.js"></script> 
	<script type="text/javascript">
		$(function(){
			$("#ch_checkall,#top_ch_checkall").click(function(){
				if(this.checked){
					$("input[name=ck_id]").attr("checked","checked");
				}else{
					$("input[name=ck_id]").removeAttr("checked");
				}		
			});
					
			$("table tr").mouseover(function(){
				$(this).css("background","#D3EAEF");
				$(this).siblings().css("background","white");
			});
		});
	</script>

	<link rel="stylesheet" type="text/css" href="css/maintable.css" ></link>
		<link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>  
	<link rel="stylesheet" type="text/css" href="css/validate.css"  ></link> 
</head>

<body>
	<div class ="div_title">
		<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>管理员角色分配</span></div>
	</div>
	<form action="RoleServlet.do" method="post" >
	<input type="hidden" name="flag" value="updateRole2">
	<input type="hidden" name="adminId" value="${adminId}">
	 <table class="edit_table" >
		<tr>
		 	<td class="td_info">用户账号:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="adminName" name="adminName" value="${adminName}" /> 
		 	</td><td></td>  
		</tr>
		<tr>
			<td class="td_info">用户角色:</td>	
			<td>
				<c:forEach var="r" items="${roleList}">
					<input type="radio" id="roleId" name="roleId" value="${r.id}" <c:if test="${roleId eq r.id}">checked</c:if> >&nbsp${r.roleName}<br>
				</c:forEach>
			</td><td></td>    
		</tr>
		<tr>
			<td class="td_info"> </td>	
			<td> 
			<input id="tj" class="form_btn" type="submit"  value="提交" /> 
			<input id="back" class="form_btn" type="button" value="返回" /></td>	
			<td>
				<label id="result_msg" class="result_msg">${msg}</label>
			</td>	
		</tr>
	</table>
	</form>
	<div></div>
</body>

<script>
	$("#back").click(function(){
		window.location.href="RoleServlet.do?flag=listadmin";
	});
</script>
</html>