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
欢迎  ${userinfo.uname}
</body>
<script src="static/easyui15/jquery.min.js"></script>
<script src="static/easyui15/jquery.easyui.min.js"></script>
<script src="static/easyui15/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="static/js/index.js"></script>
<script type="text/javascript" src="https://cdn.goeasy.io/goeasy.js"></script>
<script>
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

/* $.messager.show({
	title:'系统消息',
	msg:'欢迎 ${userinfo.uname} 登陆',
	timeout:5000,
	showType:'slide'
});
 */
</script>
</html> 