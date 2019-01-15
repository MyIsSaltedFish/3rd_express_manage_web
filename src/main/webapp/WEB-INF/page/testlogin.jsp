<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+'/'%>">
<link rel="stylesheet" href="static/easyui15/themes/bootstrap/easyui.css" />
<link rel="stylesheet" href="static/easyui15/themes/icon.css"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="" method="post" style="text-align: center;">
		<p>
			<label for="uname">用户姓名</label>
			<input type="text" name="uname" id="uname" />
		</p>		
		<p>
			<label for="upass">用户密码</label>
			<input type="password" name="upassword" id="upass"/>
		</p>	
	</form>
	<div id="tt" style="text-align: right;">
		<a href="#" class="easyui-linkbutton" data-options = "iconCls:'icon-login',text:'登陆'" id="alogin"></a>
		<a href="#" class="easyui-linkbutton" data-options = "iconCls:'icon-cancel',text:'取消'" id="aclose"></a>
	</div>
</body>
<script src="static/easyui15/jquery.min.js"></script>
<script src="static/easyui15/jquery.easyui.min.js"></script>
<script src="static/easyui15/locale/easyui-lang-zh_CN.js"></script>
<script>
	$("form").window({
		title:'登陆窗口',
		iconCls:'icon-login',
		width:400,
		height:250,
		footer:'#tt'
	});
	$("#alogin").on("click",function(event){
		event.preventDefault();
		var url = 'login';
		var pdata = $("form").serialize();
		$.post(url,pdata,function(jsonObj){
			if(jsonObj.keyCode==200){
				window.location.href='toindex'
			}else{
				$.messager.alert("系统消息",jsonObj.message,"error");
			}
		},"json")
	})
</script>
</html> 