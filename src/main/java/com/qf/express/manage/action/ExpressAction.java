package com.qf.express.manage.action;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qf.express.common.AppResult;
import com.qf.express.common.DataGridResult;
import com.qf.express.manage.client.BcStaff;
import com.qf.express.manage.client.ExpressService;
@Controller
public class ExpressAction {

	@Autowired
	private ExpressService expressService;

	// 查询所有快递员
	@RequiresPermissions("取派员管理：查询")
	@RequestMapping(value = "/base/findallstaff", method = RequestMethod.POST)
	@ResponseBody
	public DataGridResult<BcStaff> findAllStacff(Integer page, Integer rows) {

		return expressService.findAllStacff(page, rows);
	}

	@RequestMapping(value = "/base/findstaff", method = RequestMethod.POST)
	@ResponseBody
	public DataGridResult<BcStaff> findStacff(Integer page, Integer rows, String keys) {
		System.out.println("page:" + page + "   rows:" + rows + "  keys:" + keys);
		return expressService.findStacff(page, rows, keys);
	}

	// 添加快递员
	@RequiresPermissions("取派员管理：添加")
	@RequestMapping(value = "/base/addstaff", method = RequestMethod.POST)
	@ResponseBody
	public AppResult addStaff(BcStaff staff) {
		System.out.println(staff);
		staff.setId(null);
		AppResult appResult = expressService.addStaff(staff);
		return appResult;
	}

	// 修改快递员状态
	@RequiresPermissions("取派员管理：废除")
	@RequestMapping(value = "/base/updstatue", method = RequestMethod.POST)
	@ResponseBody
	public AppResult updStatueStaff(Integer[] id) {
		System.out.println(id);
		AppResult appResult = expressService.updStaff(id);
		return appResult;
	}
}
