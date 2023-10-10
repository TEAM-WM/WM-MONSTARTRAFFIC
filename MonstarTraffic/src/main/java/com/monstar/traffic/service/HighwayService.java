package com.monstar.traffic.service;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.HighwayDao;
import com.monstar.traffic.dto.HighwayDto;


public class HighwayService implements ServiceInterface {

	@Autowired
	private SqlSession session;

	public HighwayService() {
	}

	public HighwayService(SqlSession session) {
		this.session = session;
	}

	@Override
	public void execute(Model model) {
		System.out.println(">>> WAYCOUNT SERVICE >>>");
		
		HighwayDao dao=session.getMapper(HighwayDao.class);
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		JSONArray arr = new JSONArray();
		ArrayList<HighwayDto> waysum = dao.sumCountByWay();
		for (HighwayDto way : waysum) {
			JSONObject obj = new JSONObject();
			obj.put("way", way.getWay());
			obj.put("way_sum", way.getWay_sum());
			if(obj != null){
				arr.add(obj);
			}
		}
		
		
//		String selWay = request.getParameter("selWay");
//		System.out.println("selWay:"+selWay);
		
		JSONArray arr2 = new JSONArray();
		ArrayList<HighwayDto> avgmonth = dao.avgSpeedbyMonth00();
		for(HighwayDto month : avgmonth) {
			JSONObject obj2 = new JSONObject();
			obj2.put("month", month.getMonth());
			obj2.put("avgspeed", month.getAvgspeed());
			obj2.put("way", month.getWay());
			if(obj2 != null) {
				arr2.add(obj2);
			}
		}
				
			
		model.addAttribute("arr", arr);	
		model.addAttribute("arr2", arr2);	
	}

}// service