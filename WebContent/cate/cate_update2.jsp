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

			//分类名称
			$("#cateName").focus(function(){
				$("#cateName_msg").removeClass("error").removeClass("ok").html("长度 2-20 位非空白字符");
			});
			$("#cateName").blur(function(){
				if(validateCateName()!=false){
					showOk("#cateName");
				}
			});
			function validateCateName(){
				var cateName=$("#cateName").val();
				var result=true;
				if(cateName==""){
					result=false;
					showError("#cateName","不能为空");
				}
				else{
					var reg=/^\S{2,20}$/;
			      	if(reg.test(cateName)==false){
			      		 result=false;
			      		 showError("#cateName","格式不正确");
			      	}
				}
				return result;	
			}
			
			//查询分类并显示
			$.ajax({
		         url:"CateServlet.do",
		         dataType:"json",
		         async:false,
		         data:{flag:"link1"},
		         success:function(cateList1){
		             $.each(cateList1,function(k,v){
		                 var option1="<option value='"+v.id+"'>"+v.cateName+"</option>";
		                 $("#parentId").append(option1);
		                 //拿到回显的值
		                 var id = ${pid};
		             	//将所有的下拉框option赋值给all_select 
		                 all_select = $("#parentId > option");
		                 for (var i = 0; i < all_select.length; i++) {
		                 	//循环所有的option 然后取出value值 进行比对
		                     var svalue = all_select[i].value;
		                     if (id == svalue) {  
		                         //比对相同则令这个option添加上selected属性
		                         $("#parentId option[value='" + svalue + "']").attr("selected", "selected");
		                     }
		                 }
		             });
		         }
		     });
			
			//提交
			$("#submit").click(function(){
				var result=true;
				result=validateCateName();
				if(result==true){
					result=confirm("确定要提交吗?")
					if(result==true){
						$.ajax({
							type:"post",
							url:"CateServlet.do",
							data:{flag:"update2",cateId:$("#cateId").val(),cateName:$("#cateName").val(),des:$("#des").val(),parentId:$("option:selected").val()}, 
						    success:function(data){
						    	$("#result_msg").html(data);
						    }
						});
					}
				}
			});
		});		   
	</script>
</head>

<body>
	<div class ="div_title">
		 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>商品管理 二级分类维护</span></div>
	</div>
	<input type="hidden" id="cateId" name="cateId" value="${cate.id}" /> 	 
	 <table class="edit_table" >
	 
	 	<tr>
		 	<td class="td_info">父级分类:</td>	
		 	<td class="td_input_short"> 
		 		<select id="parentId"></select>
		 	</td>   
		 	<td>
		 		<label class="validate_info" id="pcateName_msg"></label>
		 	</td> 
 		</tr>

 		<tr>
		 	<td class="td_info">分类名称:</td>	
		 	<td class="td_input_short"> 
		 		<input type="text" class="txtbox" id="cateName" name="cateName" value="${cate.cateName}" /> 
		 	</td>   
		 	<td>
		 		<label class="validate_info" id="cateName_msg"></label>
		 	</td> 
 		</tr>
		
 		<tr>
 			<td class="td_info">分类描述:</td>	
 			<td><textarea rows="4" cols="27" name="des" id="des">${cate.des}</textarea> </td>	
 			<td><label></label></td>	
 		</tr>
 		<tr>
 			<td class="td_info"> </td>	
 			<td><input id="submit" class="form_btn" type="submit" value="保存修改" /> </td>	
 			<td>
 				<label id="result_msg" class="result_msg">${msg}</label>
 			</td>	
 		</tr>
	</table>
</body>
</html>