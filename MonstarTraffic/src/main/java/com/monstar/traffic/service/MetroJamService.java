package com.monstar.traffic.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.monstar.traffic.dao.MetroDao;
import com.monstar.traffic.dto.MetroJamDto;
//리연 작성 230920
public class MetroJamService implements ServiceInterface {

	@Autowired
	private SqlSession sqlSession;

	public MetroJamService() {
	}

	public MetroJamService(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		MetroDao dao = sqlSession.getMapper(MetroDao.class);
		ArrayList<JSONObject> jsonList = new ArrayList<JSONObject>(); // JSON 객체를 담을 리스트
		
		MetroJamDto dto = new MetroJamDto();
//		DEPARTURESTATION=#{departurestation} AND LINENAME=#{linename}
		Map<String, Object> asMap = model.asMap();
		String departurestation= (String) asMap.get("departurestation");
		String line = (String)asMap.get("linename");
		int linename=0;
		if(line==null) {
			linename=1;
		}else {
			linename=Integer.parseInt(line);
		}
		if(departurestation == null) {
			departurestation="서울역";
		}
		
		dto.setDeparturestation(departurestation);
		dto.setLinename(linename);
		ArrayList<MetroJamDto> list = dao.listJam(dto);
		ArrayList<MetroJamDto> linelist = dao.listJamLine(dto);
		ArrayList<MetroJamDto> lineHighlist = dao.listJamLineHigh(dto);
		ArrayList<MetroJamDto> lineHighlistALL = dao.listJamLineHighALL();
		for (MetroJamDto d : list) {
			Map<Object, Object> map = new HashMap<>();
			map.put("serial_number", d.getSerial_number());
			map.put("dayofweekdivision", d.getDayofweekdivision());
			map.put("linename", d.getLinename());
			map.put("externalstationcode", d.getExternalstationcode());
			map.put("departurestation", d.getDeparturestation());
			map.put("divisionname", d.getDivisionname());
			map.put("time0", d.getAm05_30());
			map.put("time1", d.getAm06_00());
			map.put("time2", d.getAm06_30());
			map.put("time3", d.getAm07_00());
			map.put("time4", d.getAm07_30());
			map.put("time5", d.getAm08_00());
			map.put("time6", d.getAm08_30());
			map.put("time7", d.getAm09_00());
			map.put("time8", d.getAm09_30());
			map.put("time9", d.getAm10_00());
			map.put("time10", d.getAm10_30());
			map.put("time11", d.getAm11_00());
			map.put("time12", d.getAm11_30());
			map.put("time13", d.getPm12_00());
			map.put("time14", d.getPm12_30());
			map.put("time15", d.getPm13_00());
			map.put("time16", d.getPm13_30());
			map.put("time17", d.getPm14_00());
			map.put("time18", d.getPm14_30());
			map.put("time19", d.getPm15_00());
			map.put("time20", d.getPm15_30());
			map.put("time21", d.getPm16_00());
			map.put("time22", d.getPm16_30());
			map.put("time23", d.getPm17_00());
			map.put("time24", d.getPm17_30());
			map.put("time25", d.getPm18_00());
			map.put("time26", d.getPm18_30());
			map.put("time27", d.getPm19_00());
			map.put("time28", d.getPm19_30());
			map.put("time29", d.getPm20_00());
			map.put("time30", d.getPm20_30());
			map.put("time31", d.getPm21_00());
			map.put("time32", d.getPm21_30());
			map.put("time33", d.getPm22_00());
			map.put("time34", d.getPm22_30());
			map.put("time35", d.getPm23_00());
			map.put("time36", d.getPm23_30());
			map.put("time37", d.getAm00_00());
			map.put("time38", d.getAm00_30());

			JSONObject obj = new JSONObject(map);
			jsonList.add(obj);
		} // for
//		System.out.println(jsonList.toString());
		model.addAttribute("list", jsonList);
		model.addAttribute("linelist",linelist);
		model.addAttribute("lineHighlist",lineHighlist);
		model.addAttribute("lineHighlistALL",lineHighlistALL);
	}// method

}// service