<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+'/'%>">
<link rel="stylesheet" href="static/easyui15/themes/bootstrap/easyui.css">
<link rel="stylesheet" href="static/easyui15/themes/icon.css">
<link rel="stylesheet" href="static/css/index.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="easyui-layout">
<!--欢迎 ${userinfo.uname}-->
    <div data-options="region:'north'" style="height:100px;background-color: #333333;">
    	<div class="login">cs分布式快递系统</div>
    	<div class="logout">
    		您好， ${userinfo.uname} | <a href="user/logout">退出</a>
    	</div>
    </div>   
    <div data-options="region:'south'" style="height:50px;">
    	<h2 style="text-align: center;">湖南科技学院 电子信息工程 电信1501 李育兴 毕业设计项目</h1>
    </div>    
    <div data-options="region:'west',title:'系统菜单',split:true,iconCls:'icon-world'" style="width:200px;">
    	<!--<p><a href="system/tousers">用户管理</a></p>
    	<p><a href="system/torole">角色管理</a></p>
    	<p><a href="system/toright">权限管理</a></p>-->
    	<div id="divacd" class="easyui-accordion" style="width:200px;">   
		      
		</div> 
    </div>   
   <div data-options="region:'center'">
    	<div id="cts" class="easyui-tabs" data-options="fit:true">   
		    <div data-options="title:'首页',iconCls:'icon-login'"
		     style="background-image: url('static/img/index_kd.jpg');background-repeat: no-repeat;background-size: 40%;">   
		            
		    </div>  
		     
		</div>  	
    </div> 
</body>
<script src="static/easyui15/jquery.min.js"></script>
<script src="static/easyui15/jquery.easyui.min.js"></script>
<script src="static/easyui15/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="https://cdn.goeasy.io/goeasy.js"></script>
<script src="static/js/index.js"></script>
<script>
//接收go-easy的推送信息
var goEasy = new GoEasy({
	appkey: 'BC-9377df7468b44f27b37dd0723f0c7b70'
});
goEasy.subscribe({
	channel: "ts_qj_"+${userinfo.roleid},
	onMessage: function (message) {
		$.messager.alert("info",message.content,"info");
	}
	 /* if(confirm(message.content)){			 
		 alert()
	  }  */     
});
$.messager.show({
	title:'系统消息',
	msg:'欢迎 ${userinfo.uname} 登陆',
	timeout:5000,
	showType:'slide'
});

</script>
</html> 