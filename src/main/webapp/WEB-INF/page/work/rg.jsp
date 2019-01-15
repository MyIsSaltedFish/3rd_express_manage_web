<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+'/'%>">
<meta charset=UTF-8">
<title>取派员设置</title>
<!-- 导入jquery核心类库 -->
<link rel="stylesheet" type="text/css" href="static/easyui15/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="static/easyui15/themes/icon.css">
<script type="text/javascript" src="static/easyui15/jquery.min.js"></script>
<script type="text/javascript" src="static/easyui15/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/easyui15/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	$(function() {
		$("#grid").datagrid({
			singleSelect : true,
			toolbar : [ {
				id : 'diaodu',
				text : '人工调度',
				iconCls : 'icon-edit',
				handler : function() {
					//获取当前数据表格所有选中的行，返回数组
					var rows = $("#grid").datagrid("getSelections");
					if(rows.length != 1){
						//弹出提示
						$.messager.alert("提示信息","请选择一个通知单操作！","warning");
						return;
					}
					
					// 弹出窗口
					$("#noticebillId").val(rows[0].id);
					$("#diaoduWindow").window('open');
				}
			} ],
			columns : [ [ {
				field : 'id',
				title : '编号',
				width : 100
			}, {
				field : 'delegater',
				title : '联系人',
				width : 100
			}, {
				field : 'telephone',
				title : '电话',
				width : 100
			}, {
				field : 'pickaddress',
				title : '取件地址',
				width : 100
			}, {
				field : 'product',
				title : '商品名称',
				width : 100
			}, {
				field : 'pickdate',
				title : '取件日期',
				width : 100
			} ] ],
			url : 'qb/findnoass',
			fit : true
		});

		// 点击保存按钮，为通知单 进行分单 --- 生成工单
		$("#save").click(function() {
			var rows = $("#grid").datagrid("getSelections");
			var staffid = $("#staffId").combobox("getValue");
			var newName = $("#staffId").combobox("getText");
			var staffName= newName.split(":")[0];
			var staffPhone= newName.split(":")[1];
			var cusphone = rows[0].telephone;
			var cusAddress = rows[0].pickaddress;
			var pdata={"id":rows[0].id,"staffId":staffid,
					"staffName":staffName,"staffPhone":staffPhone,
					"telephone":cusphone,"pickaddress":cusAddress};
			$.post('qb/updateqp',pdata,function(jsonData){
				$.messager.alert("info",jsonData.message,"info");
			},"json");
		});
	});
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',border:false">
		<table id="grid"></table>
	</div>
	<div class="easyui-window" title="人工调度" id="diaoduWindow" closed="true"
		collapsible="false" minimizable="false" maximizable="false"
		style="top:100px;left:200px;width: 500px; height: 300px">
		<div region="north" style="height:31px;overflow:hidden;" split="false"
			border="false">
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="javascript:void(0);" class="easyui-linkbutton"
					plain="true">保存</a>
			</div>
		</div>
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="diaoduForm" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">人工调度</td>
					</tr>
					<tr>
						<td></td>
						<td><input type="hidden" name="id" id="noticebillId" /> <span
							id="noticebillIdView"></span>
					</tr>
					<tr>
						<td>选择取派员</td>
						<td><input class="easyui-combobox" required="true"
							name="staffId" id="staffId"
							data-options="valueField:'id',textField:'newName',url:'qb/findallstaff'" />
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>