<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
			
			//ajas分类与回显
			var bigCateId="${bigCateId}";
			var smallCateId="${smallCateId}";
			if(bigCateId==0){
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
			            $("#smallCateId").append("<option value='0'>小分类</option>");
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
			            var all_select1 = $("#bigCateId > option");
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
			           var all_select2 = $("#smallCateId > option");
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
			            $("#smallCateId").append("<option value='0'>小分类</option>");
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
		 });
	</script>

<link rel="stylesheet" type="text/css" href="css/maintable.css"></link>

</head>

<body>
	<div class="div_title">
		<div class="div_titlename">
			<img src="images/san_jiao.gif"><span>商品列表</span>
		</div>
		<div class="div_titleoper">
			<input id="top_ch_checkall" type="checkbox" />全选 <a href="goods/goods_add.jsp"> <img
				src="images/add.gif" />添加
			</a> <a href="javascript:delAll()"><img src="images/del.gif" />删除</a>
		</div>
	</div>
	
	<form action="GoodsServlet.do?flag=manage" method="post" name="form">
		<div class="div_tools">
			&nbsp;&nbsp;<select name="bigCateId" id="bigCateId">
				<option value="0">大分类</option>
			</select>&nbsp;&nbsp; <select name="smallCateId" id="smallCateId">
				<option value="0">小分类</option>
			</select>&nbsp;&nbsp; 商品名称: <input type="text" name="goodsName"
				value="${goodsName}"></input> <input id="btnsubmit" type="submit"
				value="查询" />
		</div>
		<table class="main_table">
			<tr>
				<th></th>
				<th>名称</th>
				<th>单位</th>
				<th>单价</th>
				<th>大分类</th>
				<th>小分类</th>
				<th>操作</th>
			</tr>
			<c:forEach var="g" items="${goodsList}">
				<tr>
					<td><input type="checkbox" name="ck_id" value="${g.id}"></td>
					<td>${g.goodsName}</td>
					<td>${g.unit}</td>
					<td>${g.price}</td>
					<td>${g.bigCateName}</td>
					<td>${g.smallCateName}</td>
					<td><a href="javascript:void(0)" onmousemove="showP(this,'${g.id}')" onmouseout="hideP()">查看</a><a
						href="GoodsServlet.do?flag=toupdate&goodsId=${g.id}">修改</a><a href="javascript:del('${g.id}')">删除</a></td>
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
	<img id="imgshowp" style="width:150px;height:175px;display:none"  />
	
</body>
<script>
	//根据已有元素,取得它的坐标	
	function getElemPos(obj) {
		var pos = {
			"top" : 0,
			"left" : 0
		};
		if (obj.offsetParent) {
			while (obj.offsetParent) {
				pos.top += obj.offsetTop;
				pos.left += obj.offsetLeft;
				obj = obj.offsetParent;
			}
		} else if (obj.x) {
			pos.left += obj.x;
		} else if (obj.x) {
			pos.top += obj.y;
		}
		
		return {
			x : pos.left,
			y : pos.top
		};

	}

	//图片显示查看
	function showP(item,goodsId){
		$("#imgshowp").css("display","block").css("position","absolute");
		var position = getElemPos(item);
		$("#imgshowp").css("left", position.x + 30).css("top",position.y+20);
		$("#imgshowp").attr("src","GoodsServlet.do?flag=showp&goodsId="+goodsId);
	}

	//隐藏图片
	function hideP(){
		$("#imgshowp").removeAttr("src").css("display","none");	
	}
	
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
	function del(goodsId){
		var result=true;
		result=confirm("确认删除吗？");
		if(result==true){
			$.ajax({
				type:"post",
				url:"GoodsServlet.do",
			    data:{flag:"delete",goodsId:goodsId},
			    async:false,
			    success:function(data){
			    	alert(data);
			    	window.location.href="GoodsServlet.do?flag=manage";
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
					url:"GoodsServlet.do",
				    data:{flag:"delAll",arrId:arrId},
				    async:false,
				    success:function(data){
				    	alert(data);
				    	window.location.href="GoodsServlet.do?flag=manage";
				    }
				});
			}
		}else{
			alert("请至少选择一项");
		}
	}
</script>
</html>