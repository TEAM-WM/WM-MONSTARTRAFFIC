package com.monstar.traffic.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.monstar.traffic.service.MetroElevatorService;
import com.monstar.traffic.service.MetroJamService;
import com.monstar.traffic.service.ServiceInterface;
//리연 작성 230920
@Controller
@RequestMapping("/metro")
public class MetroController {

	@Autowired
	private SqlSession session;
	
	ServiceInterface service;

// 지하철 엘레베이터 정보 :: 서울 열린데이터광장
// https://data.seoul.go.kr/dataList/OA-21212/S/1/datasetView.do
	@RequestMapping("/elevator")
	public String metroElevator(Model model) {
		service = new MetroElevatorService(session);
		service.execute(model);
		return "common/metro/elevator";
	}//method
	
//	지하철혼잡도정보 ::: 공공데이터포털 ::: csv 파일
//	https://www.data.go.kr/data/15071311/fileData.do#/tab-layer-openapi
	@RequestMapping("/jam")
	public String metroJam(Model model,@RequestParam (value = "station", required = false) String station,
									   @RequestParam (value = "line", required = false) String line) {
		service = new MetroJamService(session);
		model.addAttribute("departurestation",station);
		model.addAttribute("linename",line);
		service.execute(model);
		return "common/metro/jam";
	}//method
}//home