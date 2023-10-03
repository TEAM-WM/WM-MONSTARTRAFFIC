package com.monstar.traffic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
//리연 작성 230920
@Controller
public class NoticeController {

//	@Autowired
//	private SqlSession sqlSession;

	@RequestMapping("/notice")
	public String notice(Model model) {
		return "common/notice/list";
	}//method
}//home