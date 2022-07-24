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
	    
	    //校验
	    function showOk(item){
			$(item+"_msg").addClass("ok").html("格式正确");
		}	
		function showError(item,msg){
			$(item+"_msg").addClass("error").html(msg);
		}
		
		//商品名称
		$("#goodsName").focus(function(){
			$("#goodsName_msg").removeClass("error").removeClass("ok").html("2-20位非空白字符");
		});
		$("#goodsName").blur(function(){
			if(validategoodsName()!=false){
				showOk("#goodsName");
			}
		});
		function validategoodsName(){
			var goodsName=$("#goodsName").val();
			var result=true;
			if(goodsName==""){
				result=false;
				showError("#goodsName","不能为空");
			}
			else{
				var reg=/^\S{2,20}$/;
		      	if(reg.test(goodsName)==false){
		      		 result=false;
		      		 showError("#goodsName","格式不正确");
		      	}
			}
			return result;	
		}
		
		//分类
		$("#bigCateId").focus(function(){
			$("#fl_msg").removeClass("error").removeClass("ok").html("请指定商品所属的分类");
		});
		$("#smallCateId").blur(function(){
			if(validateFl()!=false){
				showOk("#fl");
			}
		});
		function validateFl(){
			var result=true;
			if($("#smallCateId").val()==-1||$("#bigCateId").val()==-1){
				$("#fl_msg").removeClass("ok")
				showError("#fl","至少选择一项");
				result=false;
			}
			return result;	
		}

		//计量单位
		$("#unit").focus(function(){
			$("#unit_msg").removeClass("error").removeClass("ok").html("1-10个非空字符");
		});
		$("#unit").blur(function(){
			if(validateUnit()!=false){
				showOk("#unit");
			}
		});
		function validateUnit(){
			var unit=$("#unit").val();
			var result=true;
			if(unit==""){
				result=false;
				showError("#unit","不能为空");
			}
			else{
				var reg=/^\S{1,10}$/;
		      	if(reg.test(unit)==false){
		      		 result=false;
		      		 showError("#unit","格式不正确");
		      	}
			}
			return result;	
		}
		
		//商品价格
		$("#price").focus(function(){
			$("#price_msg").removeClass("error").removeClass("ok").html("不能为空,以元为单位,可以是小数");
		});
		$("#price").blur(function(){
			if(validatePrice()!=false){
				showOk("#price");
			}
		});
		function validatePrice(){
			var price=$("#price").val();
			var result=true;
			if(price==""){
				result=false;
				showError("#price","不能为空");
			}
			return result;	
		}
		
		
		
		//提交
		$("form").submit(function(){
			var result=true;
			validategoodsName();
			validateFl();
			validateUnit();
			validatePrice();
			if(validategoodsName()==true&&validateFl()==true&&validateUnit()==true&&validatePrice()==true){
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
		$("#goodsName").val("");
		$("#bigCateId,#smallCateId").empty();
		$("#bigCateId").append("<option value='0'>-所属大分类-</option>");
		$("#smallCateId").append("<option value='0'>-所属小分类-</option>");
		$.ajax({
	         url:"CateServlet.do",
	         dataType:"json",
	         data:{flag:"link1"},
	         success:function(cateList1){
	             $.each(cateList1,function(k,v){
	                 var option1="<option value='"+v.id+"'>"+v.cateName+"</option>";
	                 $("#bigCateId").append(option1);
	             });
	         }
	     });
	    $("#bigCateId").change(function(){
	        if(this.value=="0"){
	            $("#smallCateId").empty();
	            $("#smallCateId").append("<option value='0'>-所属小分类-</option>");
	            return;
	        }
	        $.ajax({
	           url:"CateServlet.do",
	           dataType:"json",
	           data:{flag:"link2",parentId:this.value},
	           success:function(cateList2){
	        	   $("#smallCateId").empty();
	        	   $("#smallCateId").append("<option value='0'>-所属小分类-</option>");
	               $.each(cateList2,function(k,v){
	                  var option2="<option value='"+v.id+"'>"+v.cateName+"</option>";
	                  $("#smallCateId").append(option2);
	               });
	           }
	        });
	    });
		$("#unit").val("");
		$("#price").val("");
		$("#picture").val("");
		$("label").html("").removeClass("ok");
		$("textarea").val("");
		 return result;
	}

	//图片预览
	function setImagePreview(docObj,localImagId,imgObjPreview,width,height){
		if(docObj.files && docObj.files[0]){
			imgObjPreview.style.display='block';
			imgObjPreview.style.width=width;
			imgObjPreview.style.height=height;
			imgObjPreview.src=window.URL.createObjectURL(docObj.files[0]);
		}else{
			docObj.select();
			var imgSrc=document.selectioncreateRange().text;
			localImagId.style.width=width;
			localImagId.style.height=height;
			try{
				localImagId.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod-scale)";
				localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src=imgSrc;
			}catch(e){
				alert("上传的图片格式不正确");
				return false;
			}
			imgObjPreview.style.display='none';
			document.selection.empty();
		}
	}
	</script>
</head>

<body>
	<div class ="div_title">
		 <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>商品添加</span></div>
	</div>		 
	<form action="GoodsServlet.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="flag" value="add">
	 <table class="edit_table" >
		<tr>
		 	<td class="td_info">商品名称:</td>	
		 	<td class="td_input_short"> 
		 		<input type="text" class="txtbox" id="goodsName" name="goodsName" value="${goods.goodsName}" /> 
		 	</td>   
		 	<td>
		 		<label class="validate_info" id="goodsName_msg"></label>
		 	</td> 
		</tr>
		
		<tr>	
			<td class="td_info">所属分类</td>	
			<td>
				<select name="bigCateId" id="bigCateId">
					<option value="0">-所属大分类-</option>
				</select>
				<select id="smallCateId" name="smallCateId">
					<option value="0">-所属小分类-</option>
				</select>
			</td> 
			<td><label class="validate_info" id="fl_msg" ></label></td>
 		</tr>
 		
		<tr>
			<td class="td_info">计量单位:</td>	
			<td><input type="text" class="txtbox" id="unit" name="unit" value="${goods.unit}" /> 
			</td>
			<td><label  class="validate_info"  id="unit_msg"></label></td>	
		</tr>
		
		<tr>
			<td class="td_info">商品价格:</td>	
			<td><input type="text" class="txtbox" id="price" name="price" value="${goods.price}" /> 
			</td>
			<td><label  class="validate_info"  id="price_msg"></label></td>	
		</tr>
		
		<tr>
			<td class="td_info">生产厂商:</td>	
			<td><input type="text" class="txtbox" id="producter" name="producter" value="${goods.producter}" /> 
			</td>
			<td><label  class="validate_info"  id="producter_msg"></label></td>		
		</tr>
		
		<tr >
			<td class="td_info">商品图片</td>	
			<td>
				<input id="picture" type="file" name="picture" style="display:none" class="file"  onchange="setImagePreview(this,localImag,preview,'100px','125px')" /> 
				<div id="localImag"></div>
				<img style="width:100px;height:125px" src="GoodsServlet.do?flag=showPicture" id="preview" alt="请上传图片" />
				<span onclick="document.getElementById('picture').click()" >点此上传图片</span>
			</td>
			<td><label  class="validate_info"  id="picture_msg"></label></td>	
 		</tr>
 		
		<tr>
			<td class="td_info">备注信息:</td>	
			<td><textarea rows="4" cols="27" name="des" class="txtarea">${goods.des}</textarea> </td>	
			<td><label></label></td>	
		</tr>
		
		<tr>
			<td class="td_info"> </td>	
			<td> 
			<input id="tj" class="form_btn" type="submit"  value="提交" /> 
			<input id="cz"  type="reset"  class="form_btn" onclick="return rs()"  value="重置" /> </td>	
			<td>
				<label id="result_msg" class="result_msg">${msg}</label>
			</td>	
		</tr>
	</table>
	</form>
	<input type="hidden" id="returnId1" value="">
	<input type="hidden" id="returnId2" value="">
</body>
<script>
//ajas分类

$("#returnId1").val(${bigCateId});
$("#returnId2").val(${smallCateId});
var bigCateId=$("#returnId1").val();
var smallCateId=$("#returnId2").val();
if(bigCateId==""){
	$.ajax({
         url:"CateServlet.do",
         dataType:"json",
         data:{flag:"link1"},
         success:function(cateList1){
             $.each(cateList1,function(k,v){
                 var option1="<option value='"+v.id+"'>"+v.cateName+"</option>";
                 $("#bigCateId").append(option1);
             });
         }
     });
    $("#bigCateId").change(function(){
        if(this.value=="0"){
            $("#smallCateId").empty();
            $("#smallCateId").append("<option value='0'>-所属小分类-</option>");
            return;
        }
        $.ajax({
           url:"CateServlet.do",
           dataType:"json",
           data:{flag:"link2",parentId:this.value},
           success:function(cateList2){
        	   $("#smallCateId").empty();
               $.each(cateList2,function(k,v){
                  var option2="<option value='"+v.id+"'>"+v.cateName+"</option>";
                  $("#smallCateId").append(option2);
               });
           }
        });
    });
}else{
	//下拉框ajax回显
	$.ajax({
        url:"CateServlet.do",
        data:{flag:"link1"},
        dataType: "json",
        success: function (cateList1) {
        	 $.each(cateList1,function(k,v){
                 var option1="<option value='"+v.id+"'>"+v.cateName+"</option>";
                 $("#bigCateId").append(option1);
             });
            //拿到回显的值
            var id1 = bigCateId;
        	//将所有的下拉框option赋值给all_select 
            all_select1 = $("#bigCateId > option");
            for (var i = 0; i < all_select1.length; i++) {
            	//循环所有的option 然后取出value值 进行比对
                var svalue1 = all_select1[i].value;
                if (id1 == svalue1) {  
                    //比对相同则令这个option添加上selected属性
                    $("#bigCateId option[value='" + svalue1 + "']").attr("selected", "selected");
                }
            }
        }
        
    });
	$.ajax({
       url:"CateServlet.do",
       dataType:"json",
       data:{flag:"link2",parentId:bigCateId},
       success:function(cateList2){
    	   $("#smallCateId").empty();
           $.each(cateList2,function(k,v){
              var option2="<option value='"+v.id+"'>"+v.cateName+"</option>";
              $("#smallCateId").append(option2);
           });
        	//拿到回显的值
            var id2 = smallCateId;
       		//将所有的下拉框option赋值给all_select 
           all_select2 = $("#smallCateId > option");
            for (var i = 0; i < all_select2.length; i++) {
            	//循环所有的option 然后取出value值 进行比对
                var svalue2 = all_select2[i].value;
                if (id2 == svalue2) {  
                    //比对相同则令这个option添加上selected属性
                    $("#smallCateId option[value='" + svalue2 + "']").attr("selected", "selected");
                }
            }
       }
    });
	$("#bigCateId").change(function(){
        if(this.value=="0"){
            $("#smallCateId").empty();
            $("#smallCateId").append("<option value='0'>-所属小分类-</option>");
            return;
        }
        $.ajax({
           url:"CateServlet.do",
           dataType:"json",
           data:{flag:"link2",parentId:this.value},
           success:function(cateList2){
        	   $("#smallCateId").empty();
               $.each(cateList2,function(k,v){
                  var option2="<option value='"+v.id+"'>"+v.cateName+"</option>";
                  $("#smallCateId").append(option2);
               });
           }
        });
    });
}
</script>
</html>