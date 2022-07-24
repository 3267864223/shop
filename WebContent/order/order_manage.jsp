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
			
			//订单状态回显
			$("#select").val("${orderState}");
		});
		
		//发货
		function send(orderId){
			var result=true;
			result=confirm("确定要进行发货吗？");
			if(result==true){
				$.ajax({
					type:"post",
					url:"OrderServlet.do",
					data:{flag:"send",orderId:orderId}, 
				    success:function(data){
				    	alert(data);
				    	window.location.href="OrderServlet.do?flag=manage";
				    }
				});
			}
		}
	</script>
</head>

<body>
	<div class="div_title">
		<div class="div_titlename">
			<img src="images/san_jiao.gif"><span>订单列表</span>
		</div>
		<div class="div_titleoper">
			<input id="top_ch_checkall" type="checkbox" />全选 
			<a href="javascript:delAll()"><img src="images/del.gif" />删除</a>
		</div>
	</div>
	<form action="OrderServlet.do?flag=manage" method="post" name="form">
		<div class="div_tools">
			&nbsp;&nbsp;订单号:<input type="text" name="orderNo" value="${orderNo}"/>
			&nbsp;&nbsp; 下单日期从:<input type="text" name="stratDate" onclick="WdatePicker()" value="${stratDate}"/>
			到  <input type="text" name="endDate" onclick="WdatePicker()" value="${endDate}"/>
			&nbsp;&nbsp; <select id="select" name="orderState">
							<option value="0">全部</option>
							<option value="3">未付款</option>
							<option value="1">已支付</option>
							<option value="2">已发货</option>
						</select>
			&nbsp;&nbsp; <input id="btnsubmit" type="submit" value="查询" />
		</div>
		<table class="main_table">
			<tr>
				<th></th>
				<th>订单号</th>
				<th>付款方式</th>
				<th>订单金额</th>
				<th>订单状态</th>
				<th>邮寄方式</th>
				<th>生成日期</th>
				<th>发货地址</th>
				<th>操作</th>
			</tr>
			<c:forEach var="o" items="${orderList}">
				<tr>
					<td><input type="checkbox" name="ck_id" value="${o.id}"></td>
					<td>${o.orderNo}</td>
					<td>${o.postMethod}</td>
					<td>${o.amount}</td>
					<td>${o.orderState}</td>
					<td>${o.postMethod}</td>
					<td>${o.orderDate}</td>
					<td>${o.address}</td>
					<td><a href="OrderServlet.do?flag=info&orderId=${o.id}" >查看</a>
					<c:choose>
						<c:when test="${o.orderState eq '已发货'}">
						</c:when>
						<c:otherwise>
							<a href="javascript:send(${o.id})">发货</a>
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
					url:"OrderServlet.do",
				    data:{flag:"delAll",arrId:arrId},
				    async:false,
				    success:function(data){
				    	alert(data);
				    	window.location.href="OrderServlet.do?flag=manage";
				    }
				});
			}
		}else{
			alert("请至少选择一项");
		}
	}
</script>
</html>