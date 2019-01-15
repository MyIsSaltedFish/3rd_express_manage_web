package com.qf.express.manage.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class InfoAction {
	
	@RequestMapping("/export/exportexcel")
	public String toexportexcel() {
		return "info/exportexcel";
	}
}
