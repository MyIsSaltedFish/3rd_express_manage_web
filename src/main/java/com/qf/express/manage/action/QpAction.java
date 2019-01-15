package com.qf.express.manage.action;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qf.express.common.AppResult;
import com.qf.express.common.DataGridResult;
import com.qf.express.manage.client.BcStaff;
import com.qf.express.manage.client.QpNoticebill;
import com.qf.express.manage.client.QpService;
import com.qf.express.manage.client.Users;
import com.qf.express.message.client.MsgService;

@Controller
public class QpAction {
	
	@Autowired
	private QpService qpService;
	@Autowired
	private MsgService msgService;
	
	@RequestMapping("/qb/findnoass")
	@ResponseBody
	public DataGridResult<QpNoticebill> findnoass(){
		List<QpNoticebill> rows = qpService.findAllNoAss();
		DataGridResult<QpNoticebill> result = new DataGridResult<>();
		result.setRows(rows);
		return result;
	}
	
	@RequestMapping("/qb/findallstaff")
	@ResponseBody
	public List<BcStaff> findallstaff(){
	
		return qpService.findAllStaff();
	}
	
	@RequestMapping("/qb/updateqp")
	@ResponseBody
	public AppResult updateqp(QpNoticebill qp,String staffName,String staffPhone) throws Exception{
		System.out.println(qp);
		System.out.println(staffName + ":" + staffPhone);
		//设置 userid  type(null 没有分配  0 手动 1自动)
		qp.setOrdertype("0");
		Subject subject = SecurityUtils.getSubject();
		Users user = (Users) subject.getPrincipal();
		if(user!=null) {
			Integer uid = new Integer(user.getUid());
			qp.setUserId(uid);
		}
		
		
		qpService.updateForAss(qp);
		
		//发短息
		msgService.sendQjCms(staffPhone, staffPhone, qp.getPickaddress());
		return new AppResult(200, "人工分单成功", null);
	}
}
