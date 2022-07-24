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
		$("table tr").mouseover(function(){
			$(this).css("background","#D3EAEF");
			$(this).siblings().css("background","white");
		});
	});
	
	function del1(cateId){
		var result=true;
		result=confirm("确定删除吗？");
		if(result==true){
			$.ajax({
				type:"post",
				url:"CateServlet.do",
				data:{flag:"del1",cateId:cateId}, 
			    success:function(data){
			    	if(data=="0"){
			    		alert("此分类下还有子分类,删除失败");
			    	}else{
			    		alert("删除成功");
				    	window.location.href="CateServlet.do?flag=manage";
			    	}
			    }
			});
		}
	}
	
	function del2(cateId){
		var result=true;
		result=confirm("确定删除吗？");
		if(result==true){
			$.ajax({
				type:"post",
				url:"CateServlet.do",
				data:{flag:"del2",cateId:cateId}, 
			    success:function(data){
			    	if(data=="0"){
			    		alert("此分类下还有商品,删除失败");
			    	}else{
			    		alert("删除成功");
				    	window.location.href="CateServlet.do?flag=manage";
			    	}
			    	
			    }
			});
		}
	}
	</script>

<link rel="stylesheet" type="text/css" href="css/maintable.css" ></link>
<link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>  
<link rel="stylesheet" type="text/css" href="css/validate.css"  ></link>  
</head>

<body>
	<div class ="div_title">
		<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>商品维护 分类管理</span></div>
	</div>
	<table class="main_table">
		<tr>
			<th colspan="2">一级分类</th>
			<th colspan="2">二级分类</th>
		</tr>
		<c:forEach var="c" items="${cateList}">
			<tr>
				<td>${c.cateName}</td>
				<td><a href="CateServlet.do?flag=toupdate1&cateId=${c.id}&cateName=${c.cateName}&des=${c.des}">修改</a> |<a href="javascript:del1(${c.id})">删除</a></td>
				<td >
					<c:forEach var="c_sub" items="${c.subCateList}">
						${c_sub.cateName}<br>
					</c:forEach>
				</td>
				<td>
					<c:forEach var="c_sub" items="${c.subCateList}">
						<a href="CateServlet.do?flag=toupdate2&cateId=${c_sub.id}">修改</a> |<a href="javascript:del2(${c_sub.id})">删除</a><br>
					</c:forEach>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>