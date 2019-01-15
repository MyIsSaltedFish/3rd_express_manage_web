//1 表格管理类
var dgManage = {
	$dg : $('#dg'),
	// 初始化表格
	initDg : function() {
		dgManage.$dg.datagrid({
			url : 'user/findrolebyinput',
			
			fitColumns : true,
			scrollbarSize : 0,
			rownumbers : true,
			toolbar:'#dgts',
			columns : [ [ {
				field : 'roleid',
				title : '角色id',
				width : 1,
				checkbox : true
			}, {
				field : 'rolename',
				title : '角色名称',
				width : 1
			} , {
				field : 'rightNames',
				title : '拥有的权限',
				width : 10,
				formatter:function(value,row,index){
					/*if(row.roleid==1){
						return "<strong>[" + value + "]</strong>";
					}
					return "[" + value + "]";*/
					return "<strong>[" + value + "]</strong>";
				}
			}] ],
			pagination : true,
			pageSize : 3,
			pageList : [ 3, 5, 10, 20 ],
			fit : true
		});
	}
}

// 2 表格工具栏管理类
var dgtsManager={
	//查询
	search:function(event){
		event.preventDefault();
		dgManage.$dg.datagrid('load', {    
			'rolename':$('#rname').val()
		});  

	},
	//修改
	upd:function(event) {
		event.preventDefault();
		//1 获得选中的行
		var rows = dgManage.$dg.datagrid('getChecked');
		
		//2 判断选中的行是否只有一行
		if(rows.length!=1){
			$.messager.alert('system','一次只能修改一行','info');
			return;
		}
		//3 弹出form表单修改 选中行
		myDialogManage.$myDialog.dialog("open");
		//4 设置标题
		myDialogManage.$myDialog.dialog("setTitle",'更新窗口');
		//5 获取datagrid中选中的行对象
		var row = rows[0];
		//5.1 设置id
		$("#roleid").val(row.roleid);
		//5.2 设置角色名称
		$("#rolename").textbox('setValue',row.rolename);
		//5.3 设置下拉树
		myDialogManage.initTree(row.roleid);
	},
	//添加
	add:function(event) {
		event.preventDefault();
		//1 设置标题
		myDialogManage.$myDialog.dialog("setTitle",'添加窗口');
		//2弹出form表单
		myDialogManage.$myDialog.dialog("open");
		//3 设置下拉树
		myDialogManage.initTree(-1);
	},
	//删除
	del:function(event){
		event.preventDefault();
		//1 获得选中的行
		var rows = dgManage.$dg.datagrid('getChecked');
		//2 判断是否有选中的行
		if(rows.length<=0){
			$.messager.alert('system','请至少选中一行','info');
			retrun;
		}
		//2.1 ng-->提示 退出
		$.messager.confirm('确认对话框', '您想要删除吗？', function(r){
			if (r){
			    // 删除操作;
				var roleids = '';
				for(var i=0;i<rows.length;i++){
					if(i==rows.length-1){
						roleids = roleids + rows[i].roleid;
					}else{
						roleids = roleids + rows[i].roleid+','
					}
					
				}
				$.post('user/delrolesbychecked',{'roleids':roleids},function(jsonobj){
					$.messager.alert('system',jsonobj.message,'info');
					dgManage.initDg();
				},"json");
			}else{
				
				return ;
			}
		});


		
		
	},
	
}

//3 弹出的form的管理类
var myDialogManage = {
	$myDialog: $("#myDialog"),
	//初始form
	initForm: function() {
		myDialogManage.$myDialog.dialog({
			title: '添加和修改窗口',
			width: 400,
			height: 200,
			closed: true,
			modal: true,
			footer: "#divedit"
		});
	},
	//根据角色id渲染form中的下拉树
	initTree:function(roleid){
		$('#rights').combotree({
			url:'user/createmenuforcurd?roleid='+roleid,
			checkbox:true,
			multiple:true,
			cascadeCheck:false,
			onLoadSuccess:function(node,data){
				//获得下拉树菜单中的树空件
				var $tree = $('#rights').combotree('tree');
		    	$tree.tree('expandAll');
			},
			onCheck:function(node,checked){
				var $tree = $('#rights').combotree('tree');
				//获得当前节点的父亲节点
				var pnode = $tree.tree('getParent',node.target);
				//获得当前节点的儿子节点的集合
				var cnodes = $tree.tree('getChildren',node.target);
				//如果勾选的是父亲
				if($tree.tree('isLeaf',node.target)==false){
					for(var i=0;i<cnodes.length;i++){
						$tree.tree('update',{
							target: cnodes[i].target,
							checked: checked
						});
					}
				}else{//如果勾选的是儿子
					if(checked){
						$tree.tree('update',{
							target: pnode.target,
							checked: true
						});
					}else{
						//获得兄弟 就是爸爸的儿子
						var xdnodes = $tree.tree('getChildren',pnode.target);
						//爸爸取消选中
						var flag = false;
						for(var i=0;i<xdnodes.length;i++){
							if(xdnodes[i].checked==true){
								flag = true;
								break;
							}
						}
						$tree.tree('update',{
							target: pnode.target,
							checked: flag
						});
					}
				}
				//清空全局变量windowManage。rightnames  rightids
				windowManage.rightnames = '';
				windowManage.rightids = new Array();
				//获得当前书上面 所有被勾选节点
				var cnodes = $tree.tree('getChecked');
				for(var i=0;i<cnodes.length;i++){
					windowManage.rightids.push(cnodes[i].id);
					if(i==cnodes.length-1){
						windowManage.rightnames+=cnodes[i].text;
					}else{
						windowManage.rightnames+=cnodes[i].text+',';
					}
				}
				$('#rights').combotree('setText',windowManage.rightnames);
				$('#rights').combotree('setValue',windowManage.rightids);
				
			}
		});

	},
	
	//点击ok
	clickOk: function(event) {
		event.preventDefault();
		myDialogManage.$myDialog.form('submit', {
			url: 'user/saveorupdaterole',
			success: function(data) {
				//把json 字符串转成  json对象
				var jsonObj = JSON.parse(data);
				$.messager.alert('system', jsonObj.message, 'info');
				if($("#roleid").val()==null||$("#roleid").val()==''){
					//在当前页的首行添加新行
					dgManage.$dg.datagrid('insertRow',{
						index:0,
						row:{
							roleid:jsonObj.data.roleid,
		        			rolename:jsonObj.data.rolename,
		        			rightNames:windowManage.rightnames
						}
					});
					
					// 高亮选中新行
					dgManager.$dg.datagrid('highlightRow',0);
				}else{
					alert(windowManage.rightnames);
					//获得当前选中行的行号
		        	var crows = dgManage.$dg.datagrid('getChecked');
		        	var index = dgManage.$dg.datagrid('getRowIndex',crows[0]);
		        	dgManage.$dg.datagrid('updateRow',{
		        		index: index,
		        		row: {
		        			roleid:jsonObj.data.roleid,
		        			rolename:jsonObj.data.rolename,
		        			rightNames:windowManage.rightnames
		        		}
		        	});
				}
				//关闭窗口
				myDialogManage.$myDialog.dialog('close');
			}

		});
	},
	//点击取消
	clickCancel: function(event) {
		event.preventDefault();
		myDialogManage.$myDialog.dialog('close');
	}
}
// 4 整个窗口
var windowManage={
	rightnames:'',
	rightids:null,
	initWindow:function(){
		dgManage.initDg();
		//初始form
		myDialogManage.initForm();
	}
}

windowManage.initWindow();
