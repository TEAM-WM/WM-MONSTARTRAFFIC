package com.monstar.traffic.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.MetroDao;
import com.monstar.traffic.dto.MetroElevatorDto;


public class MetroElevatorService implements ServiceInterface{
	
	@Autowired
	private SqlSession sqlSession;

	
	public MetroElevatorService() {}
	
	public MetroElevatorService(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}


	@Override
	public void execute(Model model) {
		MetroDao dao = sqlSession.getMapper(MetroDao.class);
		// 차트
//		JSONArray jsonArray = new JSONArray();
		ArrayList<MetroElevatorDto> dto = dao.list();

		ArrayList<JSONObject> jsonList = new ArrayList<JSONObject>(); // JSON 객체를 담을 리스트
		
		

		ArrayList<JSONObject> jsonList2 = new ArrayList<JSONObject>(); // JSON 객체를 담을 리스트
		for (MetroElevatorDto d : dto) {
			Map<Object, Object> map = new HashMap<>();
			map.put("type", d.getType());
			map.put("node_wkt", d.getNode_wkt());
			map.put("node_id", d.getNode_id());
			map.put("node_code", d.getNode_code());
			map.put("sgg_cd", d.getSgg_cd());
			map.put("sgg_nm", d.getSgg_nm());
			map.put("emd_cd", d.getEmd_cd());
			map.put("emd_nm", d.getEmd_nm());
			map.put("sw_cd", d.getSw_cd());
			map.put("sw_nm", d.getSw_nm());
			
			JSONObject obj = new JSONObject(map);
			jsonList.add(obj);
		} // for
		model.addAttribute("list", jsonList);
	}//method

}//service