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
		<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>管理人员基本信息列表</span></div>
		<div class="div_titleoper">
		<input type="checkbox" id="top_ch_checkall"/> 全选 <a href="admin/admin_add.jsp"> <img src="images/add.gif"/>添加 </a> <a href="javascript:delAll()"><img src="images/del.gif"/>删除</a> </div>
	</div>
	
	<form action="AdminServlet.do?flag=manage" method="post" name="form">
	<table class="main_table">
		<tr>
  			<th></th>
  			<th>账号</th>
  			<th>状态</th>
  			<th>备注</th>
  			<th>最后更新日期</th>
  			<th>操作</th>
  		</tr>
  		<c:forEach var="a" items="${adminList}">
			<tr>
				<td>
					<c:if test="${session_admin.id != a.id}">
						<input type="checkbox"  name="ck_id" value="${a.id }">
					</c:if>
				</td>
				<td>${a.adminName}</td>
				<td>
				<c:choose>
					<c:when test="${a.state eq 1}">
					</c:when>
					<c:otherwise>
						已锁定
					</c:otherwise>
				</c:choose>
				</td>
				<td>${a.note }</td>
				<td>${a.editDate }</td>
				<td>
					<c:choose>
						<c:when test="${a.state eq 1}">
							<c:if test="${session_admin.id != a.id}">
								<a id="lock" href="javascript:lock('${a.id}')">锁定</a><a href="AdminServlet.do?flag=toupdate&adminName=${a.adminName}&note=${a.note}">修改</a><a href="javascript:del('${a.id}')">删除</a>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${session_admin.id != a.id}">
								<a id="unlock" href="javascript:unlock('${a.id}')">解锁</a><a href="javascript:del('${a.id}')">删除</a>
							</c:if>
						</c:otherwise>
					</c:choose>
				</td>
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
	//页面转换
	function subForm(pageIndex){
	    if(pageIndex){
	    	$("#pageIndex").val(pageIndex);
	    	document.form.submit();
	    }
	    else{
	    	document.form.submit();
	    }
	}
	
	//锁定
	function lock(adminId){
		var result=true;
		result=confirm("确认锁定吗？");
		if(result==true){
			$.ajax({
				type:"post",
				url:"AdminServlet.do",
			    data:{flag:"lockAdmin",adminId:adminId},
			    async:false,
			    success:function(data){
			    	alert(data);
			    	window.location.href="AdminServlet.do?flag=manage";
			    }
			});
		}
	}
	
	//解锁
	function unlock(adminId){
		var result=true;
		result=confirm("确认解锁吗？");
		if(result==true){
			$.ajax({
				type:"post",
				url:"AdminServlet.do",
			    data:{flag:"unlockAdmin",adminId:adminId},
			    async:false,
			    success:function(data){
			    	alert(data);
			    	window.location.href="AdminServlet.do?flag=manage";
			    }
			});
		}
	}
	
	//删除
	function del(adminId){
		var result=true;
		result=confirm("确认删除吗？");
		if(result==true){
			$.ajax({
				type:"post",
				url:"AdminServlet.do",
			    data:{flag:"delete",adminId:adminId},
			    async:false,
			    success:function(data){
			    	alert(data);
			    	window.location.href="AdminServlet.do?flag=manage";
			    }
			});
		}
	}
	
	//删除所选
	function delAll(){
		//取到所选id，组成数组
		var ids=$("input:checkbox[name='ck_id']:checked");
		var arrId="";
		for(var i=0;i<ids.length;i++){
			arrId+=ids[i].value+(i==ids.length-1?"":",");
		}
		//判断是否为空
		if(arrId!=""){
			var result=true;
			result=confirm("确定要删除吗？");
			if(result==true){
				$.ajax({
					type:"post",
					url:"AdminServlet.do",
				    data:{flag:"delAll",arrId:arrId},
				    async:false,
				    success:function(data){
				    	alert(data);
				    	window.location.href="AdminServlet.do?flag=manage";
				    }
				});
			}
		}else{
			alert("请至少选择一项");
		}
	}
	
</script>
</html>