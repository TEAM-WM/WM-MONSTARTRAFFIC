package com.monstar.traffic.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.monstar.traffic.service.HighwayService;
import com.monstar.traffic.service.ServiceInterface;

@Controller
@RequestMapping("/highway")
public class HighwayController {

	@Autowired
	private SqlSession session;

	ServiceInterface service;

	@RequestMapping("/highway")
	public String traffic(Model model) {
		System.out.println("====waysum()====");

		service = new HighwayService(session);
		service.execute(model);

		return "common/highway/highwaygraph";
	}// method

}// home