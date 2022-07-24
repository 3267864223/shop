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
		<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>角色权限管理 (当前角色:${roleName})</span></div>
		<div class="div_titleoper"><input type="checkbox" id="top_ch_checkall"/>全选</div>
	</div>
	
	<form action="RoleServlet.do">
	<input type="hidden" name="roleId" value="${roleId}">
	<input type="hidden" name="flag" value="updateRole">
	<table class="main_table">
		<tr>
			<th>一级菜单</th>
			<th>二级菜单</th>
		</tr>
		<c:forEach var="m" items="${menuList}">
			<tr>
				<td><input id="${m.id}" name="ids" value="${m.id}" type="checkbox" onclick="parentcheck(this)">${m.menuName}</td>
				<td>
					<c:forEach var="m_sub" items="${m.subMenuList}">
						<input name="ids" class="${m.id}" value="${m_sub.id}" type="checkbox" onclick="soncheck(${m.id})">${m_sub.menuName}<br>
					</c:forEach>
				</td>
			</tr>
		</c:forEach>
	</table>
	<br>
	<input id="submit" class="form_btn" type="submit" value="保存" style="margin-left:700px"/>
	<label id="result_msg" class="result_msg">${msg}</label>
	</form>
	
	<script>
		var str="${roleMenuIdStr}";
		var array=str.split(",");

		Array.prototype.contains=function(e){
			for(var i=0;i<this.length;i++){
				if(this[i]==e){
					return true;
				}
			}
			return false;	
		}
		
		$("input[name=ids]").each(function(){
			if(array.contains(this.value)){
				this.checked=true;
			}	
		});
		
		$("#top_ch_checkall").click(function(){
			if(this.checked){
				$("input[name=ids]").each(function(){
					this.checked=true;
				});
			}else{
				$("input[name=ids]").each(function(){
					this.checked=false;
				});
			}
		});
		
		//点击父级，儿级全选，  取消儿级，父级取消
		function parentcheck(menu){
			$("."+menu.id).attr("checked",menu.checked);
		}
		
		function soncheck(pid){
			$("#"+pid).removeAttr("checked");
   			
   			$("."+pid).each(function(){
   				if(this.checked){
   					$("#"+pid).attr("checked","checked");
   					return;
   				}
   			});
		}
		


	</script>
</body>
</html>