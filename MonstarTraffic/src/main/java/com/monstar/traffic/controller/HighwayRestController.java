package com.monstar.traffic.controller;

import java.util.ArrayList;

import javax.servlet.ServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.server.reactive.ServletHttpHandlerAdapter;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.monstar.traffic.dao.HighwayDao;
import com.monstar.traffic.dto.HighwayDto;
import com.monstar.traffic.service.ServiceInterface;

@RestController
@RequestMapping("/refresh*")
public class HighwayRestController {

	@Autowired
	private SqlSession session;
	
	ServiceInterface service;
	
	@GetMapping("/waydata")

	public JSONArray execute(ServletRequest request, Model model) {
		System.out.println(">>> RestController >>>");
		
		HighwayDao dao=session.getMapper(HighwayDao.class);
		
		String way = request.getParameter("selWay");
		System.out.println("selWay:"+way);
		
        JSONArray arr2 = new JSONArray();
		ArrayList<HighwayDto> avgmonth = dao.avgSpeedbyMonth01(way);
		for(HighwayDto month : avgmonth) {
			JSONObject obj2 = new JSONObject();
			obj2.put("month", month.getMonth());
			obj2.put("avgspeed", month.getAvgspeed());
			obj2.put("way", month.getWay());
			if(obj2 != null) {
				arr2.add(obj2);
			}
		}
		System.out.println("arr2: "+arr2);
//		model.addAttribute("arr2", arr2);	
		
		return arr2;
    }
	
}//home
