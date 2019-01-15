<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+'/'%>">
<meta charset="UTF-8">
<link rel="stylesheet" href="static/easyui15/themes/default/easyui.css">
<link rel="stylesheet" href="static/easyui15/themes/icon.css">
<title>Insert title here</title>
</head>
<body>
<!-- 表格工具栏 -->
<div id='dgts'>
	<div class='easyui-panel' title='查询条件' iconCls='icon-search' collapsible=true collapsed=true style='padding: 5px'>
		<div style="float:left;height: 30px">
			<label>角色名称:</label><input type='text' id='uname' class='easyui-textbox' />&nbsp;
		</div>
		<a href='#' onclick='dgtsManage.search(event)' class='easyui-linkbutton' plain=true iconCls='icon-search'>查询</a>
	</div>
		<a class='easyui-linkbutton' plain=true iconCls='icon-add' onclick='dgtsManage.add(event)'>添加</a>
		<a class='easyui-linkbutton' plain=true iconCls='icon-edit' onclick='dgtsManage.upd(event)'>修改</a>
		<a class='easyui-linkbutton' plain=true iconCls='icon-remove' onclick='dgtsManage.del(event)'>删除</a>
</div>
<!-- 表格 -->
<table id="dg"></table>
<!-- 弹出的修改窗口 -->
<form id="myDialog" method="post" style="text-align: center;" >							
		<input type="hidden" id="uid" name="uid"/> 					
		<p>					
			<label for="ustrname">用户名称:</label>
			<input class="easyui-textbox"  id="ustrname" name="uname" style="width: 200px"> 						
		</p>	
		<p>
			<label for="reallyname">真实姓名:</label>
			<input class="easyui-textbox"  id="reallyname" name="utruename" style="width: 200px"> 								
		</p>
		<p>
			<label for="upassword">用户密码:</label>
			<input class="easyui-textbox"  id="upassword" name="upassword" style="width: 200px"> 								
		</p>
		<p>					
			<label for="combobox">用户角色:</label>				
			<select class="easyui-textbox " id="combobox" name="roleid" style="width: 200px;"></select>
		</p>										
</form>
<div id="divedit" style="text-align: center;">
	<a class="easyui-linkbutton" onclick="javascript:myDialogManage.clickOk(event)">确认</a>
	<a class="easyui-linkbutton" onclick="javascript:myDialogManage.clickCancel(event)">取消</a>
</div>
</body>
<script src="static/easyui15/jquery.min.js"></script>
<script src="static/easyui15/jquery.easyui.min.js"></script>
<script src="static/easyui15/locale/easyui-lang-zh_CN.js"></script>
<script src="/static/js/users.js"></script>
</html> 