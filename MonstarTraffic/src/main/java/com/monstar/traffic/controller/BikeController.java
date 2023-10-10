package com.monstar.traffic.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.monstar.traffic.service.BikeUseService;
import com.monstar.traffic.service.BikeNoticeService;
import com.monstar.traffic.service.BikeNoticeDetailService;
import com.monstar.traffic.service.ServiceInterface;
import com.monstar.traffic.vopage.SearchVO;

@Controller
@RequestMapping("/bike")
public class BikeController {

	@Autowired
	private SqlSession session;
	
	ServiceInterface service;
	
	// 대여소 정보
	@RequestMapping("/bikeStationInfo")
	public String bikeStationInfo(Model model) {
		
		return "common/bike/bikeStationInfo";
	}//method
	
	// 이용 정보
	@RequestMapping("/bikeUse")
	public String bikeUse(Model model) {
		service = new BikeUseService(session);
		service.execute(model);
		
		return "common/bike/bikeUse";
	}//method
	
	// 공지사항 리스트
	@RequestMapping("/bikeNotice")
	public String bikenotice(HttpServletRequest request,
			SearchVO searchVO, Model model) {
		model.addAttribute("request", request);
		model.addAttribute("searchVO", searchVO);
		
		service = new BikeNoticeService(session);
		service.execute(model);
		
		return "common/bike/bikeNotice";
	}//method
	
	// 공지사항 디테일
	@RequestMapping("/bikeNoticeDetail")
	public String bikeNoticeView(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		
		service = new BikeNoticeDetailService(session);
		service.execute(model);
		
		return "common/bike/bikeNoticeDetail";
	}//method
	
}//home