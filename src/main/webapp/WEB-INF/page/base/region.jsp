<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+'/'%>">
<meta charset=UTF-8">
<title>区域设置</title>
<!-- 导入jquery核心类库 -->
<link rel="stylesheet" type="text/css" href="static/easyui15/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="static/easyui15/themes/icon.css">
<script type="text/javascript" src="static/easyui15/jquery.min.js"></script>
<script type="text/javascript" src="static/easyui15/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/easyui15/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="static/other/jquery.ocupload-1.1.2.js"></script>
<script type="text/javascript">
	function doAdd(){
		$('#addRegionWindow').window("open");
	}
	
	function doView(){
		alert("修改...");
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
				$.post('base/delregion',{'id':id},function(jsonobj){
					$.messager.alert('system',jsonobj.message,'info');
					$('#grid').datagrid('load');
				},"json");
			}else{
				
				return ;
			}
		});
	}
	//Excel上传
	function doImport(){
		$("#button-import").upload({
			name:'myfile',//上传主键的name属性，即<input type='file' name='file'/>
			action:'region/uploadregion',//请求路径
			enctype:'multipart/form-data',//mime类型，默认即可
			autoSubmit:true,//是否自动提交
			onComplete:function(jsonStr){
				//提交表单完成后触发的事件  文件上传成功 回调的事件
				var jsonData = JSON.parse(jsonStr);
				$.messager.alert("system", jsonData.message, "info");
				$('#grid').datagrid('load');
			},
			onSelect: function() {
				//当用户选择了一个文件后触发事件 经常用来验证文件的类型 和 大小
			}
		});
	}
	//Excel下载
	function doExport(){
		//同步
		window.location.href='region/downloadregion';
	}
	//工具栏
	var toolbar = [ {
		id : 'button-edit',	
		text : '修改',
		iconCls : 'icon-edit',
		handler : doView
	}, {
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-delete',
		text : '删除',
		iconCls : 'icon-cancel',
		handler : doDelete
	}, {
		id : 'button-import',
		text : '导入',
		iconCls : 'icon-redo',
		handler : doImport
	},{
		id : 'button-export',
		text : '导出',
		iconCls : 'icon-undo',
		handler : doExport
	}];
	// 定义列
	var columns = [ [ {
		field : 'id',
		checkbox : true,
	},{
		field : 'province',
		title : '省',
		width : 120,
		align : 'center'
	}, {
		field : 'city',
		title : '市',
		width : 120,
		align : 'center'
	}, {
		field : 'district',
		title : '区',
		width : 120,
		align : 'center'
	}, {
		field : 'postcode',
		title : '邮编',
		width : 120,
		align : 'center'
	}, {
		field : 'shortcode',
		title : '简码',
		width : 120,
		align : 'center'
	}, {
		field : 'citycode',
		title : '城市编码',
		width : 200,
		align : 'center'
	} ] ];
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		// 收派标准数据表格
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
			url : "region/findRegion",
			idField : 'id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		// 添加、修改区域窗口
		$('#addRegionWindow').window({
	        title: '添加修改区域',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });
		//执行添加
		$('#save').on('click',function(event){
    		event.preventDefault();
    		alert("保存");
    		$("#ff").form('submit', {
    			url: 'base/addregion',
    			onSubmit: function() {
    				return $("#ff").form('validate');   
    			}, 
    			success: function(data) {
    				//把json 字符串转成  json对象
    				var jsonObj = JSON.parse(data);
    				$.messager.alert('system', jsonObj.message, 'info');
    				$('#grid').datagrid('load');
    				$('#addRegionWindow').window("close");
    			}
    		});
    	})
		
	});

	function doDblClickRow(){
		alert("双击表格数据...");
	}
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<div class="easyui-window" title="区域添加修改" id="addRegionWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="ff" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">区域信息</td>
					</tr>
					<tr>
						<td>编号</td>
						<td><input type="text" name="id" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>省</td>
						<td><input type="text" name="province" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>市</td>
						<td><input type="text" name="city" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>区</td>
						<td><input type="text" name="district" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>邮编</td>
						<td><input type="text" name="postcode" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>简码</td>
						<td><input type="text" name="shortcode" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>城市编码</td>
						<td><input type="text" name="citycode" class="easyui-validatebox" required="true"/></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>