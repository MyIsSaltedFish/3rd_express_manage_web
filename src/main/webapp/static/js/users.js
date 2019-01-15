//表格管理类
var dgManage={
	$dg:$("#dg"),
	//初始化表格
	initDg: function() {
	dgManage.$dg.datagrid({
		url: 'user/finduserbyinput',
		fitColumns: true,
		scrollbarSize: 0,
		rownumbers : true,
		toolbar: '#dgts',
		columns: [
				[{
					field: 'uid',
					title: '用户id',
					width: 100,
					checkbox: true
				},
				{
					field: 'uname',
					title: '用户名称',
					width: 100,
				},
				{
					field: 'utruename',
					title: '真实姓名',
					width: 100
				},
				{
					field: 'upassword',
					title: '密码',
					width: 100
				},
				{
					field: 'rolename',
					title: '角色名称',
					width: 100
				},
			]
		],
		pagination : true,
		pageSize : 4,
		pageList : [2, 4, 6, 8],
		fit: true
	});
}
}

//2 表格工具栏管理类
var dgtsManage={
	//查询
	search:function(event){
		event.preventDefault();
		dgManage.$dg.datagrid('load',{
			'uname':$("#uname").val()
		});
	},
	//删除
	del:function(event){
		event.preventDefault();
		//获得选中的行
		var rows = dgManage.$dg.datagrid('getChecked');
		//判断是否有选中的行
		if(rows.length<=0){
			$.messager.alert('system','请至少选中一行','info');
			return;
		}
		//2.1 ng-->提示 退出
		$.messager.confirm('确认对话框', '您想要删除吗？', function(r){
			if (r){
			    // 删除操作;
				var uids = '';
				for(var i=0;i<rows.length;i++){
					if(i==rows.length-1){
						uids = uids + rows[i].uid;
					}else{
						uids = uids + rows[i].uid+','
					}
					
				}
				$.post('user/deluserbychecked',{'uids':uids},function(jsonobj){
					$.messager.alert('system',jsonobj.message,'info');
					dgManage.initDg();
				},"json");
			}else{
				
				return ;
			}
		});
	},
	//修改
	upd:function(event){
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
		$("#uid").val(row.uid);
		//5.2 设置user名称
		$("#ustrname").textbox('setValue',row.uname);
		//5.3 设置真实姓名
		$("#reallyname").textbox('setValue',row.utruename);
		//5.4 设置用户密码
		$("#upassword").textbox('setValue',row.upassword);
		//5.5 设置角色下拉菜单
		myDialogManage.initComboBox();
		$("#combobox").textbox('setValue',row.rolename);
		dgManage.$dg.datagrid('reload');
	},
	//添加
	add:function(event){
	
		event.preventDefault();
		alert("sss");
//		$("#uid").val().clean();
		
		myDialogManage.$myDialog.dialog("setTitle",'添加窗口');
		
		myDialogManage.$myDialog.dialog("open");
		myDialogManage.initComboBox();
		$("#combobox").textbox('setValue',row.rolename);
		dgManage.$dg.datagrid('reload');
	}
}

//3 弹出的form的管理类
var myDialogManage={
	$myDialog:$("#myDialog"),
	//初始化form
	initForm:function(){
		myDialogManage.$myDialog.dialog({
			title:'添加和修改窗口',
			width:400,
			height:200,
			closed:true,
			modal:true,
			footer:"#divedit"
		});
	},
	initComboBox:function(){
		$('#combobox').combobox({    
			url:'users/createcombobox',  
		    valueField:'roleid',    
		    textField:'rolename'   
		});  
		
	},
	
	//点击ok
	clickOk: function(event) {
		event.preventDefault();
		myDialogManage.$myDialog.form('submit', {
			url: 'user/saveorupdateuser',
			success: function(data) {
				//把json 字符串转成  json对象
				var jsonObj = JSON.parse(data);
				$.messager.alert('system', jsonObj.message, 'info');
				if($("#uid").val()==null||$("#uid").val()==''){
					//在当前页的首行添加新行
					dgManage.$dg.datagrid('insertRow',{
						index:0,
						row:{
							uid:jsonObj.data.uid,
		        			uname:jsonObj.data.uname,
		        			upassword:jsonObj.data.upassword,
		        			utruename:jsonObj.data.utruename,
		        			rolename:jsonObj.data.rolename
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
		        			uid:jsonObj.data.uid,
		        			uname:jsonObj.data.uname,
		        			upassword:jsonObj.data.upassword,
		        			utruename:jsonObj.data.utruename,
		        			rolename:jsonObj.data.rolename
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


//4 初始化整个窗口
var windowManage={
	
	initWindow:function(){
		dgManage.initDg();
		//初始化弹出form
		myDialogManage.initForm();
	}
}

windowManage.initWindow();