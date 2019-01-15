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
			<label>角色名称:</label><input type='text' id='rname' class='easyui-textbox' />&nbsp;
		</div>
		<a href='#' onclick='dgtsManager.search(event)' class='easyui-linkbutton' plain=true iconCls='icon-search'>查询</a>
	</div>
		<a class='easyui-linkbutton' plain=true iconCls='icon-add' onclick='dgtsManager.add(event)'>添加</a>
		<a class='easyui-linkbutton' plain=true iconCls='icon-edit' onclick='dgtsManager.upd(event)'>修改</a>
		<a class='easyui-linkbutton' plain=true iconCls='icon-remove' onclick='dgtsManager.del(event)'>删除</a>
</div>
<!-- 表格 -->
<table id="dg"></table>
<!-- 弹出的修改窗口 -->
<form id="myDialog" method="post" style="text-align: center;">							
		<input type="hidden" id="roleid" name="roleid"/> 					
		<p>					
			<label for="rolename">角色名称:</label>
			<input class="easyui-textbox"  id="rolename" name="rolename" style="width: 200px"> 						
		</p>									
		<p>					
			<label for="rights">赋予权限:</label>				
			<select class="easyui-textbox" id="rights" name="rights" style="width: 200px;"></select>
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
<script type="text/javascript" src="static/js/role.js"></script>
</html> 