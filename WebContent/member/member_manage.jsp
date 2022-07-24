<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	<link rel="stylesheet" type="text/css" href="css/maintable.css"></link>
	<script>
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
</head>

<body>
	<div class="div_title">
		<div class="div_titlename">
			<img src="images/san_jiao.gif"><span>会员列表</span>
		</div>
		<div class="div_titleoper">
			<input id="top_ch_checkall" type="checkbox" />全选 
			<a href="javascript:delAll()"><img src="images/del.gif" />删除</a>
		</div>
	</div>
	<form action="MemberServlet.do?flag=manage" method="post" name="form">
	<input type="hidden" id="returnId1" value="">
	<input type="hidden" id="returnId2" value="">
		<div class="div_tools">
			&nbsp;&nbsp;会员账号:<input type="text" name="memberNo" value="${memberNo}"/>
			&nbsp;&nbsp;注册日期从:<input type="text" name="stratDate" onclick="WdatePicker()" value="${stratDate}"/>
			到  <input type="text" name="endDate" onclick="WdatePicker()" value="${endDate}"/>
			&nbsp;&nbsp; <input id="btnsubmit" type="submit" value="查询" />
		</div>
		<table class="main_table">
			<tr>
				<th></th>
				<th>账号</th>
				<th>姓名</th>
				<th>电话</th>
				<th>邮箱</th>
				<th>注册日期</th>
				<th>会员等级</th>
				<th>操作</th>
			</tr>
			<c:forEach var="m" items="${memberList}">
				<tr>
					<td><input type="checkbox" name="ck_id" value="${m.id}"></td>
					<td>${m.memberNo}</td>
					<td>${m.memberName}</td>
					<td>${m.phone}</td>
					<td>${m.email}</td>
					<td>${m.registerDate}</td>
					<td>${m.memberLevel}</td>
					<td><a href="MemberServlet.do?flag=info&memberId=${m.id}" >查看</a><a href="javascript:del(${m.id})">删除</a></td>
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
	    
	//删除
	function del(memberId){
		var result=true;
		result=confirm("确定要删除会员吗？");
		if(result==true){
			$.ajax({
				type:"post",
				url:"MemberServlet.do",
				data:{flag:"del",memberId:memberId}, 
			    success:function(data){
		    		alert(data);
			    	window.location.href="MemberServlet.do?flag=manage";
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
			result=confirm("确定要删除吗？");
			if(result==true){
				$.ajax({
					type:"post",
					url:"MemberServlet.do",
				    data:{flag:"delAll",arrId:arrId},
				    async:false,
				    success:function(data){
				    	alert(data);
				    	window.location.href="MemberServlet.do?flag=manage";
				    }
				});
			}
		}else{
			alert("请至少选择一项");
		}
	}

</script>
</html>