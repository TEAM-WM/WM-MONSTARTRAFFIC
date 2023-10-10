package com.monstar.traffic.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.BikeDao;
import com.monstar.traffic.dto.BikeDto;

public class BikeUseService implements ServiceInterface {

	@Autowired
	private SqlSession sqlSession;

	public BikeUseService() {
	}

	public BikeUseService(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		System.out.println(">>>BikeUseService");
		
		BikeDao dao=sqlSession.getMapper(BikeDao.class);
		JSONArray arr = new JSONArray();
		ArrayList<BikeDto> bikeStation = dao.pRentCntMonth();
		for (BikeDto bike : bikeStation) {
			JSONObject obj = new JSONObject();
			obj.put("station",bike.getStationgrpname());
			obj.put("rentsum",bike.getRentcnt());
			obj.put("returnsum",bike.getReturncnt());
			if(obj != null)
				arr.add(obj);
		}
		model.addAttribute("arr",arr);	
	}// method

}// service