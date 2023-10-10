package com.monstar.traffic.controller;

import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.server.ResponseStatusException;

import com.monstar.traffic.service.AccidentStatsService;
import com.monstar.traffic.service.ServiceInterface2;

@Controller
@RequestMapping("/accident")
public class AccidentController {
	
	@Autowired
	private SqlSession sqlsession;
	
	ServiceInterface2 service;
	
	
	@RequestMapping("/{year}")
	public String accidentstats(Model model, @PathVariable("year") String year) {
		List<String> years = Arrays.asList("2019", "2020", "2021", "2022");
		if(!years.contains(year)) {
			//2019~2022 외의 값이 넘어옴
			//에러 페이지(코드) 리턴
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "잘못된 연도 입니다 다시 확인해 주세요");
		}
		service = new AccidentStatsService(sqlsession);
		service.execute(model, year);
		//System.out.println(year);
		return "common/accident/stats";
	}
	
}
