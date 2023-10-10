package com.monstar.traffic.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.monstar.traffic.dto.SearchVo;
import com.monstar.traffic.service.RiderAccidentService;
import com.monstar.traffic.service.ServiceInterface;

//import com.google.gson.Gson;







@Controller
public class RiderAccidentController {
	
	ServiceInterface serviceI;
	
	@Autowired
	private SqlSession sqlSession;
	//@Autowired
	//RiderAccidentService ra;

	@RequestMapping("riderAccident")
	public String riderAccident(SearchVo keyWord,
			Model model) throws Exception {
		
	
		model.addAttribute("keyWord",keyWord);
		serviceI = new RiderAccidentService(sqlSession);
		serviceI.execute(model);

		
		return "common/rider/riderAccident";
		
	}
	

	@RequestMapping("riderAccident2")
	public String riderAccident2() {
		
		return "rider/riderAccident2";
		
	}	
	
}
