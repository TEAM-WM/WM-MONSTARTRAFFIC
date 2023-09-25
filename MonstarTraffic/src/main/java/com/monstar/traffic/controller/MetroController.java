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

@Controller
@RequestMapping("/metro")
public class MetroController {

	@Autowired
	private SqlSession session;
	
	ServiceInterface service;
	
	@RequestMapping("/elevator")
	public String metroElevator(Model model) {
		service = new MetroElevatorService(session);
		service.execute(model);
		return "common/metro/elevator";
	}//method
	
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