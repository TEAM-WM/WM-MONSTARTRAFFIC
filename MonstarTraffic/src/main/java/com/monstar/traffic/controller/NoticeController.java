package com.monstar.traffic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NoticeController {

//	@Autowired
//	private SqlSession sqlSession;

	@RequestMapping("/notice")
	public String notice(Model model) {
		return "common/notice/list";
	}//method
}//home