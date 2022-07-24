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
    <link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>  
	<link rel="stylesheet" type="text/css" href="css/validate.css"  ></link> 
    <link rel="stylesheet" type="text/css" href="css/check.css"  ></link> 
	<script type="text/javascript" src="js/jquery-1.8.0.js"></script> 
	<script type="text/javascript">
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
			
		    //校验
		    function showOk(item){
				$(item+"_msg").addClass("ok").html("格式正确");
			}	
			function showError(item,msg){
				$(item+"_msg").addClass("error").html(msg);
			}
			
			//角色名称
			$("#roleName").focus(function(){
				$("#roleName_msg").removeClass("error").removeClass("ok").html("2-15位,非空白字符");
			});
			$("#roleName").blur(function(){
				if(validateRoleName()!=false){
					showOk("#roleName");
				}
			});
			function validateRoleName(){
				var roleName=$("#roleName").val();
				var result=true;
				if(roleName==""){
					result=false;
					showError("#roleName","不能为空");
				}
				else{
					var reg=/^\S{2,15}$/;
			      	if(reg.test(roleName)==false){
			      		 result=false;
			      		 showError("#roleName","格式不正确");
			      	}
				}
				return result;	
			}
			
			//提交
			$("form").submit(function(){
				var result=true;
				validateRoleName()
				if(validateRoleName()==true){
					result=confirm("确定要提交吗?");
					return result;
				}
				return false;
			});	
		});
		
		//重置
		function rs(){
			var result=true;
	        result=confirm("确认要重置吗？");
	        if(result!=true){
	        	return result;
	        }
			$("#roleName").val("");
			$("label").html("").removeClass("ok");
			$("textarea").val("");
			return result;
		}
	</script>


</head>

<body>
	<div class ="div_title">
		<div class="div_titlename"> <img src="images/san_jiao.gif" ><span>角色添加</span></div>
	</div>
	<form action="RoleServlet.do" method="post" >
	<input type="hidden" name="flag" value="add">
	 <table class="edit_table" >
		<tr>
		 	<td class="td_info">角色名称:</td>	
		 	<td class="td_input_short"> 
		 		<input type="text" class="txtbox" id="roleName" name="roleName" value="${roleName}" /> 
		 	</td>
		 	<td><label id="roleName_msg" class="roleName_msg"></label></td>  
		</tr>
		<tr>
			<td class="td_info">角色描述:</td>	
			<td><textarea rows="4" cols="27" name="des" class="txtarea">${des}</textarea> </td>	
			<td><label></label></td>	
		</tr>
		<tr>
			<td class="td_info"> </td>	
			<td> 
			<input id="tj" class="form_btn" type="submit"  value="提交" /> 
			<input id="cz" type="reset" class="form_btn" onclick="return rs()"  value="重置" /> </td>
			<td>
				<label id="result_msg" class="result_msg">${msg}</label>
			</td>	
		</tr>
	</table>
	</form>
</body>
</html>