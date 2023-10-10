package com.monstar.traffic.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.monstar.traffic.dao.BikeDao;
import com.monstar.traffic.dto.BikeDto;

@RestController
@RequestMapping("/bike/*")
public class BikeRestController {
	
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/stationInfo")
	public ArrayList<BikeDto> stationInfo(HttpServletRequest request,Model model) {
		System.out.println("====stationInfo()====");
		
		BikeDao dao=sqlSession.getMapper(BikeDao.class);
		ArrayList<BikeDto> bikeStation = dao.stationInfo();
		
		return bikeStation;
	}
	
	@RequestMapping("/rentReturnChart")
	public JSONArray rentReturnChart(HttpServletRequest request,Model model) {
		System.out.println("====rentReturnChart()====");
		
		BikeDao dao=sqlSession.getMapper(BikeDao.class);
		String month = request.getParameter("pick");
		System.out.println("차트 년월 : "+month);
		
		JSONArray arr = new JSONArray();
		ArrayList<BikeDto> bikeStation = dao.rentCntMonth(month);
		for (BikeDto bike : bikeStation) {
			JSONObject obj = new JSONObject();
			obj.put("stationgrpname",bike.getStationgrpname());
			obj.put("rentsum",bike.getRentcnt());
			obj.put("returnsum",bike.getReturncnt());
			if(obj != null)
				arr.add(obj);
		}
		return arr;
	}
	@RequestMapping("/rentReturnMap")
	public JSONArray rentReturnMap(HttpServletRequest request,Model model) {
		System.out.println("====rentReturnMap()====");
		
		BikeDao dao=sqlSession.getMapper(BikeDao.class);
		String month = request.getParameter("month");
		String areaName = request.getParameter("areaName");
		System.out.println("지도 년월 : "+month);
		System.out.println("자치구 : "+areaName);
		
		JSONArray arr = new JSONArray();
		ArrayList<BikeDto> stationGroName = dao.stationGroName(month,areaName);
		for (BikeDto bike : stationGroName) {
			JSONObject obj = new JSONObject();
			obj.put("rentmap",bike.getRentcnt());
			obj.put("returnmap",bike.getReturncnt());
			if(obj != null)
				arr.add(obj);
		}
		return arr;
	}
}