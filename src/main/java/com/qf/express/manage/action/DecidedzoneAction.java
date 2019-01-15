package com.qf.express.manage.action;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qf.express.common.AppResult;
import com.qf.express.common.DataGridResult;
import com.qf.express.crm.client.CustomerService;
import com.qf.express.crm.client.TCustomer;
import com.qf.express.manage.client.BcDecidedzone;
import com.qf.express.manage.client.DecidedzoneService;


@Controller
public class DecidedzoneAction {
	
	@Autowired
	private DecidedzoneService decidedzoneService;
	@Autowired
	private CustomerService customerService;
	@RequestMapping(value="/decided/find",method=RequestMethod.POST)
	@ResponseBody
	public DataGridResult<BcDecidedzone> findDecidedzone(Integer rows,Integer page){
		
		return decidedzoneService.findDecidedzone(rows, page);
	}
	
	@RequestMapping(value="/crm/findcusnoass",method=RequestMethod.POST)
	@ResponseBody
	public List<TCustomer> findcusnoass(){
		
		return customerService.findCustomerNoAss();
	}
	@RequestMapping(value="/crm/findcusass",method=RequestMethod.POST)
	@ResponseBody
	public List<TCustomer> findcusass(String dzid){
		System.out.println(dzid);
		return customerService.findCustomerAss(dzid);
	}
	@RequestMapping(value="/decidedzone/asscustomer",method=RequestMethod.POST)
	@ResponseBody
	public AppResult asscustomer(Integer[] customerIds,String id){
		List<Integer> list = new ArrayList<>();
		if(customerIds.length!=0&&customerIds!=null) {
			for (int i = 0; i < customerIds.length; i++) {
				list.add(customerIds[i]);
			}
			for (Integer integer : list) {
				System.out.println(integer);
			}
		}
		
		return customerService.customerAss(list, id);
	}
}
