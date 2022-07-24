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
		<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>管理员基本信息列表</span></div>
	</div>
	<form action="RoleServlet.do?flag=listadmin" method="post" name="form">
	<table class="main_table">
		<tr>
			<th>账号</th>
			<th>状态</th>
			<th>用户角色</th>
			<th>最后更新日期</th>
			<th>操作</th>
		</tr>
		<c:forEach var="a" items="${adminList}">
			<tr>
				<td>${a.adminName }</td>
				<td>
					<c:choose>
						<c:when test="${a.state eq 1}">
						</c:when>
						<c:otherwise>
							已锁定
						</c:otherwise>
					</c:choose>
				</td>
				<td>${a.roleName }</td>
				<td>${a.editDate }</td>
				<td><a href="RoleServlet.do?flag=roleAllot2&adminId=${a.id}&adminName=${a.adminName}&roleId=${a.roleId}">角色分配</a></td>
			</tr>
		</c:forEach>
	</table>
	<div class="div_page">
			<div class="div_page_left">
				共有 <label>${page.rowCount}</label>条记录 ，当前第<label>${page.pageIndex}</label>页，共
				<label>${page.pageCount}</label>页
			</div>
			<div class="div_page_right">
				<c:choose>
					<c:when test="${page.hasPre}">
						<a href="javascript:subForm(1)">首页</a>
						<a href="javascript:subForm(${page.pageIndex-1})">上一页</a>
					</c:when>
					<c:otherwise>
				首页
				上一页
            </c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${page.hasNext}">
						<a href="javascript:subForm(${page.pageIndex+1})">下一页</a>
						<a href="javascript:subForm(${page.pageCount})">尾页</a>
					</c:when>
					<c:otherwise>
				下一页
				尾页
            </c:otherwise>
				</c:choose>
				<button
					onclick="subForm(document.getElementById('pageIndex').value)">转到</button>
				<input type="text" name="pageIndex" id="pageIndex"
					value="${page.pageIndex}" />页
			</div>
		</div>
	</form>
</body>
<script>
	function subForm(pageIndex){
	    if(pageIndex){
	    	$("#pageIndex").val(pageIndex);
	    	document.form.submit();
	    }
	    else{
	    	document.form.submit();
	    }
	}
</script>
</html>