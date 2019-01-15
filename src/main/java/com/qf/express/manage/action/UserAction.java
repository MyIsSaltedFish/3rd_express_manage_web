package com.qf.express.manage.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qf.express.common.AppResult;
import com.qf.express.common.DataGridResult;
import com.qf.express.common.TreeNode;
import com.qf.express.common.UserCombobox;
import com.qf.express.manage.client.Role;
import com.qf.express.manage.client.Rright;
import com.qf.express.manage.client.UserService;
import com.qf.express.manage.client.Users;

@Controller
public class UserAction {

	@Autowired
	private UserService userService;

	@RequiresPermissions("用户操作：查询角色下拉菜单")
	@RequestMapping(value = "/users/createcombobox", method = RequestMethod.POST)
	@ResponseBody
	public List<UserCombobox> findAllRole() {
		List<UserCombobox> list = userService.findAllRole();
		return list;
	}

	@RequiresPermissions("菜单权限管理：验证")
	@RequestMapping(value = "/user/checkrightname", method = RequestMethod.POST)
	@ResponseBody
	public Boolean checkrightname(String righttext) {

		return userService.checkrightname(righttext);
	}

	@RequiresPermissions("用户操作：添加/修改")
	@RequestMapping(value = "/user/saveorupdateuser", method = RequestMethod.POST)
	@ResponseBody
	public AppResult saveorupdateuser(Users user) {
		AppResult appResult = null;
		System.out.println(user);
		if (user.getUid() == null) {
			// 添加
			appResult = userService.addUser(user);
		} else {
			appResult = userService.updUser(user);
		}
		return appResult;
	}

	// 根据勾选的角色id 删除角色
	@RequiresPermissions("角色管理：删除")
	@RequestMapping(value = "/user/delrolesbychecked", method = RequestMethod.POST)
	@ResponseBody
	// page 就是要显示的第几页 rows 一页显示几条
	public AppResult delrolesbychecked(int[] roleids) {
		for (int i = 0; i < roleids.length; i++) {
			int j = roleids[i];
			userService.delrolesbychecked(j);
		}
		return new AppResult(200, "操作成功", null);
	}

	// 根据勾选的角色id 删除用户
	@RequiresPermissions("用户操作：删除")
	@RequestMapping(value = "/user/deluserbychecked", method = RequestMethod.POST)
	@ResponseBody
	// page 就是要显示的第几页 rows 一页显示几条
	public AppResult delusersbychecked(int[] uids) {
		for (int i = 0; i < uids.length; i++) {
			int j = uids[i];
			userService.delusersbychecked(j);
		}
		return new AppResult(200, "操作成功", null);
	}

	// 根据页面上传的角色id 和 爸爸id 获得树的节点的集合
	@RequiresPermissions("角色操作：查询权限树")
	@RequestMapping(value = "/user/createmenuforcurd", method = RequestMethod.POST)
	@ResponseBody
	public List<TreeNode> createmenuforcurd(Integer roleid, Integer id) {

		// 如果第一次上来id 为 null 说明为文件夹
		if (id == null) {
			id = 0;
		}
		List<TreeNode> nodes = new ArrayList<>();

		List<Rright> list = userService.findRRightsForCurd(roleid, id);
		for (Rright rright : list) {
			TreeNode node1 = new TreeNode();
			node1.setId(rright.getRightid());
			node1.setText(rright.getRighttext());
			// easyui tree 的 文件夹展现的问题 如果 里面有儿子 默认就是张开的 没有的儿子的话 就展示成了文件了 如果想要展现成文件夹 就需要
			// closed
			if (rright.getRighttype() == 0) {
				node1.setState("closed");
			} else {
				node1.setState("open");
			}
			if (rright.getHasflag() == 1) {
				node1.setChecked(false);
			} else {
				node1.setChecked(true);
			}
			nodes.add(node1);
		}

		return nodes;
	}

	@RequiresPermissions("角色管理：添加/修改")
	@RequestMapping(value = "/user/saveorupdaterole", method = RequestMethod.POST)
	@ResponseBody
	public AppResult saveorupdaterole(Role role) {
		AppResult result = null;
		System.out.println(role);
		if (role.getRoleid() == null) {
			// add
			result = userService.addRole(role);
		} else {
			// update
			System.out.println(role.getRightNames()+"-"+role.getRolename()+"-"+role.getRoleid()+"-"+role.getRights());
			result = userService.updRole(role);
		}

		return result;
	}

	// 加上shiro注解
	@RequiresPermissions("角色操作：查询")
	@RequestMapping(value = "/user/findrolebyinput", method = RequestMethod.POST)
	@ResponseBody
	// page 就是要显示的第几页 rows 一页显示几条
	public DataGridResult<Role> findARolesByInput(String rolename, int page, int rows) {
		return userService.findARolesByInput(rolename, page, rows);
	}

