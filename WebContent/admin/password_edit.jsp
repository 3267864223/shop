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
			
			//旧密码
			$("#oldpassword").focus(function(){
				$("#oldpassword_msg").removeClass("error").removeClass("ok").html("请输入原来的密码");
			});
			$("#oldpassword").blur(function(){
				if(validateOldPwd()!=false){
					showOk("#oldpassword");
				}
			});
			function validateOldPwd(){
				var oldpassword=$("#oldpassword").val();
				var result=true;
				if(oldpassword==""){
					result=false;
					showError("#oldpassword","旧密码不能为空");
				}
				else{
					var reg=/^\w{6,20}$/;
			      	if(reg.test(oldpassword)==false){
			      		 result=false;
			      		 showError("#oldpassword","旧密码格式不正确");
			      	}else{
			      		$.ajax({
							type:"post",
							url:"AdminServlet.do",
						    data:{flag:"checkPwd",adminName:$("#adminName").val(),oldpassword:oldpassword},
						    async:false,
						    success:function(data){
						    	if(data=="1"){
						    		showError("#oldpassword","旧密码错误");
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
				validateOldPwd();
				validatePassword();
				validatePwdconfirm();
				if(validateOldPwd()==true&&validatePassword()==true&&validatePwdconfirm()==true){
					result=confirm("确定要提交吗?");
					if(result==true){
						$.ajax({
							type:"post",
							url:"AdminServlet.do",
							data:{flag:"editpassword",adminName:$("#adminName").val(),password:$("#password").val()}, 
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
            $("#oldpassword").val("");
            $("#password").val("");
            $("#pwdconfirm").val("");
            $("label").html("").removeClass("ok");
            return result;
		}

		   
	</script>
</head>

<body>
	<div class ="div_title">
		 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>用户密码修改</span></div>
	</div>
	 <table class="edit_table" >
 		<tr>
		 	<td class="td_info">用户账号:</td>	
		 	<td class="td_input_short"> 
		 		<input readonly="readonly" type="text" class="txtbox" id="adminName" name="adminName" value="${session_admin.adminName}"/> 
		 	</td>   
		 	<td>
		 		<label class="validate_info" id="adminName_msg"></label>
		 	</td> 
 		</tr>
		<tr>
			<td class="td_info">旧密码:</td>	
			<td>
				<input  type="text"  class="txtbox"  name="oldpassword"  id="oldpassword" />
			</td> 
			<td><label  class="validate_info" id="oldpassword_msg" ></label></td>	
 		</tr>

		<tr>
			<td class="td_info">新密码:</td>	
			<td>
				<input  type="text"  class="txtbox"  name="password"  id="password" />
			</td> 
			<td><label  class="validate_info" id="password_msg" ></label></td>	
 		</tr>
 		
		<tr>
			<td class="td_info">重复密码:</td>	
			<td>
				<input  type="text"  class="txtbox"  name="pwdconfirm"  id="pwdconfirm" />
			</td> 
			<td><label  class="validate_info" id="pwdconfirm_msg" ></label></td>	
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