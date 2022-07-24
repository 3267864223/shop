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
	<link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>  
	<link rel="stylesheet" type="text/css" href="css/validate.css"  ></link>  
	<link rel="stylesheet" type="text/css" href="css/maintable.css"></link>
	<script type="text/javascript"  src="js/jquery-1.8.0.js"></script>
	<style>
		input{
			color:red;
		}
	</style>
	
	<script>
		$(function(){
			//判断memberNo是否存在
			if("${order.memberNo}"==""){
				$("#memberNo").val("游客 非会员");
			}
			
			$("#back").click(function(){
				window.location.href="OrderServlet.do?flag=manage";
			});
		});
		
	</script>
</head>

<body>
	<div class ="div_title">
		 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>订单商品列表</span></div>
	</div>
	<table class="main_table">
		<tr>
			<th>商品名称</th>
			<th>单位</th>
			<th>单价</th>
			<th>购买数量</th>
		</tr>
		<c:forEach var="og" items="${ogList}">
			<tr>
				<td>${og.goodsName}</td>
				<td>${og.unit}</td>
				<td>${og.price}</td>
				<td>${og.saleCount}</td>
			</tr>
		</c:forEach>
	</table>
	
	<div class ="div_title">
		 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>订单列表详情</span></div>
	</div>
	<table class="edit_table" >
 		<tr>
		 	<td class="td_info">订单号:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="orderNo" name="orderNo" value="${order.orderNo}"/> 
		 	</td>   
		 	<td class="td_info">邮费:</td>
			<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="postage" name="postage" value="${order.postage}"/> 
		 	</td> 
 		</tr>
 		
 		<tr>
		 	<td class="td_info">付款方式:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="payMethod" name="payMethod" value="${order.payMethod}"/> 
		 	</td>   
		 	<td class="td_info">邮递方式:</td>
			<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="postMethod" name="postMethod" value="${order.postMethod}"/> 
		 	</td> 
 		</tr>
		
		<tr>
		 	<td class="td_info">下单日期:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="orderDate" name="orderDate" value="${order.orderDate}"/> 
		 	</td>   
		 	<td class="td_info">邮寄地址:</td>
			<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="address" name="address" value="${order.address}"/> 
		 	</td> 
 		</tr>
 		
 		<tr>
		 	<td class="td_info">订单状态:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="orderState" name="orderState" value="${order.orderState}"/> 
		 	</td>   
		 	<td class="td_info">发货日期:</td>
			<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="sendDate" name="sendDate" value="${order.sendDate}"/> 
		 	</td> 
 		</tr>
 		
		<tr>
		 	<td class="td_info">订单金额:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="amount" name="amount" value="${order.amount}"/> 
		 	</td>   
		 	<td class="td_info">会员ID:</td>
			<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="memberNo" name="memberNo" value="${order.memberNo}"/> 
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
</html>