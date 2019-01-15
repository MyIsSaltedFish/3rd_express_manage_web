package com.qf.express.manage.web.realm;

import java.util.List;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.qf.express.manage.client.RoleService;
import com.qf.express.manage.client.UserService;
import com.qf.express.manage.client.Users;


public class MyRealm extends AuthorizingRealm {
	
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	//授权
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection arg0) {
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		//获得当前登录用户对象
		Users user = (Users) arg0.getPrimaryPrincipal();
		//根据角色去查询权限
		List<String> list = roleService.findAuthorityTextByRoleid(user.getRoleid());
		info.addStringPermissions(list);
		return info;
	}

	//认证
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken arg0) throws AuthenticationException {
		System.out.println("开始认证了-----");
		UsernamePasswordToken token = (UsernamePasswordToken) arg0;
		List<Users> list = userService.findRrighttext(token.getUsername());
		if(list==null||list.size()==0) {
			return null;
		}
		//如果能查询到，再有框架比对数据库中查询到的密码和页面提交的密码是否一致
		AuthenticationInfo info = new SimpleAuthenticationInfo(list.get(0),list.get(0).getUpassword(),"MyRealm");
		return info;
	}

}
