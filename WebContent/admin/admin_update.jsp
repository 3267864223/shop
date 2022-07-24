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
	
		 <script>		
		$(function(){
			$("input[type=text],textarea").focus(function(){
				$(this).addClass("input_focus");
			}).blur(function(){
				$(this).removeClass("input_focus");
			});

			$(".form_btn").hover(function(){
				$(this).css("color","red").css("background","#6FB2DB");
			},
			function(){
				$(this).css("color","#295568").css("background","#BAD9E3");
			});	


			//提交
			$("#submit").click(function(){
				var result=true;
				result=confirm("确定要提交吗?")
				if(result!=true){
					return;
				}
				$.ajax({
					type:"post",
					url:"AdminServlet.do",
					data:{flag:"update",adminName:$("#adminName").val(),note:$("#note").val()}, 
				    success:function(data){
				    	$("#result_msg").html(data);
				    }
				});
			});
		});		   
	</script>
</head>

<body>
	<div class ="div_title">
		 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>管理员修改</span></div>
	</div>
				 
	 <table class="edit_table" >
 		<tr>
		 	<td class="td_info">用户账号:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="adminName" name="adminName" value="${adminName}" /> 
		 	</td>   
		 	<td>
		 		<label class="validate_info" id="adminName_msg">用户账号不能修改</label>
		 	</td> 
 		</tr>
		
 		<tr>
 			<td class="td_info">备注信息:</td>	
 			<td><textarea rows="4" cols="27" name="note" id="note">${note}</textarea> </td>	
 			<td><label></label></td>	
 		</tr>
 		<tr>
 			<td class="td_info"> </td>	
 			<td> 
 			<input id="submit" class="form_btn" type="submit" value="提交" /> 
 			<input id="back" type="button"  class="form_btn" value="返回" /> </td>	
 			<td>
 				<label id="result_msg" class="result_msg">${msg}</label>
 			</td>	
 		</tr>
	</table>
</body>
<script>
	$("#back").click(function(){
		window.location.href="AdminServlet.do?flag=manage";
	});
</script>
</html>