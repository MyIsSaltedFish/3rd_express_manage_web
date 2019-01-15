<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+'/'%>">
<link rel="stylesheet" href="static/easyui15/themes/bootstrap/easyui.css">
<link rel="stylesheet" href="static/easyui15/themes/icon.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul id="tt"></ul>
</body>

<script src="static/easyui15/jquery.min.js"></script>
<script src="static/easyui15/jquery.easyui.min.js"></script>
<script src="static/easyui15/locale/easyui-lang-zh_CN.js"></script>
	<script>
		$("#tt").tree({
			url:'user/createmenuforcurd?roleid=6',
			checkbox:true,
			cascadeCheck:false,
			onLoadSuccess:function(node, data){
				$("#tt").tree('expandAll');
			},
			onCheck:function(node,checked){
				//获得当前节点的父亲节点
				var pnode = $("#tt").tree('getParent',node.target);
				//获得当前节点的儿子节点的集合
				var cnodes = $("#tt").tree('getChildren',node.target);
				//如果勾选的是父亲
				if($("#tt").tree('isLeaf',node.target)==false){
					for(var i=0;i<cnodes.length;i++){
						$("#tt").tree('update',{
							target: cnodes[i].target,
							checked: checked
						});
					}
				}else{//如果勾选的是儿子
					if(checked){
						$("#tt").tree('update',{
							target: pnode.target,
							checked: true
						});
					}else{
						//获得兄弟 就是爸爸的儿子
						var xdnodes = $("#tt").tree('getChildren',pnode.target);
						//爸爸取消选中
						var flag = false;
						for(var i=0;i<xdnodes.length;i++){
							if(xdnodes[i].checked==true){
								flag = true;
								break;
							}
						}
						$("#tt").tree('update',{
							target: pnode.target,
							checked: flag
						});
					}
				}
			}
		});
	</script>
</html> 