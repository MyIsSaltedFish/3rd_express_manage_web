package com.qf.express.manage.web.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.qf.express.common.AppExcption;
import com.qf.express.manage.client.RoleService;
import com.qf.express.manage.client.Users;


public class AuthorityInterceptor implements HandlerInterceptor {

	@Autowired
	private RoleService roleService;
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2) throws Exception {
		// 获得请求地址
		String path = arg0.getServletPath();
		System.out.println("页面获得的路径："+path);
		// 获得当前用户的角色
		Users user = (Users) arg0.getSession().getAttribute("userinfo");
		// 根据角色的id获得当前角色拥有的地址集合
		List<String> list = roleService.findAuthorityByRoleid(user.getRoleid());
		System.out.println("数据库查询出的："+list);
		// 查询此次请求的地址 是否在集合中
		if(list.contains(path)==false) {
			throw new AppExcption(405,"权限不足！");
		}
		//放行
		return true;
	}

}