	@RequiresPermissions("用户操作：查询")
	@RequestMapping(value = "/user/finduserbyinput", method = RequestMethod.POST)
	@ResponseBody
	// page 就是要显示的第几页 rows 一页显示几条
	public DataGridResult<Users> findAUsersByInput(String uname, int page, int rows) {
		// return userService.findAUsersByInput(username, page, rows);
		System.out.println(uname);
		return userService.findAUsersByInput(uname, page, rows);
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public AppResult login(Users users, HttpSession session) {
		/*
		 * Users users2 = userService.findUsersForLogin(users.getUname(),
		 * users.getUpassword()); session.setAttribute("userinfo", users2); return new
		 * AppResult(200, null, null);
		 */
		// 1 获得subject (当前登录对象)
		Subject subject = SecurityUtils.getSubject();
		// 2 生成用户名和密码的令牌token
		UsernamePasswordToken token = new UsernamePasswordToken(users.getUname(), users.getUpassword());
		// 3 登录 （调用myrealm）中的认证方法
		subject.login(token);
		// 4 如果没有抛出异常 把当前用户放入session
		session.setAttribute("userinfo", (Users) subject.getPrincipal());

		return new AppResult(200, null, null);
	}

	@RequestMapping(value = "/user/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		/*
		 * session.invalidate(); return "login";
		 */
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return "login";
	}

	@RequestMapping(value = "/user/createmenu", method = RequestMethod.POST)
	@ResponseBody
	public AppResult login(HttpSession session) {
		// 1 获得当前的用户
		Users user = (Users) session.getAttribute("userinfo");
		// 2 去查询当前这个账户 能看到第一层菜单
		List<Rright> list = userService.findRRightsForMenu(user.getRoleid(), 0);
		return new AppResult(200, null, list);
	}

	@RequiresPermissions("菜单权限管理：添加/修改")
	@RequestMapping(value = "/user/saveorupdateright", method = RequestMethod.POST)
	@ResponseBody
	public AppResult saveorupdateright(Rright right) {
		System.out.println(right);
		userService.addOrUpdateRight(right);
		return new AppResult(200, "修改成功", null);
	}

	@RequestMapping(value = "/user/delrright", method = RequestMethod.POST)
	@ResponseBody
	public AppResult delchildrright(Integer rightid, Integer parentid) {
		System.out.println(rightid + ":" + parentid);
		/* userService.delchildrright(rightid, statue); */
		userService.delchildrright(rightid, parentid);
		return new AppResult(200, "修改成功", null);
	}

	/*
	 * @RequestMapping(value="/user/updateRightDnd",method=RequestMethod.POST)
	 * 
	 * @ResponseBody public AppResult updateRightDnd(Rright right) {
	 * System.out.println(right); userService.addOrUpdateRight(right); return new
	 * AppResult(200, "修改成功", null); }
	 */
	// @RequiresPermissions("菜单权限管理：查询树")
	@RequestMapping(value = "/user/createmenucurd", method = RequestMethod.POST)
	@ResponseBody
	public List<TreeNode> createmenucurd() {

		List<TreeNode> nodes1 = new ArrayList<TreeNode>();
		List<Rright> plist = userService.findRRightsForMenu(null, 0);
		// return new AppResult(200, null, list);
		for (Rright rright1 : plist) {
			TreeNode node1 = new TreeNode();
			node1.setId(rright1.getRightid());
			node1.setText(rright1.getRighttext());
			// easyui tree 的 文件夹展现的问题 如果 里面有儿子 默认就是张开的 没有的儿子的话 就展示成了文件了 如果想要展现成文件夹 就需要
			// closed
			// 文件 就没有问题
			if (rright1.getChild() == null || rright1.getChild().size() == 0) {
				node1.setState("closed");
			}

			Map<String, Object> attributes1 = new HashMap<>();
			attributes1.put("url", rright1.getRighturl());
			node1.setAttributes(attributes1);

			List<TreeNode> nodes2 = new ArrayList<TreeNode>();
			List<Rright> clist = rright1.getChild();
			for (Rright rright2 : clist) {
				TreeNode node2 = new TreeNode();
				node2.setId(rright2.getRightid());
				node2.setText(rright2.getRighttext());
				node2.setState("open");
				Map<String, Object> attributes = new HashMap<>();
				attributes.put("url", rright2.getRighturl());
				node2.setAttributes(attributes);
				nodes2.add(node2);
			}
			node1.setChildren(nodes2);
			nodes1.add(node1);
		}

		TreeNode znode = new TreeNode();
		znode.setId(0);
		znode.setText("系统菜单");
		znode.setChildren(nodes1);

		List<TreeNode> znodes = new ArrayList<>();
		znodes.add(znode);

		return znodes;
	}

}
