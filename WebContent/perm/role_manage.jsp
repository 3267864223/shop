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
</head>

<body>
	<div class ="div_title">
		<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>系统中的角色列表</span></div>
	</div>
	<table class="main_table">
		<tr>
			<th>角色名称</th>
			<th>角色描述</th>
			<th>操作</th>
		</tr>
		<c:forEach var="r" items="${roleList}">
			<tr>
				<td>${r.roleName }</td>
				<td>${r.des }</td>
				<td><a href="RoleServlet.do?flag=toUpdate&roleId=${r.id}&roleName=${r.roleName}&des=${r.des}">修改</a><a href="javascript:del('${r.id}')">删除</a><a href="RoleServlet.do?flag=roleAllot&roleId=${r.id}&roleName=${r.roleName}">角色权限分配</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
<script>
	//删除
	function del(roleId){
		var result=true;
		result=confirm("确认删除吗？");
		if(result==true){
			$.ajax({
				type:"post",
				url:"RoleServlet.do",
			    data:{flag:"delete",roleId:roleId},
			    async:false,
			    success:function(data){
			    	if(data==0){
			    		alert("当前角色还有用户绑定，删除失败");
			    	}else {
			    		alert("删除成功");
			    		window.location.href="RoleServlet.do?flag=manage";
			    	}
			    	
			    }
			});
		}
	}
</script>
</html>