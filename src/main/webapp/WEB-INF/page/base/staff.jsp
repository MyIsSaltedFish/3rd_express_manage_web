<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+'/'%>">
<meta charset="UTF-8">
<title>取派员设置</title>
<!-- 导入jquery核心类库 -->
<link rel="stylesheet" type="text/css" href="static/easyui15/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="static/easyui15/themes/icon.css">
<script type="text/javascript" src="static/easyui15/jquery.min.js"></script>
<script type="text/javascript" src="static/easyui15/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/easyui15/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	function doAdd(){
		//alert("增加...");
		$('#addStaffWindow').window("open");
	}
	
	function doView(){
		
		$('#searchStaffWindow').window("open");
	}
	
	function doDelete(){
		alert("删除...");
		var rows = $('#grid').datagrid('getChecked');
		//2 判断是否有选中的行
		if(rows.length<=0){
			$.messager.alert('system','请至少选中一行','info');
			retrun;
		}
		//2.1 ng-->提示 退出
		$.messager.confirm('确认对话框', '您想要删除吗？', function(r){
			if (r){
			    // 删除操作;
				var id = '';
				for(var i=0;i<rows.length;i++){
					if(i==rows.length-1){
						id = id + rows[i].id;
					}else{
						id = id + rows[i].id+','
					}
					
				}
				$.post('base/updstatue',{'id':id},function(jsonobj){
					$.messager.alert('system',jsonobj.message,'info');
					$('#grid').datagrid('load');
				},"json");
			}else{
				
				return ;
			}
		});
	}
	
	//工具栏
	var toolbar = [ {
		id : 'button-view',	
		text : '查询',
		iconCls : 'icon-search',
		handler : doView
	}, {
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-delete',
		text : '作废',
		iconCls : 'icon-cancel',
		handler : doDelete
	}];
	// 定义列
	var columns = [ [ {
		field : 'id',
		checkbox : true,
	},{
		field : 'name',
		title : '姓名',
		width : 120,
		align : 'center'
	}, {
		field : 'telephone',
		title : '手机号',
		width : 120,
		align : 'center'
	}, {
		field : 'haspda',
		title : '是否有PDA',
		width : 120,
		align : 'center',
		formatter : function(data,row, index){
			if(data=="1"){
				return "有";
			}else{
				return "无";
			}
		}
	}, {
		field : 'deltag',
		title : '是否作废',
		width : 120,
		align : 'center',
		formatter : function(data,row, index){
			if(data=="0"){
				return "正常使用"
			}else{
				return "已作废";
			}
		}
	}, {
		field : 'standard',
		title : '取派标准',
		width : 120,
		align : 'center'
	}, {
		field : 'station',
		title : '所谓单位',
		width : 200,
		align : 'center'
	} ] ];
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		// 取派员信息表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : false,
			rownumbers : true,
			striped : true,
			pageList: [10,30,50,100],
			pageSize:10,
			pagination : true,
			toolbar : toolbar,
			url : "base/findstaff",
			idField : 'id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		// 添加取派员窗口
		$('#addStaffWindow').window({
	        title: '添加取派员',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });
		//查询窗口
		$('#searchStaffWindow').window({
	        title: '查询取派员',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });
		$('#save').on('click',function(event){
    		event.preventDefault();
    		$("#ff").form('submit', {
    			url: 'base/addstaff',
    			onSubmit: function() {
    				return $("#ff").form('validate');   
    			}, 
    			success: function(data) {
    				//把json 字符串转成  json对象
    				var jsonObj = JSON.parse(data);
    				$.messager.alert('system', jsonObj.message, 'info');
    				$('#grid').datagrid('load');
    				$('#addStaffWindow').window("close");
    			}
    		});
    	});
		$('#btn').on('click',function(event){
    		event.preventDefault();
    		$('#grid').datagrid('load', {    
    			'keys':$('#keys').val()
    		});  
    		$('#searchStaffWindow').window("close");
    	})
	});
	function doDblClickRow(rowIndex, rowData){
		alert("双击表格数据...");
		
	};
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<!-- 查询 -->
	<div class="easyui-window" title="查询小区窗口" id="searchStaffWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div style="overflow:auto;padding:5px;" border="false">
			<form id="find" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">查询条件</td>
					</tr>
					<tr>
						<td>关键字</td>
						<td><input type="text" name="keys" id="keys" class='easyui-textbox'/></td>
					</tr>
					<tr>
						<td colspan="2"><a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> </td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 添加 -->
	<div class="easyui-window" title="对收派员进行添加或者修改" id="addStaffWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="ff" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">收派员信息</td>
					</tr>
					<!-- TODO 这里完善收派员添加 table -->
					<!-- <tr>
						<td>取派员编号</td>
						<td><input type="text" name="id" class="easyui-validatebox" required="true"/></td>
					</tr> -->
					<tr>
						<td>姓名</td>
						<td><input type="text" name="name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>手机</td>
						<td><input type="text" name="telephone" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>单位</td>
						<td><input type="text" name="station" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td colspan="2">
						<input type="checkbox" name="haspda" value="1" />
						是否有PDA</td>
					</tr>
					<tr>
						<td>取派标准</td>
						<td>
							<input type="text" name="standard" class="easyui-validatebox" required="true"/>  
						</td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>

</html>	