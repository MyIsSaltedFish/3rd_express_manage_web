<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+'/'%>">
<meta charset=UTF-8">
<title>管理承包区/调度排班</title>
<!-- 导入jquery核心类库 -->
<link rel="stylesheet" type="text/css" href="static/easyui15/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="static/easyui15/themes/icon.css">
<script type="text/javascript" src="static/easyui15/jquery.min.js"></script>
<script type="text/javascript" src="static/easyui15/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/easyui15/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	function doAdd(){
		$('#addDecidedzoneWindow').window("open");
	}
	
	function doEdit(){
		alert("修改...");
	}
	
	function doDelete(){
		alert("删除...");
	}
	
	function doSearch(){
		$('#searchWindow').window("open");
	}
	
	function doAssociations(){
		// 判断是否选中了一行
		var rows = $("#grid").datagrid("getSelections");
		if(rows.length!=1){
			$.messager.alert('提示','请选择一个承包区','warning');
			return;
		}else{
			//弹出选择菜单
			$('#customerWindow').window('open');
			//清理下拉框
			$("#noassociationSelect").empty();
			$("#associationSelect").empty();
			//发送ajax请求 获取没有绑定承包区客户
			var url_1 = "crm/findcusnoass";
			$.post(url_1,function(data){
				//遍历json数组
				for (var i = 0; i < data.length; i++) {
					var id = data[i].id;
					var name = data[i].name;
					var telephone = data[i].telephone;
					name = name + "("+telephone+")";
					$("#noassociationSelect").append("<option value='"+id+"'>"
						+name+"</option>");
				}
			});
			//发送ajax请求获取绑定承包区的客户
			var url_2 = "crm/findcusass";
			var data={"dzid":rows[0].id};
			$.post(url_2,data,function(data){
				//遍历json数组
				for (var i = 0; i < data.length; i++) {
					var id = data[i].id;
					var name = data[i].name;
					var telephone = data[i].telephone;
					name = name + "("+telephone+")";
					$("#associationSelect").append("<option value='"+id+"'>"
						+name+"</option>");
				}
			});
			$(function(){
				//为左右移动按钮绑定事件
				$("#toRight").click(function(){
					$("#associationSelect").append($("#noassociationSelect option:selected"));
				});
				$("#toLeft").click(function(){
					$("#noassociationSelect").append($("#associationSelect option:selected"));
				});
				
				//为关联客户按钮绑定事件
				$("#associationBtn").click(function(){
					var rows = $("#grid").datagrid("getSelections");
					var id = rows[0].id;
					//为隐藏域（存放定区id）赋值
					$("input[name=id]").val(id);
					//提交表单之前，需要将右侧下拉框中所有的选项选中,为option添加一个selected属性
					$("#associationSelect option").attr("selected","selected");
					$('#customerForm').form({    
					    url:"decidedzone/asscustomer",    
					   /*  onSubmit: function(){    
					    	   
					    }, */    
					    success:function(data){    
					    	var jsonObj = JSON.parse(data);
		    				$.messager.alert('system', jsonObj.message, 'info');
					    }    
					});    
					// submit the form    
					$('#customerForm').submit();  

				});
			});
		}
		
	}
	
	//工具栏
	var toolbar = [ {
		id : 'button-search',	
		text : '查询',
		iconCls : 'icon-search',
		handler : doSearch
	}, {
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-edit',	
		text : '修改',
		iconCls : 'icon-edit',
		handler : doEdit
	},{
		id : 'button-delete',
		text : '删除',
		iconCls : 'icon-cancel',
		handler : doDelete
	},{
		id : 'button-association',
		text : '关联客户',
		iconCls : 'icon-sum',
		handler : doAssociations
	}];
	// 定义列
	var columns = [ [ {
		field : 'id',
		title : '承包区编号',
		width : 120,
		align : 'center'
	},{
		field : 'name',
		title : '承包区名称',
		width : 120,
		align : 'center'
	}, {
		field : 'staff.name',
		title : '负责人',
		width : 120,
		align : 'center',
		formatter : function(data,row ,index){
			return row.staff.name;
		}
	}, {
		field : 'staff.telephone',
		title : '联系电话',
		width : 120,
		align : 'center',
		formatter : function(data,row ,index){
			return row.staff.telephone;
		}
	}, {
		field : 'staff.station',
		title : '所属公司',
		width : 120,
		align : 'center',
		formatter : function(data,row ,index){
			return row.staff.station;
		}
	} ] ];
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		// 收派标准数据表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : true,
			rownumbers : true,
			striped : true,
			pageList: [10,30,50,100],
			pageSize:10,
			pagination : true,
			toolbar : toolbar,
			url :"decided/find", 
				//"static/json/decidedzone.json",
			idField : 'id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		// 添加、修改承包区
		$('#addDecidedzoneWindow').window({
	        title: '添加修改承包区',
	        width: 600,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });
		
		// 查询承包区
		$('#searchWindow').window({
	        title: '查询承包区',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });
		$("#btn").click(function(){
			alert("执行查询...");
		});
		
	});

	function doDblClickRow(){
		alert("双击表格数据...");
		$('#association_subarea').datagrid( {
			fit : true,
			border : true,
			rownumbers : true,
			striped : true,
			url : "static/json/association_subarea.json",
			columns : [ [{
				field : 'id',
				title : '分拣编号',
				width : 120,
				align : 'center'
			},{
				field : 'province',
				title : '省',
				width : 120,
				align : 'center',
				formatter : function(data,row ,index){
					return row.region.province;
				}
			}, {
				field : 'city',
				title : '市',
				width : 120,
				align : 'center',
				formatter : function(data,row ,index){
					return row.region.city;
				}
			}, {
				field : 'district',
				title : '区',
				width : 120,
				align : 'center',
				formatter : function(data,row ,index){
					return row.region.district;
				}
			}, {
				field : 'addresskey',
				title : '关键字',
				width : 120,
				align : 'center'
			}, {
				field : 'startnum',
				title : '起始号',
				width : 100,
				align : 'center'
			}, {
				field : 'endnum',
				title : '终止号',
				width : 100,
				align : 'center'
			} , {
				field : 'single',
				title : '单双号',
				width : 100,
				align : 'center'
			} , {
				field : 'position',
				title : '位置',
				width : 200,
				align : 'center'
			} ] ]
		});
		$('#association_customer').datagrid( {
			fit : true,
			border : true,
			rownumbers : true,
			striped : true,
			url : "static/json/association_customer.json",
			columns : [[{
				field : 'id',
				title : '客户编号',
				width : 120,
				align : 'center'
			},{
				field : 'name',
				title : '客户名称',
				width : 120,
				align : 'center'
			}, {
				field : 'station',
				title : '所属单位',
				width : 120,
				align : 'center'
			}]]
		});
		
	}
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<div region="south" border="false" style="height:150px">
		<div id="tabs" fit="true" class="easyui-tabs">
			<div title="关联小区" id="subArea"
				style="width:100%;height:100%;overflow:hidden">
				<table id="association_subarea"></table>
			</div>	
			<div title="关联客户" id="customers"
				style="width:100%;height:100%;overflow:hidden">
				<table id="association_customer"></table>
			</div>	
		</div>
	</div>
	
	<!-- 添加 修改小区 -->
	<div class="easyui-window" title="承包区添加修改" id="addDecidedzoneWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div style="overflow:auto;padding:5px;" border="false">
			<form>
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">承包区信息</td>
					</tr>
					<tr>
						<td>承包区编码</td>
						<td><input type="text" name="id" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>承包区名称</td>
						<td><input type="text" name="name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>选择负责人</td>
						<td>
							<input class="easyui-combobox" name="region.id"  
    							data-options="valueField:'id',textField:'name',url:'static/json/standard.json'" />  
						</td>
					</tr>
					<tr height="300">
						<td valign="top">关联小区</td>
						<td>
							<table id="subareaGrid"  class="easyui-datagrid" border="false" style="width:300px;height:300px" data-options="url:'static/json/decidedzone_subarea.json',fitColumns:true,singleSelect:false">
								<thead>  
							        <tr>  
							            <th data-options="field:'id',width:30,checkbox:true">编号</th>  
							            <th data-options="field:'addresskey',width:150">关键字</th>  
							            <th data-options="field:'position',width:200,align:'right'">位置</th>  
							        </tr>  
							    </thead> 
							</table>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 查询承包区 -->
	<div class="easyui-window" title="查询承包区窗口" id="searchWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div style="overflow:auto;padding:5px;" border="false">
			<form>
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">查询条件</td>
					</tr>
					<tr>
						<td>承包区编码</td>
						<td><input type="text" name="id" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>所属单位</td>
						<td><input type="text" name="staff.station" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td colspan="2"><a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> </td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	<!-- 关联客户窗口 -->
	<div class="easyui-window" title="关联客户窗口" id="customerWindow" collapsible="false" closed="true" minimizable="false" maximizable="false" style="top:20px;left:200px;width: 400px;height: 300px;">
		<div style="overflow:auto;padding:5px;" border="false">
			<form id="customerForm" action="decidedzone/asscustomer" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="3">关联客户</td>
					</tr>
					<tr>
						<td>
							<input type="hidden" name="id" id="customerDecidedZoneId" />
							<select id="noassociationSelect" multiple="multiple" size="10"></select>
						</td>
						<td>
							<input type="button" value="》》" id="toRight"><br/>
							<input type="button" value="《《" id="toLeft">
						</td>
						<td>
							<select id="associationSelect" name="customerIds" multiple="multiple" size="10"></select>
						</td>
					</tr>
					<tr>
						<td colspan="3"><a id="associationBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'">关联客户</a> </td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>