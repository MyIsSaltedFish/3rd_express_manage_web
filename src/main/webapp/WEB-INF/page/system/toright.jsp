<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+'/'%>">
<meta charset="UTF-8">
<link rel="stylesheet" href="static/easyui15/themes/default/easyui.css">
<link rel="stylesheet" href="static/easyui15/themes/icon.css">
<title>权限菜单页面</title>
</head>
<body>
<!--树-->
<ul id="mtree"></ul>
<!--菜单-->
<div class="easyui-menu" style="width:120px;" id="mm">
	<div onclick="mmManage.add()" data-options="iconCls:'icon-add'">追加</div>
	<div onclick="mmManage.edit()" data-options="iconCls:'icon-save'">修改</div>
	<div class="menu-sep"></div>
	<div onclick="mmManage.remove()" data-options="iconCls:'icon-remove'">删除</div>
</div>
<!-- 弹出的修改窗口 -->
<form id="myDialog" method="post" style="text-align: center;">							
		<input type="hidden" id="rightid" name="rightid"/> 					
		<p>					
			<label for="righttext">节点文本:</label>
			<input class="easyui-textbox" data-options="iconCls:'icon-search'" id="righttext" name="righttext" style="width: 140px"> 						
		</p>									
		<p>					
			<label for="righturl">节点链接:</label>				
			<input type="text" id="righturl"				
				class="easyui-textbox" data-options="iconCls:'icon-search'" name="righturl" style="width: 140px"/> 			
		</p>
		<p>					
			<label for="rightparent">父亲节点:</label>				
			<input type="text" id="rightparent"				
				class="easyui-textbox" data-options="iconCls:'icon-search'"
				 name="rightparent" style="width: 140px" readonly="readonly"/> 
			<input type="hidden" id="parentid"				
			 name="parentid"/> 			
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
<script src="static/js/right.js"></script>
</html> 