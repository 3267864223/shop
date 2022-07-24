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
	<link rel="stylesheet" type="text/css" href="css/check.css"  ></link>  
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
			
			function showOk(item){
				$(item+"_msg").addClass("ok").html("格式正确");
			}	
			function showError(item,msg){
				$(item+"_msg").addClass("error").html(msg);
			}
			
			//账号
			$("#adminName").focus(function(){
				$("#adminName_msg").removeClass("error").removeClass("ok").html("4-15位；只限数字(0-9)和英文(a-z),不区分大小写");
			});
			$("#adminName").blur(function(){
				if(validateAdminName()!=false){
					showOk("#adminName");
				}
			});
			function validateAdminName(){
				var adminName=$("#adminName").val();
				var result=true;
				if(adminName==""){
					result=false;
					showError("#adminName","账号不能为空");
				}
				else{
					var reg=/^[a-zA-Z0-9]{4,15}$/;
			      	if(reg.test(adminName)==false){
			      		 result=false;
			      		 showError("#adminName","账号格式不正确");
			      	}else{
			      		$.ajax({
							type:"post",
							url:"AdminServlet.do",
						    data:{flag:"checkAdminName",adminName:adminName},
						    async:false,
						    success:function(data){
						    	if(data=="0"){
						    		showError("#adminName","用户名重复");
						    		result=false;
						    	}
						    }
						});
			      	}
				}
				return result;	
			}
			
			//密码
			$("#password").focus(function(){
				$("#password_msg").removeClass("error").removeClass("ok").html("数字或英文,6-20位");
			});
			$("#password").blur(function(){
				if(validatePassword()!=false){
					showOk("#password");
				}
			});
			function validatePassword(){
				var password=$("#password").val();
				var result=true;
				if(password==""){
					result=false;
					showError("#password","密码不能为空");
				}
				else{
					var reg=/^\w{6,20}$/;
			      	if(reg.test(password)==false){
			      		 result=false;
			      		 showError("#password","密码格式不正确");
			      	}
				}
				return result;	
			}

			//重复密码
			$("#pwdconfirm").focus(function(){
				$("#pwdconfirm_msg").removeClass("error").removeClass("ok").html("请重复输入密码");
			});
			$("#pwdconfirm").blur(function(){
				if(validatePwdconfirm()!=false){
					showOk("#pwdconfirm");
				}
			});
			function validatePwdconfirm(){
				var password=$("#password").val();
				var pwdconfirm=$("#pwdconfirm").val();
				var result=true;
				if(pwdconfirm==""){
					result=false;
					showError("#pwdconfirm","重复密码不能为空");
				}
				else{
					if(password!=pwdconfirm){
		     			 result=false;
		     			 showError("#pwdconfirm","两次密码不一致");
		     		}
				}
				return result;	
			}

			//提交
			$("#submit").click(function(){
				var result=true;
				validateAdminName();
				validatePassword();
				validatePwdconfirm();
				if(validateAdminName()==true&&validatePassword()==true&&validatePwdconfirm()==true){
					result=confirm("确定要提交吗?");
					if(result==true){
						$.ajax({
							type:"post",
							url:"AdminServlet.do",
							data:{flag:"add",adminName:$("#adminName").val(),password:$("#password").val(),txtarea:$(".txtarea").val()}, 
						    success:function(data){
						    	$("#result_msg").html(data);
						    }
						});
					}
				}
				return;
			});
		});		
		
		//重置
		function rs(){
			var result=true;
            result=confirm("确认要重置吗？");
            if(result!=true){
            	return result;
            }
            $("#adminName").val("");
            $("#password").val("");
            $("#pwdconfirm").val("");
            $("label").html("").removeClass("ok");
            $("textarea").val("");
            return result;
		}

		   
	</script>
</head>

<body>
	<div class ="div_title">
		 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>管理员添加</span></div>
	</div>
				 
	 <table class="edit_table" >
	 		<tr>
 			 	<td class="td_info">用户账号:</td>	
 			 	<td class="td_input_short"> 
 			 		<input type="text" class="txtbox" id="adminName" name="adminName" /> 
 			 	</td>   
 			 	<td>
 			 		<label class="validate_info" id="adminName_msg"></label>
 			 	</td> 
 		</tr>
 			<tr>
 				<td class="td_info">用户密码:</td>	
 				<td>
 					<input type="text"  class="txtbox"  name="password"  id="password" />
 				</td> 
 				<td><label  class="validate_info" id="password_msg" ></label></td>	
 		</tr>
 			<tr>
 				<td class="td_info">重复密码:</td>	
 				<td><input type="text" class="txtbox" id="pwdconfirm"  /> 
 				</td>
 				<td><label  class="validate_info"  id="pwdconfirm_msg"></label></td>	
 		</tr>
 		<tr>
 			<td class="td_info">备注信息:</td>	
 			<td><textarea rows="4" cols="27" name="note" class="txtarea"></textarea> </td>	
 			<td><label></label></td>	
 		</tr>
 		<tr>
 			<td class="td_info"> </td>	
 			<td> 
 			<input id="submit" class="form_btn" type="submit" value="提交" /> 
 			<input type="reset"  class="form_btn" value="重置" onclick="return rs()"/> </td>	
 			<td>
 				<label id="result_msg" class="result_msg"></label>
 			</td>	
 		</tr>
	</table>
</body>
</html>